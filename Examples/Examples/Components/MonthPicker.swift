//
//  MonthPicker.swift
//  Examples
//
//  Created by Dave DeLong on 4/2/24.
//

import Foundation
import SwiftUI
import Time

struct YearMonthPicker: View {
    @Binding var month: Fixed<Month>
    
    var body: some View {
        HStack {
            Picker("Month", selection: $month) {
                ForEach(Array(month.fixedYear.months), id: \.self) { month in
                    Text(month.format(month: .naturalName))
                        .tag(month)
                }
            }
            .labelsHidden()
            
            Stepper {
                Text(month.format(year: .naturalDigits))
            } onIncrement: {
                month = month.nextYear
            } onDecrement: {
                month = month.previousYear
            }
        }
        .fixedSize()
    }
}
