//
//  Anchored.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol Anchored {
    
    var range: ClosedRange<Instant> { get }
    
}

internal func getRange<T: Anchored & DateComponentsField>(_ value: T, unit: Calendar.Component) -> ClosedRange<Instant> {
    let components = value.dateComponents
    let cal = value.calendar
    let date = cal.date(from: components).unwrap("Anchored values must always be convertible to a concrete NSDate")
    
    var start = Date()
    var length: TimeInterval = 0
    let succeeded = cal.dateInterval(of: unit, start: &start, interval: &length, for: date)
    require(succeeded, "We should always be able to get the range of a calendar component")
    
    let startInsant = Instant(date: start)
    let endInstant = Instant(date: start.addingTimeInterval(length))
    return startInsant...endInstant
}
