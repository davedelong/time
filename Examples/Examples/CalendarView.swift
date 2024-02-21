//
//  CalendarView.swift
//  Examples
//

import Foundation
import SwiftUI
import Time

struct CalendarView: View {
    
    @State var currentMonth = Clocks.system.currentMonth
    @State var selectedDay: Fixed<Day>?
    
    @State var consistentNumberOfWeeks = false
    
    private var weeksForCurrentMonth: Array<[Fixed<Day>]> {
        var allDays = Array(currentMonth.days)
        
        // pad out the front of the array with any additional days
        while allDays[0].dayOfWeek != currentMonth.calendar.firstWeekday {
            allDays.insert(allDays[0].previous, at: 0)
        }
        
        if consistentNumberOfWeeks {
            // Apple Calendar shows 6 weeks at a time, so all views have the same vertical height
            // this eliminates complexity around dynamically resizing the month view
            while allDays.count < 42 {
                allDays.append(allDays.last!.next)
            }
        } else {
            repeat {
                let proposedNextDay = allDays.last!.next
                if proposedNextDay.dayOfWeek != currentMonth.calendar.firstWeekday {
                    allDays.append(proposedNextDay)
                } else {
                    break
                }
            } while true
        }
        
        // all supported calendars have weeks of seven days
        assert(allDays.count.isMultiple(of: 7))
        
        // slice the array into groups of seven
        let numberOfWeeks = allDays.count / 7
        
        return (0 ..< numberOfWeeks).map { weekNumber in
            let dayRange = (weekNumber * 7) ..< ((weekNumber + 1) * 7)
            return Array(allDays[dayRange])
        }
    }
    
    var body: some View {
        VStack {
            Toggle("Show the same number of weeks each month", isOn: $consistentNumberOfWeeks)
            
            calendarView
            
            Divider()
            
            Text("The currently selected day is \(selectedDay?.format(date: .long) ?? "none")")
            
            Spacer()
        }
        
    }
    
    private var calendarView: some View {
        let weeks = self.weeksForCurrentMonth
        
        return VStack {
            
            // current month + movement controls
            HStack {
                Text(currentMonth.format(year: .naturalDigits, month: .naturalName))
                    .fixedSize() // prevent the text from wrapping
                
                Spacer()
                
                Button(action: { currentMonth = currentMonth.previous }) {
                    Image(systemName: "arrowtriangle.backward.fill")
                }
                
                Button(action: {
                    currentMonth = Clocks.system.currentMonth
                    selectedDay = Clocks.system.currentDay
                }) {
                    Text("Today")
                }
                
                Button(action: { currentMonth = currentMonth.next }) {
                    Image(systemName: "arrowtriangle.forward.fill")
                }
            }
            .font(.headline)
            
            // weekday name headers
            HStack {
                ForEach(weeks[0], id: \.self) { day in
                    Text(day.format(weekday: .abbreviatedName))
                        .fixedSize() // prevent the text from wrapping
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .font(.subheadline)
            
            Divider()
            
            // weeks
            ForEach(weeks, id: \.self) { week in
                HStack {
                    ForEach(week, id: \.self) { day in
                        Toggle(isOn: Binding(get: { selectedDay == day },
                                             set: { selectedDay = $0 ? day : nil })) {
                            Text(day.format(day: .naturalDigits))
                                .fixedSize() // prevent the text from wrapping
                                .monospacedDigit()
                                .opacity(day.month == currentMonth.month ? 1.0 : 0.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .toggleStyle(DayToggleStyle())
                    }
                }
            }
        }
    }
}

struct DayToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.$isOn.wrappedValue = !configuration.isOn }) {
            configuration.label
                .foregroundStyle(configuration.isOn ? AnyShapeStyle(.selection) : AnyShapeStyle(.primary))
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background {
            if configuration.isOn {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.accentColor)
            }
        }
    }
    
}
