//
//  Clock+CurrentValues.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Clock {
    
    public func currentEra() -> Era { return Era(instant: thisInstant(), region: region) }
    public func currentYear() -> Year { return Year(instant: thisInstant(), region: region) }
    public func currentYearMonth() -> YearMonth { return YearMonth(instant: thisInstant(), region: region) }
    public func currentYearMonthDay() -> YearMonthDay { return YearMonthDay(instant: thisInstant(), region: region) }
    public func currentYearMonthDayHour() -> YearMonthDayHour { return YearMonthDayHour(instant: thisInstant(), region: region) }
    public func currentYearMonthDayHourMinute() -> YearMonthDayHourMinute { return YearMonthDayHourMinute(instant: thisInstant(), region: region) }
    public func currentYearMonthDayHourMinuteSecond() -> YearMonthDayHourMinuteSecond { return YearMonthDayHourMinuteSecond(instant: thisInstant(), region: region) }
    public func currentYearMonthDayHourMinuteSecondNanosecond() -> YearMonthDayHourMinuteSecondNanosecond { return YearMonthDayHourMinuteSecondNanosecond(instant: thisInstant(), region: region) }
    
    public func currentMonth() -> Month { return Month(instant: thisInstant(), region: region) }
    public func currentDay() -> Day { return Day(instant: thisInstant(), region: region) }
    public func currentHour() -> Hour { return Hour(instant: thisInstant(), region: region) }
    public func currentMinute() -> Minute { return Minute(instant: thisInstant(), region: region) }
    public func currentSecond() -> Second { return Second(instant: thisInstant(), region: region) }
    public func currentNanosecond() -> Nanosecond { return Nanosecond(instant: thisInstant(), region: region) }
    
}
