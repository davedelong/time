//
//  CalcCalendarView.swift
//  datetimecalculator
//
//  Created by Robert Dodson on 3/2/24.
//
import Foundation
import SwiftUI
import Time

struct CalcCalendarView: View {
    @Binding var selectedSecond : Fixed<Second>
    
    var selectedDay: Binding<Fixed<Day>> {
        return Binding(get: {
            selectedSecond.fixedDay
        }, set: { newValue in
            do {
                selectedSecond = try newValue.setting(hour: selectedSecond.hour,
                                                      minute: selectedSecond.minute,
                                                      second: selectedSecond.second)
            } catch {
                print("Error: \(selectedSecond.format(time: .long)) does not exist on \(newValue.format(date: .long))")
            }
        })
    }
    
    var body: some View {
        VStack {
            DayPicker(selection: selectedDay, consistentNumberOfWeeks: true, label: {
                YearMonthPicker(month: $0)
            })
            
            HStack {
                TimePicker(selection: $selectedSecond)
                Button("Now") {
                    let now = Clocks.system.currentSecond
                    do {
                        selectedSecond = try selectedSecond.setting(hour: now.hour,
                                                                    minute: now.minute,
                                                                    second: now.second)
                    } catch {
                        print("The time \(now.format(time: .long)) does not exist on \(selectedSecond.format(date: .long))")
                    }
                }
            }
        }
    }
}
