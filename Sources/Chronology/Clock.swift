//
//  Clock.swift
//  Chronology
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation


/// A `Clock` is how you know what "now" is.
public struct Clock {
    
    /**
     Some other notes:
     - It'd be good to have a "now()" method that takes a granularity, (ie, "now to the current minute/hour", etc)
     - Then there'd be "thisSecond()", "thisHour()", etc methods that wrap "now()"
     - "now()" will eventually produce a TCL-relative date, and not a "Date"
     - Clock will also have the TCL properties, so you can create a clock for Pacific Time, UTC, Beijing Time, etc.
     
     Implementation details:
     - This uses an internal "ClockImplementation" to simplify the distinction between a custom clock and a system clock
     - If you specify a custom flow-rate of time, it must be greater than zero. You can't stop or reverse time. Sorry.
     **/
    
    /// The system clock
    public static let system = Clock()
    
    public static let UTC = Clock(timeZone: TimeZone(secondsFromGMT: 0)!)
    
    private let impl: ClockImplementation
    
    /// The timezone of the clock
    public let timeZone: TimeZone
    
    public let calendar: Calendar
    
    private init(implementation: ClockImplementation, timeZone: TimeZone, calendar: Calendar) {
        self.impl = implementation
        self.timeZone = timeZone
        self.calendar = calendar
    }
    
    
    /// Create a clock that reflects the current system time
    public init(timeZone: TimeZone = .autoupdatingCurrent, calendar: Calendar = .autoupdatingCurrent) {
        self.init(implementation: SystemClock(), timeZone: timeZone, calendar: calendar)
    }
    
    
    /// Create a clock with a custom start time and flow rate
    ///
    /// - Parameters:
    ///   - referenceDate: The instanteous "now" from which the clock will start counting
    ///   - rate: The rate at which time progresses in the clock, relative to the supplied calendar.
    ///           1.0 (the default) means one second on the system clock correlates to a second passing in the clock.
    ///           2.0 would mean that every second elapsing on the system clock would be 2 seconds on this clock (ie, time progresses twice as fast)
    ///   - timeZone: The TimeZone in which instants are produced
    ///   - calendar: The Calendar relative to which the rate is calculated
    public init(startingFrom referenceInstant: Instant, rate: Double = 1.0, timeZone: TimeZone = .autoupdatingCurrent, calendar: Calendar = .autoupdatingCurrent) {
        guard rate > 0.0 else { fatalError("Clocks can only count forwards") }
        
        let implementation = CustomClock(referenceInstant: referenceInstant, rate: rate, calendar: calendar)
        self.init(implementation: implementation, timeZone: timeZone, calendar: calendar)
    }
    
    
    /// Create a clock with a custom start time and flow rate
    ///
    /// - Parameters:
    ///   - referenceEpoch: The instanteous "now" from which the clock will start counting
    ///   - rate: The rate at which time progresses in the clock.
    ///           1.0 (the default) means one second on the system clock correlates to a second passing in the clock.
    ///           2.0 would mean that every second elapsing on the system clock would be 2 seconds on this clock (ie, time progresses twice as fast)
    ///   - timeZone: The TimeZone in which instants are produced
    public init(startingFrom referenceEpoch: Epoch, rate: Double = 1.0, timeZone: TimeZone = .autoupdatingCurrent, calendar: Calendar = .autoupdatingCurrent) {
        let referenceInstant = Instant(interval: 0, since: referenceEpoch)
        self.init(startingFrom: referenceInstant, rate: rate, timeZone: timeZone, calendar: calendar)
    }
    
    
    /// Retrieve the current instant
    ///
    /// - Returns: An `Instant` representing the current time on the clock.
    public func thisInstant() -> Instant {
        return impl.now()
    }
    
    
    /// Offset a clock
    ///
    /// - Parameter by: A `TimeInterval` by which to create an offseted clock
    /// - Returns: A new `Clock` that is offset by the specified `TimeInterval` from the receiver
    public func offset(by: TimeInterval) -> Clock {
        let offset = OffsetClock(offset: by, from: impl)
        return Clock(implementation: offset, timeZone: timeZone, calendar: calendar)
    }
    
    
    /// Convert a clock to a new time zone
    ///
    /// - Parameter timeZone: The `TimeZone` of the new `Clock`
    /// - Returns: A new `Clock` that reports values in the specified `TimeZone`
    public func converting(to timeZone: TimeZone) -> Clock {
        if timeZone == self.timeZone { return self }
        return Clock(implementation: impl, timeZone: timeZone, calendar: calendar)
    }
    
    public func converting(to calendar: Calendar) -> Clock {
        if calendar == self.calendar { return self }
        // TODO: if the new calendar defines a different scaling of SI Seconds... ?
        if calendar.SISecondsPerSecond != self.calendar.SISecondsPerSecond {
            
        }
        return Clock(implementation: impl, timeZone: timeZone, calendar: calendar)
    }
    
    public func converting(to calendar: Calendar, in timeZone: TimeZone) -> Clock {
        if timeZone == self.timeZone && calendar == self.calendar { return self }
        // TODO: if the new calendar defines a different scaling of SI Seconds... ?
        if calendar.SISecondsPerSecond != self.calendar.SISecondsPerSecond {
            
        }
        return Clock(implementation: impl, timeZone: timeZone, calendar: calendar)
        
    }
}


