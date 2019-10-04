//
//  YearAdjustment.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Adjustment where I: AbsoluteValue, I == O {
    
    static func add(value: Int, unit: Calendar.Component) -> Adjustment<I, O> {
        return Adjustment {
            let d = $0.range.lowerBound.date
            let newDate = $0.calendar.date(byAdding: unit, value: value, to: d).unwrap("Unable to add \(value) \(unit)s to \($0)")
            return O.init(date: newDate, region: $0.region)
        }
    }
    
}
