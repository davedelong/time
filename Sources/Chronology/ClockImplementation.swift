//
//  ClockImplementation.swift
//  Chronology
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

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
    
    init(referenceInstant: Instant, rate: Double) {
        self.clockStart = referenceInstant
        self.rate = rate
    }
    
    func now() -> Instant {
        let absoluteNow = Instant()
        let elapsedTime = absoluteNow - absoluteStart
        let scaledElapsedTime = elapsedTime * rate
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
