//
//  ClockImplementation.swift
//  Chronology
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

internal extension Instant {
    init() {
        self.init(interval: Foundation.Date.timeIntervalSinceReferenceDate, since: .reference)
    }
}

internal protocol ClockImplementation {
    
    func now() -> Instant
    
}

internal struct SystemClock: ClockImplementation {
    func now() -> Instant { return Instant() }
}

internal struct CustomClock: ClockImplementation {
    
    let absoluteStart = Instant()
    let clockStart: Instant
    let rate: Double
    let calendar: Calendar
    
    private let actualRate: Double
    
    init(referenceInstant: Instant, rate: Double, calendar: Calendar) {
        self.clockStart = referenceInstant
        self.calendar = calendar
        self.rate = rate
        self.actualRate = rate * calendar.SISecondsPerSecond
    }
    
    func now() -> Instant {
        let absoluteNow = Instant()
        let elapsedTime = absoluteNow - absoluteStart
        let scaledElapsedTime = elapsedTime * actualRate
        return clockStart + scaledElapsedTime
    }
    
}

internal struct OffsetClock: ClockImplementation {
    
    let base: ClockImplementation
    let offset: TimeInterval
    
    init(offset: TimeInterval, from base: ClockImplementation) {
        self.base = base
        self.offset = offset
    }
    
    func now() -> Instant {
        return base.now() + offset
    }
    
}
