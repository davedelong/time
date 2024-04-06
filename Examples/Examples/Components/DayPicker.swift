//
//  DayPicker.swift
//  Examples
//
//  Created by Dave DeLong on 4/2/24.
//

import Foundation
import SwiftUI
import Time

struct DayPicker<Label: View>: View {
    
    @Binding var selection: Fixed<Day>?
    
    var consistentNumberOfWeeks: Bool
    
    var label: (Binding<Fixed<Month>>) -> Label
    
    @State private var currentMonth: Fixed<Month> = Clocks.system.currentMonth
    
    init(selection: Binding<Fixed<Day>>, consistentNumberOfWeeks: Bool = true, @ViewBuilder label: @escaping (Binding<Fixed<Month>>) -> Label) {
        self._selection = Binding(get: { selection.wrappedValue },
                                  set: { newValue in
            guard let newValue else { return }
            selection.wrappedValue = newValue
        })
        self.consistentNumberOfWeeks = consistentNumberOfWeeks
        self.label = label
    }
    
    init(selection: Binding<Fixed<Day>?>, consistentNumberOfWeeks: Bool = true, @ViewBuilder label: @escaping (Binding<Fixed<Month>>) -> Label) {
        self._selection = selection
        self.consistentNumberOfWeeks = consistentNumberOfWeeks
        self.label = label
    }
    
    init(selection: Binding<Fixed<Day>?>, consistentNumberOfWeeks: Bool = true) where Label == DefaultFixedDayTitle {
        self._selection = selection
        self.consistentNumberOfWeeks = consistentNumberOfWeeks
        self.label = { DefaultFixedDayTitle(month: $0) }
    }
    
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
        let weeks = self.weeksForCurrentMonth
        
        return VStack {
            // current month + movement controls
            HStack {
                label($currentMonth)
                
                Spacer()
                    .layoutPriority(-1)
                
                Button(action: { currentMonth = currentMonth.previous }) {
                    Image(systemName: "arrowtriangle.backward.fill")
                }
                
                Button(action: {
                    currentMonth = Clocks.system.currentMonth
                    selection = Clocks.system.currentDay
                }) {
                    Text("Today")
                }
                
                Button(action: { currentMonth = currentMonth.next }) {
                    Image(systemName: "arrowtriangle.forward.fill")
                }
            }
            .font(.headline)
            
            Grid(alignment: .centerFirstTextBaseline, horizontalSpacing: 2, verticalSpacing: 2) {
                GridRow {
                    ForEach(weeks[0], id: \.self) { day in
                        Text(day.format(weekday: .abbreviatedName))
                            .fixedSize() // prevent the text from wrapping
                    }
                    .font(.subheadline)
                }
            
                Divider()
                    .gridCellUnsizedAxes(.horizontal)
                
                ForEach(weeks, id: \.self) { week in
                    GridRow {
                        ForEach(week, id: \.self) { day in
                            toggle(for: day)
                        }
                    }
                }
            }
//            .aspectRatio(7.0 / Double(weeks.count + 1), contentMode: .fit)
        }
        .padding()
    }
    
    private func toggle(for day: Fixed<Day>) -> some View {
        let isOn = Binding(get: { selection == day },
                           set: { on in
            if on {
                selection = day
                currentMonth = day.fixedMonth
            } else {
                selection = nil
            }
        })
        
        return Toggle(isOn: isOn) {
            Text(day.format(day: .naturalDigits))
                .fixedSize() // prevent the text from wrapping
                .monospacedDigit()
                .opacity(day.month == currentMonth.month ? 1.0 : 0.5)
                .padding(2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1.0, contentMode: .fit)
        }
        .toggleStyle(DayToggleStyle())
    }
}

struct DefaultFixedDayTitle: View {
    
    @Binding var month: Fixed<Month>
    
    var body: some View {
        Text(month.format(year: .naturalDigits, month: .naturalName))
            .fixedSize()
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
