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
    
    var body: some View {
        VStack {
            Toggle("Show the same number of weeks each month", isOn: $consistentNumberOfWeeks)
            
            DayPicker(selection: $selectedDay,
                           consistentNumberOfWeeks: consistentNumberOfWeeks)
            
            Divider()
            
            Text("The currently selected day is \(selectedDay?.format(date: .long) ?? "none")")
            
            Spacer()
        }
        
    }
}
