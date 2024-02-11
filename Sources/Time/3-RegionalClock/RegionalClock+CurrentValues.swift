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
    
    /// Retrieve the current `Fixed` calendrical value, accurate down to the specified unit.
    public func this<C: Unit>(_ unit: C.Type = C.self) -> Fixed<C> {
        return Fixed(region: region.snapshot(), 
                     instant: thisInstant())
    }
    
    /// Retrieve the current calendar day of the `RegionalClock`.
    public var today: Fixed<Day> { return this() }
    public var tomorrow: Fixed<Day> { return this().next }
    public var yesterday: Fixed<Day> { return this().previous }
    
    /// Retrieve the current calendar era of the `RegionalClock`.
    public var thisEra: Fixed<Era> { return this() }
    
    /// Retrieve the current calendar year of the `RegionalClock`.
    public var thisYear: Fixed<Year> { return this() }
    
    /// Retrieve the current calendar month of the `RegionalClock`.
    public var thisMonth: Fixed<Month> { return this() }
    
    /// Retrieve the current calendar day of the `RegionalClock`.
    public var thisDay: Fixed<Day> { return this() }
    
    /// Retrieve the current calendar hour of the `RegionalClock`.
    public var thisHour: Fixed<Hour> { return this() }
    
    /// Retrieve the current calendar minute of the `RegionalClock`.
    public var thisMinute: Fixed<Minute> { return this() }
    
    /// Retrieve the current calendar second of the `RegionalClock`.
    public var thisSecond: Fixed<Second> { return this() }
    
    /// Retrieve the current calendar nanosecond of the `RegionalClock`.
    public var thisNanosecond: Fixed<Nanosecond> { return this() }
    
    public var nextYear: Fixed<Year> { return this().next }
    public var nextMonth: Fixed<Month> { return this().next }
    public var nextDay: Fixed<Day> { return this().next }
    public var nextHour: Fixed<Hour> { return this().next }
    public var nextMinute: Fixed<Minute> { return this().next }
    public var nextSecond: Fixed<Second> { return this().next }

    public var previousYear: Fixed<Year> { return this().previous }
    public var previousMonth: Fixed<Month> { return this().previous }
    public var previousDay: Fixed<Day> { return this().previous }
    public var previousHour: Fixed<Hour> { return this().previous }
    public var previousMinute: Fixed<Minute> { return this().previous }
    public var previousSecond: Fixed<Second> { return this().previous }
}
