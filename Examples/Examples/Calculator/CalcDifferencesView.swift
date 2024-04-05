//
//  CalcDifferencesView.swift
//  datetimecalculator
//
//  Created by Robert Dodson on 3/27/24.
//

import SwiftUI
import Time

struct CalcDifferencesView: View {
    @Binding var startSecond : Fixed<Second>
    @Binding var endSecond : Fixed<Second>
    
    @State var wholeDifference = true
    
    @State var yearDifference = 0
    @State var monthDifference = 0
    @State var dayDifference = 0
    @State var hourDifference = 0
    @State var minuteDifference = 0
    @State var secondDifference = 0
    
    @State var sign = ""
    
    private var conjunction: String { wholeDifference ? "or" : "and" }
    
    var body: some View {
        GroupBox("Differences") {
            VStack {
                Text("\(startSecond.description)")
                    .font(.headline)
                
                Text("to")
                    .font(.caption)
                
                Text("\(endSecond.description)")
                    .font(.headline)
                
                HStack {
                    Stepper("\(sign)^[\(yearDifference) year](inflect: true)") {
                        endSecond = endSecond.nextYear
                    } onDecrement: {
                        endSecond = endSecond.previousYear
                    }
                    
                    Picker("Diffence kind", selection: $wholeDifference) {
                        Text("or").tag(true)
                        Text("and").tag(false)
                    }
                    .pickerStyle(.segmented)
                    .fixedSize()
                    .labelsHidden()
                    
                    Stepper("\(sign)^[\(monthDifference) month](inflect: true)") {
                        endSecond = endSecond.nextMonth
                    } onDecrement:  {
                        endSecond = endSecond.previousMonth
                    }
                    
                    Text(conjunction)
                    
                    Stepper("\(sign)^[\(dayDifference) day](inflect: true)") {
                        endSecond = endSecond.nextDay
                    } onDecrement: {
                        endSecond = endSecond.previousDay
                    }
                }
                .padding(.top, 12)
                
                HStack {
                    Text(conjunction)
                    
                    Stepper("\(sign)^[\(hourDifference) hour](inflect: true)") {
                        endSecond = endSecond.nextHour
                    } onDecrement: {
                        endSecond = endSecond.previousHour
                    }
                    
                    Text(conjunction)
                    
                    Stepper("\(sign)^[\(minuteDifference) minute](inflect: true)") {
                        endSecond = endSecond.nextMinute
                    } onDecrement: {
                        endSecond = endSecond.previousMinute
                    }
                    
                    Text(conjunction)
                    
                    Stepper("\(sign)^[\(secondDifference) second](inflect: true)") {
                        endSecond = endSecond.nextSecond
                    } onDecrement: {
                        endSecond = endSecond.previousSecond
                    }
                }
                .padding(.top, 12)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .onAppear { recompute() }
        .onChange(of: startSecond) { _ in recompute() }
        .onChange(of: endSecond) { _ in recompute() }
        .onChange(of: wholeDifference) { _ in recompute() }
    }
    
    private func recompute() {
        if wholeDifference {
            yearDifference = startSecond.differenceInWholeYears(to: endSecond).years
            monthDifference = startSecond.differenceInWholeMonths(to: endSecond).months
            dayDifference = startSecond.differenceInWholeDays(to: endSecond).days
            hourDifference = startSecond.differenceInWholeHours(to: endSecond).hours
            minuteDifference = startSecond.differenceInWholeMinutes(to: endSecond).minutes
            secondDifference = startSecond.differenceInWholeSeconds(to: endSecond).seconds
        } else {
            let difference = startSecond.difference(to: endSecond)
            
            yearDifference = difference.years
            monthDifference = difference.months
            dayDifference = difference.days
            hourDifference = difference.hours
            minuteDifference = difference.minutes
            secondDifference = difference.seconds
        }
        sign = startSecond.isAfter(endSecond) ? "-" : ""
    }
}
