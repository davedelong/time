//
//  YearAdjustment.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Adjustment where IL: GTOEEra, IS == OS, IL == OL {
    
    init(delta: Delta<IS, IL>) {
        self.init {
            let d = $0.range.lowerBound.date
            let diff = delta.dateComponents
            let newDate = $0.calendar.date(byAdding: diff, to: d).unwrap("Unable to add \(diff) to \($0)")
            return Value<OS, OL>(region: $0.region, date: newDate)
        }
    }
    
}
