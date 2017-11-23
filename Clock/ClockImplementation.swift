//
//  ClockImplementation.swift
//  Chronology
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

internal protocol ClockImplementation {
    
    var referenceDate: Date { get }
    var rate: Double { get }
    
    func now() -> Date
    
}

internal struct SystemClock: ClockImplementation {
    
    let referenceDate = Date(timeIntervalSinceReferenceDate: 0)
    let rate: Double = 1.0
    
    func now() -> Date { return Date() }
    
}

internal struct CustomClock: ClockImplementation {
    
    let relativeStart = Date()
    let referenceDate: Date
    let rate: Double
    
    init(referenceDate: Date, rate: Double) {
        self.referenceDate = referenceDate
        self.rate = rate
    }
    
    func now() -> Date {
        let relativeNow = Date()
        let elapsedTime = relativeNow.timeIntervalSince(relativeStart)
        let scaledElapsedTime = elapsedTime * rate
        return referenceDate.addingTimeInterval(scaledElapsedTime)
    }
    
    
}
