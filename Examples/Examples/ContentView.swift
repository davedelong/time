//
//  ContentView.swift
//  Examples
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            
            ClocksView()
                .tabItem {
                    Label("Clocks", systemImage: "clock")
                }
            
            CalculatorView()
                .tabItem {
                    Label("Calculator", systemImage: "calendar.badge.clock")
                }
        }
        .scenePadding()
    }
}
