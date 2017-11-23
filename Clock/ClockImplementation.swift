//
//  ClockImplementation.swift
//  Chronology
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

internal protocol ClockImplementation {
    
    var timeZone: TimeZone { get }
    
    func now() -> Date
    
}

internal struct SystemClock: ClockImplementation {
    
    let timeZone = TimeZone.autoupdatingCurrent
    
    func now() -> Date { return Date() }
    
}

internal struct CustomClock: ClockImplementation {
    
    let relativeStart = Date()
    let referenceDate: Date
    let rate: Double
    let timeZone: TimeZone
    
    init(referenceDate: Date, rate: Double, timeZone: TimeZone) {
        self.referenceDate = referenceDate
        self.rate = rate
        self.timeZone = timeZone
    }
    
    func now() -> Date {
        let relativeNow = Date()
        let elapsedTime = relativeNow.timeIntervalSince(relativeStart)
        let scaledElapsedTime = elapsedTime * rate
        return referenceDate.addingTimeInterval(scaledElapsedTime)
    }
    
    
}
