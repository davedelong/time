//
//  RegionalClock+Implementations.swift
//  Time
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

internal struct SystemClock: RegionalClock {

    internal let region: Region
    
    internal init(region: Region) {
        self.region = region
    }
    
    internal var now: Instant {
        return Instant()
    }
    
}

internal struct OffsetClock: RegionalClock {
    
    internal let base: any RegionalClock
    internal let offset: SISeconds
    
    internal var region: Region { base.region }
    internal var SISecondsPerCalendarSecond: Double { base.SISecondsPerCalendarSecond }
    
    internal init(offset: SISeconds, from base: any RegionalClock) {
        self.base = base
        self.offset = offset
    }
    
    internal var now: Instant {
        return base.now + offset
    }
    
}

internal struct ScaledClock: RegionalClock {
    
    internal let base: any RegionalClock
    internal let scale: Double
    
    internal var region: Region { base.region }
    internal var SISecondsPerCalendarSecond: Double { scale * base.SISecondsPerCalendarSecond }
    
    private let startTime: Instant
    
    internal init(scale: Double, from base: any RegionalClock) {
        guard scale > 0 else {
            fatalError("You cannot create a clock where time has stopped or flows backwards")
        }
        self.base = base
        self.scale = scale
        self.startTime = base.now
    }
    
    internal var now: Instant {
        let baseNow = base.now
        
        // these are the number of seconds that have elapsed on the base clock
        let elapsedTime = baseNow - startTime
        
        let scaledTime = elapsedTime * scale
        return Instant(interval: scaledTime, since: startTime.epoch)
    }
    
}

internal struct CustomClock: RegionalClock {
    
    let absoluteStart = Instant()
    let clockStart: Instant
    let rate: Double
    let region: Region
    let SISecondsPerCalendarSecond: Double
    
    init(referenceInstant: Instant, rate: Double, region: Region) {
        self.clockStart = referenceInstant
        self.region = region
        self.rate = rate
        self.SISecondsPerCalendarSecond = rate * region.calendar.SISecondsPerSecond
    }
    
    internal var now: Instant {
        let absoluteNow = Instant()
        let elapsedTime = absoluteNow - absoluteStart
        let scaledElapsedTime = elapsedTime * SISecondsPerCalendarSecond
        return clockStart + scaledElapsedTime
    }
    
}

internal struct CustomRegionClock: RegionalClock {
    
    private let base: any RegionalClock
    internal let region: Region
    
    init(base: any RegionalClock, region: Region) {
        self.base = base
        self.region = region
    }
    
    internal var now: Instant {
        base.now
    }
    
    var SISecondsPerCalendarSecond: Double { base.SISecondsPerCalendarSecond }
}

private extension Instant {
    init() {
        let now = Foundation.Date.timeIntervalSinceReferenceDate
        self.init(interval: SISeconds(now), since: .reference)
    }
}
