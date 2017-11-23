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
     - Eventually, thisInstant() will return an "Instant", now a "Date"
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
    
    private let impl: ClockImplementation
    
    /// The timezone of the clock
    public var timeZone: TimeZone { return impl.timeZone }
    
    /// Create a clock that reflects the current system time
    public init() {
        impl = SystemClock()
    }
    
    /// Create a clock with a custom start time and flow rate
    ///
    /// - Parameters:
    ///   - referenceDate: The instanteous "now" from which the clock will start counting
    ///   - rate: The rate at which time progresses in the clock.
    ///           1.0 (the default) means one second on the system clock correlates to a second passing in the clock.
    ///           2.0 would mean that every second elapsing on the system clock would be 2 seconds on this clock (ie, time progresses twice as fast)
    ///   - timeZone: The TimeZone in which instants are produced
    public init(referenceDate: Date, rate: Double = 1.0, timeZone: TimeZone = .current) {
        guard rate > 0.0 else { fatalError("Clocks can only count forwards") }
        impl = CustomClock(referenceDate: referenceDate, rate: rate, timeZone: timeZone)
    }
    
    /// Retrieve the current instant
    ///
    /// - Returns: An `Instant` representing the current time on the clock.
    public func thisInstant() -> Date {
        return impl.now()
    }
}


