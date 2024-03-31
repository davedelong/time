//
//  CalcClockView.swift
//  datetimecalculator
//
//  Created by Robert Dodson on 3/27/24.
//

import SwiftUI

import Time


struct CalcClockView: View
{
    @Binding var selectedSecond : Fixed<Second>
    
    @State var hourName = Clocks.system.currentHour.hour
    @State var ampm = AM
    @State var hourType = HOUR24
    
    static let HOUR24 = "24"
    static let HOUR12 = "12"
    static let PM = "PM"
    static let AM = "AM"
    
    
    var body: some View
    {
        HStack
        {
            Stepper(String(format:"%02d",hourName))
            {
                selectedSecond = selectedSecond.nextHour
                update()
            }
        onDecrement:
            {
                selectedSecond = selectedSecond.previousHour
                update()
            }
            
            Text(":")
            
            Stepper(String(format:"%02d",selectedSecond.minute))
            {
                selectedSecond = selectedSecond.nextMinute
                update()
            }
        onDecrement:
            {
                selectedSecond = selectedSecond.previousMinute
                update()
            }
            
            Text(":")
            
            Stepper(String(format:"%02d",selectedSecond.second))
            {
                selectedSecond = selectedSecond.nextSecond
                update()
            }
        onDecrement:
            {
                selectedSecond = selectedSecond.previousSecond
                update()
            }
            
            if hourType == CalcClockView.HOUR12
            {
                Text(ampm)
            }
            
            Picker("",selection: $hourType)
            {
                Text(CalcClockView.HOUR24)
                    .tag(CalcClockView.HOUR24)
                Text(CalcClockView.HOUR12)
                    .tag(CalcClockView.HOUR12)
            }
            .frame(width: 70)
            .valueChanged(value: hourType, onChange:
            { newValue in
                hourType = newValue
                update()
            })
            
            Button("Now")
            {
                setnow()
                update()
            }
        }
        .valueChanged(value: selectedSecond, onChange:
        { newValue in
            selectedSecond = newValue
            update()
        })
    }
    
    
    func setnow()
    {
        do
        {
            let now  = Clocks.system.currentSecond
            selectedSecond = try Fixed<Second>(region:.current,
                                               year:selectedSecond.year,
                                               month:selectedSecond.month,
                                               day:selectedSecond.day,
                                               hour:now.hour,
                                               minute:now.minute,
                                               second:now.second)
        }
        catch
        {
            print("setnow error: \(error)")
        }
    }
    
    
    func update()
    {
        ampm = selectedSecond.hour >= 12 ? CalcClockView.PM : CalcClockView.AM
        hourName = selectedSecond.hour
        if hourType == CalcClockView.HOUR12
        {
            hourName = selectedSecond.hour > 12 ? selectedSecond.hour - 12 : selectedSecond.hour
            if hourName == 0
            {
                hourName = 12
            }
        }
    }
}


import Combine

extension View {
    /// A backwards compatible wrapper for  `onChange`
    @ViewBuilder func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 17.0, macOS 14.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { (value) in
                onChange(value)
            }
        }
    }
}
