//
//  Clock+Implementations.swift
//  Time
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

internal struct SystemClock: Clock {

    internal let region: Region
    
    internal init(region: Region) {
        self.region = region
    }
    
    internal func now() -> Instant {
        return Instant()
    }
    
}

internal struct OffsetClock: Clock {
    
    internal let base: Clock
    internal let offset: SISeconds
    
    internal var region: Region { base.region }
    internal var SISecondsPerRealSecond: Double { base.SISecondsPerRealSecond }
    
    internal init(offset: SISeconds, from base: Clock) {
        self.base = base
        self.offset = offset
    }
    
    internal func now() -> Instant {
        return base.now() + offset
    }
    
}

internal struct ScaledClock: Clock {
    
    internal let base: Clock
    internal let scale: Double
    
    internal var region: Region { base.region }
    internal var SISecondsPerRealSecond: Double { scale * base.SISecondsPerRealSecond }
    
    private let startTime: Instant
    
    internal init(scale: Double, from base: Clock) {
        guard scale > 0 else {
            fatalError("You cannot create a clock where time has stopped or flows backwards")
        }
        self.base = base
        self.scale = scale
        self.startTime = base.now()
    }
    
    internal func now() -> Instant {
        let baseNow = base.now()
        
        // these are the number of seconds that have elapsed on the base clock
        let elapsedTime = baseNow - startTime
        
        let scaledTime = elapsedTime * scale
        return Instant(interval: scaledTime, since: startTime.epoch)
    }
    
}

internal struct CustomClock: Clock {
    
    let absoluteStart = Instant()
    let clockStart: Instant
    let rate: Double
    let region: Region
    var SISecondsPerCalendarSecond: Double { return calendar.SISecondsPerSecond }
    var SISecondsPerRealSecond: Double { return rate * SISecondsPerCalendarSecond }
    
    private let actualRate: Double
    
    init(referenceInstant: Instant, rate: Double, region: Region) {
        self.clockStart = referenceInstant
        self.region = region
        self.rate = rate
        self.actualRate = rate * region.calendar.SISecondsPerSecond
    }
    
    func now() -> Instant {
        let absoluteNow = Instant()
        let elapsedTime = absoluteNow - absoluteStart
        let scaledElapsedTime = elapsedTime * actualRate
        return clockStart + scaledElapsedTime
    }
    
}

internal struct RegionalClock: Clock {
    
    private let base: Clock
    internal let region: Region
    
    init(base: Clock, region: Region) {
        self.base = base
        self.region = region
    }
    
    func now() -> Instant {
        base.now()
    }
}

private extension Instant {
    init() {
        let now = Foundation.Date.timeIntervalSinceReferenceDate
        self.init(interval: SISeconds(now), since: .reference)
    }
}
