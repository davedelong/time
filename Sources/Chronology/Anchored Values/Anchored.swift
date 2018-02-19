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

public extension Anchored where Self: CalendarValue {
    
    var range: ClosedRange<Instant> {
        let date = calendar.date(from: dateComponents).unwrap("Anchored values must always be convertible to a concrete NSDate")
        let unit = type(of: self).smalledRepresentedComponent
        
        var start = Date()
        var length: TimeInterval = 0
        let succeeded = calendar.dateInterval(of: unit, start: &start, interval: &length, for: date)
        require(succeeded, "We should always be able to get the range of a calendar component")
        
        let startInsant = Instant(date: start)
        let endInstant = Instant(date: start.addingTimeInterval(length))
        return startInsant...endInstant
    }
    
}
