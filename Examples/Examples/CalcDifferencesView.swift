//
//  CalcDifferencesView.swift
//  datetimecalculator
//
//  Created by Robert Dodson on 3/27/24.
//

import SwiftUI

import Time

struct CalcDifferencesView: View
{
    @Binding var startSecond : Fixed<Second>
    @Binding var endSecond : Fixed<Second>
    
    var startColor = Color.green
    var endColor = Color.blue
    
    
    var body: some View
    {
        let diffyears   = startSecond.differenceInWholeYears(to: endSecond).years
        let diffmonths  = startSecond.differenceInWholeMonths(to: endSecond).months
        let diffdays    = startSecond.differenceInWholeDays(to: endSecond).days
        let diffhours   = startSecond.differenceInWholeHours(to: endSecond).hours
        let diffminutes = startSecond.differenceInWholeMinutes(to: endSecond).minutes
        let diffseconds = startSecond.differenceInWholeSeconds(to: endSecond).seconds
        
        let plusmonths = diffmonths % 12
        let plusdays = diffdays % 30 // FIX - make smarter
        let plushours = diffhours % 24
        let plusminutes = diffminutes % 60
        let plusseconds = diffseconds % 60
        
        let minus : String = startSecond.isAfter(endSecond) ? "-" : ""
        
        
        return VStack(alignment: .leading)
        {
            Text("\(startSecond.fixedDay.description)")
                .foregroundColor(startColor)
                .font(.headline)
            
            Text("\(endSecond.fixedDay.description)")
                .foregroundColor(endColor)
                .font(.headline)
            
            HStack
            {
                Stepper("\(minus)\(plural(count:diffyears, amount:"year"))")     { endSecond = endSecond.nextYear } onDecrement: { endSecond = endSecond.previousYear }
                Text("+ \(plural(count:plusmonths, amount:"month"))").foregroundStyle(.gray)
            }
            
            HStack
            {
                Stepper("\(minus)\(plural(count:diffmonths, amount:"month"))")   { endSecond = endSecond.nextMonth } onDecrement:  { endSecond = endSecond.previousMonth }
                Text("+ \(plural(count:plusdays, amount:"day"))").foregroundStyle(.gray)
            }
            
            HStack
            {
                Stepper("\(minus)\(plural(count:diffdays, amount:"day"))")       { endSecond = endSecond.nextDay } onDecrement: { endSecond = endSecond.previousDay }
                Text("+ \(plural(count:plushours, amount:"hour"))").foregroundStyle(.gray)
            }
            
            HStack
            {
                Stepper("\(minus)\(plural(count:diffhours, amount:"hour"))")     { endSecond = endSecond.nextHour } onDecrement:   { endSecond = endSecond.previousHour }
                Text("+ \(plural(count:plusminutes, amount:"minute"))").foregroundStyle(.gray)
            }
            
            HStack
            {
                Stepper("\(minus)\(plural(count:diffminutes, amount:"minute"))") { endSecond = endSecond.nextMinute } onDecrement: { endSecond = endSecond.previousMinute }
                Text("+ \(plural(count:plusseconds, amount:"second"))").foregroundStyle(.gray)
            }
            
            Stepper("\(minus)\(plural(count:diffseconds, amount:"second"))") { endSecond = endSecond.nextSecond } onDecrement: { endSecond = endSecond.previousSecond }
            
        }
        .font(.body)
        .foregroundColor(.white)
        .padding()
        .frame(width:350,alignment: .leading)
        .background()
        .cornerRadius(5.0)
    }
    
    
    func plural(count:Int,amount:String) -> String
    {
        if count == 1
        {
            return "\(count.withCommas()) \(amount)"
        }
        else
        {
            return "\(count.withCommas()) \(amount)s"
        }
    }
}


extension Int
{
    func withCommas() -> String 
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
