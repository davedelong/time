//
//  ClockImplementation.swift
//  Time
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

internal extension Instant {
    init() {
        let now = Foundation.Date.timeIntervalSinceReferenceDate
        self.init(interval: SISeconds(now), since: .reference)
    }
}

internal protocol ClockImplementation {
    var SISecondsPerCalendarSecond: Double { get }
    var SISecondsPerActualSecond: Double { get }
    func now() -> Instant
    
}

internal struct SystemClock: ClockImplementation {
    let SISecondsPerCalendarSecond: Double = 1.0
    let SISecondsPerActualSecond: Double = 1.0
    func now() -> Instant { return Instant() }
}

internal struct CustomClock: ClockImplementation {
    
    let absoluteStart = Instant()
    let clockStart: Instant
    let rate: Double
    let calendar: Calendar
    var SISecondsPerCalendarSecond: Double { return calendar.SISecondsPerSecond }
    var SISecondsPerActualSecond: Double { return rate * SISecondsPerCalendarSecond }
    
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
    var SISecondsPerCalendarSecond: Double { return base.SISecondsPerCalendarSecond }
    var SISecondsPerActualSecond: Double { SISecondsPerCalendarSecond }
    
    init(offset: TimeInterval, from base: ClockImplementation) {
        self.base = base
        self.offset = offset
    }
    
    func now() -> Instant {
        let scaled = offset * SISecondsPerCalendarSecond
        return base.now() + SISeconds(scaled)
    }
    
}
