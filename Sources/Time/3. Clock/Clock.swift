//
//  Clock.swift
//  Time
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

/// A `Clock` is how you know what "now" is.
public protocol Clock {
    
    /// The `Clock`'s `Region`, used for creating `TimePeriod` values relative to this `Clock`.
    var region: Region { get }
    
    /// The instantaneous time currently shown on the `Clock`.
    func now() -> Instant
    
    /// The number of `SISeconds` that pass for every real-world second.
    ///
    /// This is used in situations where you wish to "speed up" or "slow down" clock time. A clock that moves
    /// twice as fast as real time would return `2.0` for this value. A clock that moves half as fast as real time
    /// would return `0.5` for this value.
    ///
    /// The default value is `1.0`, indicating that the clock advances 1 second for every elapsed `SISecond`
    /// in real time.
    var SISecondsPerRealSecond: Double { get }
    
}

extension Clock {
    
    public var SISecondsPerRealSecond: Double { return 1.0 }
    
}

extension Clock {
    
    /// The `Calendar` used by the `Clock`, as defined by its `region`.
    public var calendar: Calendar { region.calendar }
    
    /// The `TimeZone` used by the `Clock`, as defined by its `region`.
    public var timeZone: TimeZone { region.timeZone }
    
    /// The `Locale` used by the `Clock`, as defined by its `region`.
    public var locale: Locale { region.locale }
    
    /// Offset a clock.
    ///
    /// - Parameter by: the `SISeconds` by which to create an offset clock.
    /// - Returns: A new `Clock` that is offset by the specified `SISeconds` from the receiver.
    public func offset(by delta: SISeconds) -> Clock {
        return OffsetClock(offset: delta, from: self)
    }
    
    /// Scale a clock.
    ///
    /// - Parameter by: the `Double` by which to speed up or slow down time
    /// - Returns: A new `Clock` that is scaled from the receiver by the specified `Double` factor.
    public func scaled(by factor: Double) -> Clock {
        guard factor > 0 else {
            fatalError("You cannot create a clock where time has stopped or flows backwards")
        }
        return ScaledClock(scale: factor, from: self)
    }
    
    /// Retrieve the `Instant` of the next daylight saving time transition on this Clock.
    ///
    /// - Parameter after: The `Instant` after which to find the next daylight saving time transition. If omitted, it will be assumed to be the current instant.
    /// - Returns: The `Instant` of the next daylight saving time transition, or `nil` if the time zone does not currently observe daylight saving time.
    public func nextDaylightSavingTimeTransition(after instant: Instant? = nil) -> Instant? {
        let afterInstant = instant ?? now()
        return timeZone.nextDaylightSavingTimeTransition(after: afterInstant.date).map(Instant.init)
    }
    
    
    /// Convert a clock to a new time zone.
    ///
    /// - Parameter timeZone: The `TimeZone` of the new `Clock`.
    /// - Returns: A new `Clock` that reports values in the specified `TimeZone`.
    public func converting(to timeZone: TimeZone) -> Clock {
        if timeZone == self.timeZone { return self }
        let newRegion = self.region.converting(to: timeZone)
        return self.converting(to: newRegion)
    }
    
    /// Convert a clock to a new calendar.
    ///
    /// - Parameter calendar: The `Calendar` of the new `Clock`.
    /// - Returns: A new `Clock` that reports values in the specified `Calendar`.
    public func converting(to calendar: Calendar) -> Clock {
        if calendar == self.calendar { return self }
        // TODO: if the new calendar defines a different scaling of SI Seconds... ?
        let newRegion = self.region.converting(to: calendar)
        return self.converting(to: newRegion)
    }
    
    /// Convert a clock to a new locale.
    ///
    /// - Parameter locale: The `Locale` of the new `Clock`.
    /// - Returns: A new `Clock` that reports values in the specified `Locale`.
    public func converting(to locale: Locale) -> Clock {
        if locale == self.locale { return self }
        let newRegion = self.region.converting(to: locale)
        return self.converting(to: newRegion)
    }
    
    /// Convert a clock to a new region.
    ///
    /// - Parameter region: The `Region` of the new `Clock`.
    /// - Returns: A new `Clock` that reports values in the specified `Region`.
    public func converting(to newRegion: Region) -> Clock {
        // TODO: compare the existing region to the new region and short-circuit if possible
        // TODO: if the new calendar defines a different scaling of SI Seconds... ?
        return RegionalClock(base: self, region: newRegion)
    }
}
