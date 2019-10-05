//
//  YearAdjustment.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Adjustment where IL: GTOEEra, IS == OS, IL == OL {
    
    init(value: Int, unit: Calendar.Component) {
        self.init {
            let d = $0.range.lowerBound.date
            let newDate = $0.calendar.date(byAdding: unit, value: value, to: d).unwrap("Unable to add \(value) \(unit)s to \($0)")
            return Value<OS, OL>(region: $0.region, date: newDate)
        }
    }
    
}
