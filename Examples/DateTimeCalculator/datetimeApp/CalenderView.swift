//
//  CalenderView.swift
//  datetimecalculator
//
//  Created by Robert Dodson on 3/2/24.
//
import Foundation
import SwiftUI

import Time


struct CalenderView: View
{
    @Binding var selectedSecond : Fixed<Second>
   
    var color = Color.white
    
    @State var selectedMonth = Clocks.system.currentMonth
    @State var selectedDay = Clocks.system.currentDay
    @State var monthName = Clocks.system.currentMonth.format(month:.naturalName)

    let consistentNumberOfWeeks = true
    
    
    var body: some View
    {
        VStack
        {
            calendarView
            ClockView(selectedSecond: $selectedSecond)
        }
        .onAppear()
        {
            update()
        }
        .onChange(of: selectedSecond)
        { oldValue, newValue in
            selectedSecond = newValue
            update()
        }
    }
    
    
    func update()
    {
        selectedMonth = selectedSecond.fixedMonth
        monthName = selectedMonth.format(month:.naturalName)
        selectedDay = selectedSecond.fixedDay
    }
    
    
    func setdate(day:Fixed<Day>,month:String)
    {
        do
        {
            selectedSecond = try Fixed<Second>(region: .current,
                                               year: selectedSecond.year,
                                               month: try Fixed<Month>(stringValue: month, rawFormat: "MMMM", region: Region.current).month,
                                               day: day.day,
                                               hour: selectedSecond.hour,
                                               minute: selectedSecond.minute,
                                               second: selectedSecond.second)
        }
        catch
        {
            print("setdate error: \(error)")
        }
    }
   
    
   
    private var weeksForCurrentMonth: Array<[Fixed<Day>]>
    {
        var allDays = Array(selectedMonth.days)
        
        // pad out the front of the array with any additional days
        while allDays[0].dayOfWeek != selectedMonth.calendar.firstWeekday
        {
            allDays.insert(allDays[0].previous, at: 0)
        }
        
        if consistentNumberOfWeeks
        {
            // Apple Calendar shows 6 weeks at a time, so all views have the same vertical height
            // this eliminates complexity around dynamically resizing the month view
            while allDays.count < 42
            {
                allDays.append(allDays.last!.next)
            }
        }
        else
        {
            repeat
            {
                let proposedNextDay = allDays.last!.next
                if proposedNextDay.dayOfWeek != selectedMonth.calendar.firstWeekday
                {
                    allDays.append(proposedNextDay)
                }
                else
                {
                    break
                }
            } while true
        }
        
        // all supported calendars have weeks of seven days
        assert(allDays.count.isMultiple(of: 7))
        
        // slice the array into groups of seven
        let numberOfWeeks = allDays.count / 7
        
        return (0 ..< numberOfWeeks).map
        { weekNumber in
            let dayRange = (weekNumber * 7) ..< ((weekNumber + 1) * 7)
            return Array(allDays[dayRange])
        }
    }
    
    
    private var calendarView: some View
    {
        let weeks = self.weeksForCurrentMonth
        
        return VStack {
            
            // current month + movement controls
            HStack
            {
                // month picker
                Picker("", selection: $monthName)
                {
                    ForEach(Calendar.current.monthSymbols, id: \.self)
                    { month in
                        Text("\(month)")
                            .foregroundColor(color)
                    }
                }
                .pickerStyle(.automatic)
                .frame(width: 120)
                .onChange(of: monthName)
                { oldValue, newValue in
                    setdate(day:selectedSecond.fixedDay,month:newValue)
                    update()
                }
                
                // year stepper
                Stepper
                {
                    Text("\(selectedSecond.year.description)")
                        .foregroundColor(color)
                }
                onIncrement:
                {
                    selectedSecond = selectedSecond.nextYear
                    update()
                }
                onDecrement:
                {
                    selectedSecond = selectedSecond.previousYear
                    update()
                }
                
                Spacer()
                
                // Month back
                Button(action:
                {
                    selectedSecond = selectedSecond.previousMonth
                    update()
                })
                {
                    Image(systemName: "arrowtriangle.backward.fill")
                }
                
                // Month today
                Button(action:
                {
                    selectedSecond = Clocks.system.currentSecond
                    update()
                })
                {
                    Text("Today")
                }
                
                // month forward
                Button(action:
                {
                    selectedSecond = selectedSecond.nextMonth
                    update()
                })
                {
                    Image(systemName: "arrowtriangle.forward.fill")
                }
            }
           
            
            // weekday name headers
            HStack
            {
                ForEach(weeks[0], id: \.self)
                { day in
                    Text(day.format(weekday: .abbreviatedName))
                        .fixedSize() // prevent the text from wrapping
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .font(.subheadline)
            
            Divider()
            
            // weeks
            ForEach(weeks, id: \.self) 
            { week in
                HStack
                {
                    ForEach(week, id: \.self) 
                    { theday in
                        Toggle(isOn: Binding(get: { selectedDay == theday },
                                             set: { _ in setdate(day:theday, month:monthName);update() }))
                        {
                            Text(theday.format(day: .naturalDigits))
                                .fixedSize() // prevent the text from wrapping
                                .monospacedDigit()
                                .opacity(theday.month == selectedMonth.month ? 1.0 : 0.2)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .toggleStyle(DayToggleStyle())
                    }
                }
            }
        }
    }
}


struct DayToggleStyle: ToggleStyle
{
    func makeBody(configuration: Configuration) -> some View
    {
        Button(action: { configuration.$isOn.wrappedValue = !configuration.isOn })
        {
            configuration.label
                .foregroundStyle(configuration.isOn ? AnyShapeStyle(.selection) : AnyShapeStyle(.primary))
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background 
        {
            if configuration.isOn 
            {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.accentColor)
            }
        }
    }
    
}
