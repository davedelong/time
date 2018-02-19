//
//  __AnchoredValues.swift
//  Chronology
//
//  Created by Dave DeLong on 11/30/17.
//

import Foundation

protocol Anchored: RegionField { }

protocol Year: EraField, YearField, Anchored {
    func set(month: Int) -> YearMonth
    func set(month: Int, policy: Policy) throws -> YearMonth
    
    func set(month: Int, day: Int) -> YearMonthDay
    func set(month: Int, day: Int, policy: Policy) throws -> YearMonthDay
    
    func set(month: Int, day: Int, hour: Int) -> YearMonthDayHour
    func set(month: Int, day: Int, hour: Int, policy: Policy) throws -> YearMonthDayHour
    
    func set(month: Int, day: Int, hour: Int, minute: Int) -> YearMonthDayHourMinute
    func set(month: Int, day: Int, hour: Int, minute: Int, policy: Policy) throws -> YearMonthDayHourMinute
    
    func set(month: Int, day: Int, hour: Int, minute: Int, second: Int) -> YearMonthDayHourMinuteSecond
    func set(month: Int, day: Int, hour: Int, minute: Int, second: Int, policy: Policy) throws -> YearMonthDayHourMinuteSecond
    
    func set(month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) -> PreciseYearMonthDayHourMinuteSecond
    func set(month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int, policy: Policy) throws -> PreciseYearMonthDayHourMinuteSecond
}

protocol YearMonth: Year, MonthField {
    func set(day: Int) -> YearMonthDay
    func set(day: Int, policy: Policy) throws -> YearMonthDay
    
    func set(day: Int, hour: Int) -> YearMonthDayHour
    func set(day: Int, hour: Int, policy: Policy) throws -> YearMonthDayHour
    
    func set(day: Int, hour: Int, minute: Int) -> YearMonthDayHourMinute
    func set(day: Int, hour: Int, minute: Int, policy: Policy) throws -> YearMonthDayHourMinute
    
    func set(day: Int, hour: Int, minute: Int, second: Int) -> YearMonthDayHourMinuteSecond
    func set(day: Int, hour: Int, minute: Int, second: Int, policy: Policy) throws -> YearMonthDayHourMinuteSecond
    
    func set(day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) -> PreciseYearMonthDayHourMinuteSecond
    func set(day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int, policy: Policy) throws -> PreciseYearMonthDayHourMinuteSecond
}

protocol YearMonthDay: YearMonth, DayField {
    func set(month: Int) -> YearMonthDay
    func set(month: Int, policy: Policy) throws -> YearMonthDay
    
    ////
    
    func set(hour: Int) -> YearMonthDayHour
    func set(hour: Int, policy: Policy) throws -> YearMonthDayHour
    
    func set(hour: Int, minute: Int) -> YearMonthDayHourMinute
    func set(hour: Int, minute: Int, policy: Policy) throws -> YearMonthDayHourMinute
    
    func set(hour: Int, minute: Int, second: Int) -> YearMonthDayHourMinuteSecond
    func set(hour: Int, minute: Int, second: Int, policy: Policy) throws -> YearMonthDayHourMinuteSecond
    
    func set(hour: Int, minute: Int, second: Int, nanosecond: Int) -> PreciseYearMonthDayHourMinuteSecond
    func set(hour: Int, minute: Int, second: Int, nanosecond: Int, policy: Policy) throws -> PreciseYearMonthDayHourMinuteSecond
}

protocol YearMonthDayHour: YearMonthDay, HourField {
    func set(month: Int) -> YearMonthDayHour
    func set(month: Int, policy: Policy) throws -> YearMonthDayHour
    
    func set(day: Int) -> YearMonthDayHour
    func set(day: Int, policy: Policy) throws -> YearMonthDayHour
    
    func set(month: Int, day: Int) -> YearMonthDayHour
    func set(month: Int, day: Int, policy: Policy) throws -> YearMonthDayHour
    
    ////
    
    func set(minute: Int) -> YearMonthDayHourMinute
    func set(minute: Int, policy: Policy) throws -> YearMonthDayHourMinute
    
    func set(minute: Int, second: Int) -> YearMonthDayHourMinuteSecond
    func set(minute: Int, second: Int, policy: Policy) throws -> YearMonthDayHourMinuteSecond
    
    func set(minute: Int, second: Int, nanosecond: Int) -> PreciseYearMonthDayHourMinuteSecond
    func set(minute: Int, second: Int, nanosecond: Int, policy: Policy) throws -> PreciseYearMonthDayHourMinuteSecond
}

protocol YearMonthDayHourMinute: YearMonthDayHour, MinuteField {
    func set(month: Int) -> YearMonthDayHourMinute
    func set(month: Int, policy: Policy) throws -> YearMonthDayHourMinute
    
    func set(day: Int) -> YearMonthDayHourMinute
    func set(day: Int, policy: Policy) throws -> YearMonthDayHourMinute
    
    func set(hour: Int) -> YearMonthDayHourMinute
    func set(hour: Int, policy: Policy) throws -> YearMonthDayHourMinute
    
    func set(month: Int, day: Int) -> YearMonthDayHourMinute
    func set(month: Int, day: Int, policy: Policy) throws -> YearMonthDayHourMinute
    
    func set(month: Int, day: Int, hour: Int) -> YearMonthDayHourMinute
    func set(month: Int, day: Int, hour: Int, policy: Policy) throws -> YearMonthDayHourMinute
    
    ////
    
    func set(second: Int) -> YearMonthDayHourMinuteSecond
    func set(second: Int, policy: Policy) throws -> YearMonthDayHourMinuteSecond
    
    func set(second: Int, nanosecond: Int) -> PreciseYearMonthDayHourMinuteSecond
    func set(second: Int, nanosecond: Int, policy: Policy) throws -> PreciseYearMonthDayHourMinuteSecond
}

protocol YearMonthDayHourMinuteSecond: YearMonthDayHourMinute, SecondField {
    func set(month: Int) -> YearMonthDayHourMinuteSecond
    func set(month: Int, policy: Policy) throws -> YearMonthDayHourMinuteSecond
    
    func set(day: Int) -> YearMonthDayHourMinuteSecond
    func set(day: Int, policy: Policy) throws -> YearMonthDayHourMinuteSecond
    
    func set(hour: Int) -> YearMonthDayHourMinuteSecond
    func set(hour: Int, policy: Policy) throws -> YearMonthDayHourMinuteSecond
    
    func set(minute: Int) -> YearMonthDayHourMinuteSecond
    func set(minute: Int, policy: Policy) throws -> YearMonthDayHourMinuteSecond
    
    func set(month: Int, day: Int) -> YearMonthDayHourMinuteSecond
    func set(month: Int, day: Int, policy: Policy) throws -> YearMonthDayHourMinuteSecond
    
    func set(month: Int, day: Int, hour: Int) -> YearMonthDayHourMinuteSecond
    func set(month: Int, day: Int, hour: Int, policy: Policy) throws -> YearMonthDayHourMinuteSecond
    
    func set(month: Int, day: Int, hour: Int, minute: Int) -> YearMonthDayHourMinuteSecond
    func set(month: Int, day: Int, hour: Int, minute: Int, policy: Policy) throws -> YearMonthDayHourMinuteSecond
    
    ////
    
    func set(nanosecond: Int) -> PreciseYearMonthDayHourMinuteSecond
    func set(nanosecond: Int, policy: Policy) throws -> PreciseYearMonthDayHourMinuteSecond
}

protocol PreciseYearMonthDayHourMinuteSecond: YearMonthDayHourMinuteSecond, NanosecondField { }
