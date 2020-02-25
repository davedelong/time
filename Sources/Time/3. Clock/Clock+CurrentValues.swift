//
//  Clock+CurrentValues.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Clock {
    
    /// Retrieve the current `Instant` shown on the `Clock`
    func now() -> Instant { return thisInstant() }
    
    /// Retrieve the current `Absolute` calendrical value, accurate down to the specified unit.
    func this<C: Unit>() -> Absolute<C> { return Absolute(region: region, instant: thisInstant()) }
    
    /// Retrieve the current calendar day of the `Clock`.
    func today() -> Absolute<Day> { return this() }
    func tomorrow() -> Absolute<Day> { return this().adding(days: 1) }
    func yesterday() -> Absolute<Day> { return this().subtracting(days: 1) }
    
    /// Retrieve the current calendar era of the `Clock`
    func thisEra() -> Absolute<Era> { return this() }
    
    /// Retrieve the current calendar year of the `Clock`
    func thisYear() -> Absolute<Year> { return this() }
    
    /// Retrieve the current calendar month of the `Clock`
    func thisMonth() -> Absolute<Month> { return this() }
    
    /// Retrieve the current calendar day of the `Clock`
    func thisDay() -> Absolute<Day> { return this() }
    
    /// Retrieve the current calendar hour of the `Clock`
    func thisHour() -> Absolute<Hour> { return this() }
    
    /// Retrieve the current calendar minute of the `Clock`
    func thisMinute() -> Absolute<Minute> { return this() }
    
    /// Retrieve the current calendar second of the `Clock`
    func thisSecond() -> Absolute<Second> { return this() }
    
    /// Retrieve the current calendar nanosecond of the `Clock`
    func thisNanosecond() -> Absolute<Nanosecond> { return this() }
    
    func nextYear() -> Absolute<Year> { return this().adding(years: 1) }
    func nextMonth() -> Absolute<Month> { return this().adding(months: 1) }
    func nextDay() -> Absolute<Day> { return this().adding(days: 1) }
    func nextHour() -> Absolute<Hour> { return this().adding(hours: 1) }
    func nextMinute() -> Absolute<Minute> { return this().adding(minutes: 1) }
    func nextSecond() -> Absolute<Second> { return this().adding(seconds: 1) }

    func previousYear() -> Absolute<Year> { return this().subtracting(years: 1) }
    func previousMonth() -> Absolute<Month> { return this().subtracting(months: 1) }
    func previousDay() -> Absolute<Day> { return this().subtracting(days: 1) }
    func previousHour() -> Absolute<Hour> { return this().subtracting(hours: 1) }
    func previousMinute() -> Absolute<Minute> { return this().subtracting(minutes: 1) }
    func previousSecond() -> Absolute<Second> { return this().subtracting(seconds: 1) }
}
