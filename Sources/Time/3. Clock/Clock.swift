//
//  Clock.swift
//  Time
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation


/// A `Clock` is how you know what "now" is.
public class Clock {
    
    /// The system clock. This `Clock` uses the current `Region` and follows the current device time.
    public static let system = Clock()
    
    /// A POSIX clock. This `Clock` uses the POSIX `Region` and follows the current device time.
    public static let posix = Clock(region: .posix)
    
    private let impl: ClockImplementation
    
    /// How many seconds the `Clock` measures per actual second elapsed.
    ///
    /// This value is 1.0, unless otherwise specified in the initializer.
    public var rate: Double { impl.SISecondsPerRealSecond }
    
    /// The `Clock`'s `Region`.
    public let region: Region
    
    /// The `Calendar` used by the `Clock`, as defined by its `region`.
    public var calendar: Calendar { return region.calendar }
    
    /// The `TimeZone` used by the `Clock`, as defined by its `region`.
    public var timeZone: TimeZone { return region.timeZone }
    
    /// The `Locale` used by the `Clock`, as defined by its `region`.
    public var locale: Locale { return region.locale }
    
    private init(implementation: ClockImplementation, region: Region) {
        self.impl = implementation
        self.region = region
    }
    
    /// Create a `Clock` that reflects the current system time localized to a particular `Region`.
    public convenience init(region: Region = .autoupdatingCurrent) {
        self.init(implementation: SystemClock(), region: region)
    }
    
    /// Create a clock with a custom start time and flow rate.
    ///
    /// - Parameters:
    ///   - referenceDate: The instantaneous "now" from which the clock will start counting.
    ///   - rate: The rate at which time progresses in the clock, relative to the supplied calendar.
    ///     - `1.0` (the default) means one second on the system clock correlates to a second passing in the clock.
    ///     - `2.0` would mean that every second elapsing on the system clock would be 2 seconds on this clock (ie, time progresses twice as fast).
    ///   - region: The Region in which calendar values are produced.
    public convenience init(startingFrom referenceInstant: Instant, rate: Double = 1.0, region: Region = .autoupdatingCurrent) {
        guard rate > 0.0 else { fatalError("Clocks can only count forwards") }
        
        let implementation = CustomClock(referenceInstant: referenceInstant, rate: rate, calendar: region.calendar)
        self.init(implementation: implementation, region: region)
    }
    
    
    /// Create a clock with a custom start time and flow rate.
    ///
    /// - Parameters:
    ///   - referenceEpoch: The instantaneous "now" from which the clock will start counting.
    ///   - rate: The rate at which time progresses in the clock.
    ///     - `1.0` (the default) means one second on the system clock correlates to a second passing in the clock.
    ///     - `2.0` would mean that every second elapsing on the system clock would be 2 seconds on this clock (ie, time progresses twice as fast).
    ///   - region: The Region in which calendar values are produced.
    public convenience init(startingFrom referenceEpoch: Epoch, rate: Double = 1.0, region: Region = .autoupdatingCurrent) {
        let referenceInstant = Instant(interval: 0, since: referenceEpoch)
        self.init(startingFrom: referenceInstant, rate: rate, region: region)
    }
    
    
    /// Retrieve the current instant.
    ///
    /// - Returns: An `Instant` representing the current time on the clock.
    public func now() -> Instant {
        return impl.now()
    }
    
    
    /// Offset a clock.
    ///
    /// - Parameter by: A `TimeInterval` by which to create an offset clock.
    /// - Returns: A new `Clock` that is offset by the specified `TimeInterval` from the receiver.
    public func offset(by: TimeInterval) -> Clock {
        let offset = OffsetClock(offset: by, from: impl)
        return Clock(implementation: offset, region: region)
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
    
    public func converting(to calendar: Calendar) -> Clock {
        if calendar == self.calendar { return self }
        // TODO: if the new calendar defines a different scaling of SI Seconds... ?
        let newRegion = self.region.converting(to: calendar)
        return self.converting(to: newRegion)
    }
    
    public func converting(to locale: Locale) -> Clock {
        if locale == self.locale { return self }
        let newRegion = self.region.converting(to: locale)
        return self.converting(to: newRegion)
    }
    
    public func converting(to newRegion: Region) -> Clock {
        // TODO: compare the existing region to the new region and short-circuit if possible
        // TODO: if the new calendar defines a different scaling of SI Seconds... ?
        return Clock(implementation: impl, region: newRegion)
    }
    
    
    /// Retrieve the `Instant` of the next daylight saving time transition.
    ///
    /// - Parameter after: The `Instant` after which to find the next daylight saving time transition. If omitted, it will be assumed to be the current instant.
    /// - Returns: The `Instant` of the next daylight saving time transition, or `nil` if the time zone does not currently observe daylight saving time.
    public func nextDaylightSavingTimeTransition(after instant: Instant? = nil) -> Instant? {
        let afterInstant = instant ?? now()
        return timeZone.nextDaylightSavingTimeTransition(after: afterInstant.date).map(Instant.init)
    }
}
