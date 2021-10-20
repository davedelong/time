//
//  Clock+CurrentValues.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Clock {
    
    /// Retrieve the current `Instant` shown on the `Clock`.
    ///
    /// This method is equivalent to invoking the `now()` method.
    func thisInstant() -> Instant { return now() }
    
    /// Retrieve the current `Absolute` calendrical value, accurate down to the specified unit.
    func this<C: Unit>() -> Absolute<C> { return Absolute(region: region, instant: thisInstant()) }
    
    /// Retrieve the current calendar day of the `Clock`.
    func today() -> Absolute<Day> { return this() }
    func tomorrow() -> Absolute<Day> { return this().next }
    func yesterday() -> Absolute<Day> { return this().previous }
    
    /// Retrieve the current calendar era of the `Clock`.
    func thisEra() -> Absolute<Era> { return this() }
    
    /// Retrieve the current calendar year of the `Clock`.
    func thisYear() -> Absolute<Year> { return this() }
    
    /// Retrieve the current calendar month of the `Clock`.
    func thisMonth() -> Absolute<Month> { return this() }
    
    /// Retrieve the current calendar day of the `Clock`.
    func thisDay() -> Absolute<Day> { return this() }
    
    /// Retrieve the current calendar hour of the `Clock`.
    func thisHour() -> Absolute<Hour> { return this() }
    
    /// Retrieve the current calendar minute of the `Clock`.
    func thisMinute() -> Absolute<Minute> { return this() }
    
    /// Retrieve the current calendar second of the `Clock`.
    func thisSecond() -> Absolute<Second> { return this() }
    
    /// Retrieve the current calendar nanosecond of the `Clock`.
    func thisNanosecond() -> Absolute<Nanosecond> { return this() }
    
    func nextYear() -> Absolute<Year> { return this().next }
    func nextMonth() -> Absolute<Month> { return this().next }
    func nextDay() -> Absolute<Day> { return this().next }
    func nextHour() -> Absolute<Hour> { return this().next }
    func nextMinute() -> Absolute<Minute> { return this().next }
    func nextSecond() -> Absolute<Second> { return this().next }

    func previousYear() -> Absolute<Year> { return this().previous }
    func previousMonth() -> Absolute<Month> { return this().previous }
    func previousDay() -> Absolute<Day> { return this().previous }
    func previousHour() -> Absolute<Hour> { return this().previous }
    func previousMinute() -> Absolute<Minute> { return this().previous }
    func previousSecond() -> Absolute<Second> { return this().previous }
}
