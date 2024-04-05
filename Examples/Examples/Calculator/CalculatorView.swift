//
//  CalculatorView.swift
//  datetimecalculator
//
//  Created by Robert Dodson on 3/2/24.
//

import SwiftUI

import Time

struct CalculatorView: View {
    @State var startSecond = Clocks.system.currentSecond
    @State var endSecond = Clocks.system.currentSecond + .days(1)
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            
            HStack {
                GroupBox("From") {
                    CalcCalendarView(selectedSecond: $startSecond)
                        .frame(maxWidth: .infinity)
                }
                
                Image(systemName: "arrow.forward")
                
                GroupBox("To") {
                    CalcCalendarView(selectedSecond: $endSecond)
                        .frame(maxWidth: .infinity)
                }
            }
            
            CalcDifferencesView(startSecond: $startSecond,
                                endSecond: $endSecond)
            
            Spacer()
        }
        .padding()
    }
}
