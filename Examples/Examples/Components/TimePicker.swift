//
//  TimePicker.swift
//  Examples
//
//  Created by Dave DeLong on 4/4/24.
//

import Foundation
import SwiftUI
import Time

struct TimePicker: View {
    
    @Binding var selection: Fixed<Second>
    
    var body: some View {
        HStack {
            Stepper(selection.format(hour: .naturalDigits(dayPeriod: .none))) {
                selection = selection.nextHour
            } onDecrement: {
                selection = selection.previousHour
            }
            
            Text(":")
            
            Stepper(selection.format(minute: .twoDigits)) {
                selection = selection.nextMinute
            } onDecrement: {
                selection = selection.previousMinute
            }
            
            Text(":")
            
            Stepper(selection.format(second: .twoDigits)) {
                selection = selection.nextSecond
            } onDecrement: {
                selection = selection.previousSecond
            }
            
            if selection.locale.hourCycle == .oneToTwelve || selection.locale.hourCycle == .zeroToEleven {
                Text(selection.hour < 12 ? selection.calendar.amSymbol : selection.calendar.pmSymbol)
            }
        }
    }
    
}
