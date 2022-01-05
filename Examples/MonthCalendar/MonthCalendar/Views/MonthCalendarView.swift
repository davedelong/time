//
//  MonthCalendarView.swift
//  MonthCalendar
//
//  Created by Tiago Lopes on 05/01/22.
//

import SwiftUI

// MARK: - View

struct MonthCalendarView: View {
    
    // MARK: Properties
    
    @StateObject
    var viewModel = MonthCalendarViewModel()
    
    // MARK: Body
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MonthCalendarView()
    }
}
