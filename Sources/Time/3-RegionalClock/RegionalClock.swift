import Foundation

/// A `RegionalClock` is how you know what "now" is.
///
/// `RegionalClocks` conform to the `Clock` protocol from Foundation and provide a standard implementation for some of its functionality.
/// All `RegionalClocks` use the same types for their instant and duration values (``Instant`` and ``SISeconds`` respectively).
///
/// When implementing a custom `RegionalClock`, the two things that must be implemented are `.region` and `.now`.
public protocol RegionalClock: Clock where Instant == Time.Instant, Duration == Time.SISeconds {
    
    /// The clock's `Region`, used for creating calendrical values.
    var region: Region { get }
    
    /// The number of `SISeconds` that pass for every clock second.
    ///
    /// This is used in situations where you wish to "speed up" or "slow down" clock time. A clock that moves
    /// twice as fast as real time would return `2.0` for this value. A clock that moves half as fast as real time
    /// would return `0.5` for this value.
    ///
    /// The default value is `1.0`, indicating that the clock advances 1 second for every elapsed `SISecond`
    /// in real time.
    var SISecondsPerClockSecond: Double { get }
    
}

extension RegionalClock {
    
    /// The default implementation
    public var SISecondsPerClockSecond: Double { return 1.0 }
    
    /// The default implementation; one nanosecond (1e-9)
    public var minimumResolution: SISeconds { return SISeconds(1.0 / Double(1e9)) }
    
    /// Suspend the current concurrency task until the specified deadline, relative to this clock
    /// - Parameter deadline: The `Instant` at which this task should wake up again, relative to this clock
    /// - Parameter tolerance: How much leeway there is in missing the deadline
    public func sleep(until deadline: Instant, tolerance: Instant.Duration?) async throws {
        let now = self.now
        let difference = now - deadline
        
        // `difference` contains the number of CLOCK seconds that must elapse until the deadline is hit
        
        // if the deadline is in the past, immediately return
        if difference <= .zero { return }
        
        let sisecondsToWait = difference / self.SISecondsPerClockSecond
        let systemTolerance = tolerance.map { $0 / self.SISecondsPerClockSecond }
        
        let systemClock = SystemClock(region: .current)
        let systemNow = systemClock.now
        let systemDeadline = systemNow + sisecondsToWait
        
        try await Task.sleep(until: systemDeadline, tolerance: systemTolerance, clock: systemClock)
    }
    
}

extension RegionalClock {
    
    /// The `Calendar` used by the `RegionalClock`, as defined by its `region`.
    public var calendar: Calendar { region.calendar }
    
    /// The `TimeZone` used by the `RegionalClock`, as defined by its `region`.
    public var timeZone: TimeZone { region.timeZone }
    
    /// The `Locale` used by the `RegionalClock`, as defined by its `region`.
    public var locale: Locale { region.locale }
    
    /// Offset a clock.
    ///
    /// - Parameter by: the `SISeconds` by which to create an offset clock.
    /// - Returns: A new `RegionalClock` that is offset by the specified `SISeconds` from the receiver.
    public func offset(by delta: SISeconds) -> any RegionalClock {
        return OffsetClock(offset: delta, from: self)
    }
    
    /// Scale a clock.
    ///
    /// - Parameter by: the `Double` by which to speed up or slow down time
    /// - Returns: A new `RegionalClock` that is scaled from the receiver by the specified `Double` factor.
    public func scaled(by factor: Double) -> any RegionalClock {
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
        let afterInstant = instant ?? now
        return timeZone.nextDaylightSavingTimeTransition(after: afterInstant.date).map(Instant.init)
    }
    
    /// Convert a clock to a new time zone.
    ///
    /// - Parameter timeZone: The `TimeZone` of the new `RegionalClock`.
    /// - Returns: A new `RegionalClock` that reports values in the specified `TimeZone`.
    public func converted(to timeZone: TimeZone) -> any RegionalClock {
        if timeZone.isEquivalent(to: self.timeZone) { return self }
        let newRegion = self.region.setTimeZone(timeZone)
        return self.converted(to: newRegion)
    }
    
    /// Convert a clock to a new calendar.
    ///
    /// - Parameter calendar: The `Calendar` of the new `RegionalClock`.
    /// - Returns: A new `RegionalClock` that reports values in the specified `Calendar`.
    public func converted(to calendar: Calendar) -> any RegionalClock {
        if calendar.isEquivalent(to: self.calendar) { return self }
        let newRegion = self.region.setCalendar(calendar)
        return self.converted(to: newRegion)
    }
    
    /// Convert a clock to a new locale.
    ///
    /// - Parameter locale: The `Locale` of the new `RegionalClock`.
    /// - Returns: A new `RegionalClock` that reports values in the specified `Locale`.
    public func converted(to locale: Locale) -> any RegionalClock {
        if locale.isEquivalent(to: self.locale) { return self }
        let newRegion = self.region.setLocale(locale)
        return self.converted(to: newRegion)
    }
    
    /// Convert a clock to a new region.
    ///
    /// - Parameter region: The `Region` of the new `RegionalClock`.
    /// - Returns: A new `RegionalClock` that reports values in the specified `Region`.
    public func converted(to newRegion: Region) -> any RegionalClock {
        if newRegion.isEquivalent(to: self.region) { return self }
        return CustomRegionClock(base: self, region: newRegion)
    }
}
