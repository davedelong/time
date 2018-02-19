//
//  Clock+CurrentValues.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Clock {
    
    public func thisEra() -> Era { return Era(instant: thisInstant(), region: region) }
    public func thisYear() -> Year { return Year(instant: thisInstant(), region: region) }
    public func thisYearMonth() -> YearMonth { return YearMonth(instant: thisInstant(), region: region) }
    public func thisYearMonthDay() -> YearMonthDay { return YearMonthDay(instant: thisInstant(), region: region) }
    public func thisYearMonthDayHour() -> YearMonthDayHour { return YearMonthDayHour(instant: thisInstant(), region: region) }
    public func thisYearMonthDayHourMinute() -> YearMonthDayHourMinute { return YearMonthDayHourMinute(instant: thisInstant(), region: region) }
    public func thisYearMonthDayHourMinuteSecond() -> YearMonthDayHourMinuteSecond { return YearMonthDayHourMinuteSecond(instant: thisInstant(), region: region) }
    public func thisYearMonthDayHourMinuteSecondNanosecond() -> YearMonthDayHourMinuteSecondNanosecond { return YearMonthDayHourMinuteSecondNanosecond(instant: thisInstant(), region: region) }
    
    public func thisMonth() -> Month { return Month(instant: thisInstant(), region: region) }
    public func thisDay() -> Day { return Day(instant: thisInstant(), region: region) }
    public func thisHour() -> Hour { return Hour(instant: thisInstant(), region: region) }
    public func thisMinute() -> Minute { return Minute(instant: thisInstant(), region: region) }
    public func thisSecond() -> Second { return Second(instant: thisInstant(), region: region) }
    public func thisNanosecond() -> Nanosecond { return Nanosecond(instant: thisInstant(), region: region) }
    
}
