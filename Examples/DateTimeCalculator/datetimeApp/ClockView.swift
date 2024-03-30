//
//  ClockView.swift
//  datetimecalculator
//
//  Created by Robert Dodson on 3/27/24.
//

import SwiftUI

import Time


struct ClockView: View
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
            
            if hourType == ClockView.HOUR12
            {
                Text(ampm)
            }
            
            Picker("",selection: $hourType)
            {
                Text(ClockView.HOUR24)
                    .tag(ClockView.HOUR24)
                Text(ClockView.HOUR12)
                    .tag(ClockView.HOUR12)
            }
            .frame(width: 70)
            .onChange(of: hourType)
            { oldValue, newValue in
                hourType = newValue
                update()
            }
            
            Button("Now")
            {
                setnow()
                update()
            }
        }
        .onChange(of: selectedSecond) 
        { oldValue, newValue in
            selectedSecond = newValue
            update()
        }
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
        ampm = selectedSecond.hour >= 12 ? ClockView.PM : ClockView.AM
        hourName = selectedSecond.hour
        if hourType == ClockView.HOUR12
        {
            hourName = selectedSecond.hour > 12 ? selectedSecond.hour - 12 : selectedSecond.hour
            if hourName == 0
            {
                hourName = 12
            }
        }
    }
}

