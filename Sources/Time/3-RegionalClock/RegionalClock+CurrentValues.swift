//
//  RegionalClock+CurrentValues.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

extension RegionalClock {
    
    /// Retrieve the current `Instant` shown on the `RegionalClock`.
    ///
    /// This method is equivalent to invoking the `now` property.
    public func thisInstant() -> Instant { return now }
    
    /// Retrieve the current `Absolute` calendrical value, accurate down to the specified unit.
    public func this<C: Unit>(_ unit: C.Type = C.self) -> Absolute<C> { return Absolute(region: region, instant: thisInstant()) }
    
    /// Retrieve the current calendar day of the `RegionalClock`.
    public var today: Absolute<Day> { return this() }
    public var tomorrow: Absolute<Day> { return this().next }
    public var yesterday: Absolute<Day> { return this().previous }
    
    /// Retrieve the current calendar era of the `RegionalClock`.
    public var thisEra: Absolute<Era> { return this() }
    
    /// Retrieve the current calendar year of the `RegionalClock`.
    public var thisYear: Absolute<Year> { return this() }
    
    /// Retrieve the current calendar month of the `RegionalClock`.
    public var thisMonth: Absolute<Month> { return this() }
    
    /// Retrieve the current calendar day of the `RegionalClock`.
    public var thisDay: Absolute<Day> { return this() }
    
    /// Retrieve the current calendar hour of the `RegionalClock`.
    public var thisHour: Absolute<Hour> { return this() }
    
    /// Retrieve the current calendar minute of the `RegionalClock`.
    public var thisMinute: Absolute<Minute> { return this() }
    
    /// Retrieve the current calendar second of the `RegionalClock`.
    public var thisSecond: Absolute<Second> { return this() }
    
    /// Retrieve the current calendar nanosecond of the `RegionalClock`.
    public var thisNanosecond: Absolute<Nanosecond> { return this() }
    
    public var nextYear: Absolute<Year> { return this().next }
    public var nextMonth: Absolute<Month> { return this().next }
    public var nextDay: Absolute<Day> { return this().next }
    public var nextHour: Absolute<Hour> { return this().next }
    public var nextMinute: Absolute<Minute> { return this().next }
    public var nextSecond: Absolute<Second> { return this().next }

    public var previousYear: Absolute<Year> { return this().previous }
    public var previousMonth: Absolute<Month> { return this().previous }
    public var previousDay: Absolute<Day> { return this().previous }
    public var previousHour: Absolute<Hour> { return this().previous }
    public var previousMinute: Absolute<Minute> { return this().previous }
    public var previousSecond: Absolute<Second> { return this().previous }
}
