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
    
    // single unit floating values
    public func thisMonth() -> Month { return Month(instant: thisInstant(), region: region) }
    public func thisDay() -> Day { return Day(instant: thisInstant(), region: region) }
    public func thisHour() -> Hour { return Hour(instant: thisInstant(), region: region) }
    public func thisMinute() -> Minute { return Minute(instant: thisInstant(), region: region) }
    public func thisSecond() -> Second { return Second(instant: thisInstant(), region: region) }
    public func thisNanosecond() -> Nanosecond { return Nanosecond(instant: thisInstant(), region: region) }
    
    // two unit floating values
    public func thisMonthDay() -> MonthDay { return MonthDay(instant: thisInstant(), region: region) }
    public func thisDayHour() -> DayHour { return DayHour(instant: thisInstant(), region: region) }
    public func thisHourMinute() -> HourMinute { return HourMinute(instant: thisInstant(), region: region) }
    public func thisMinuteSecond() -> MinuteSecond { return MinuteSecond(instant: thisInstant(), region: region) }
    public func thisSecondNanosecond() -> SecondNanosecond { return SecondNanosecond(instant: thisInstant(), region: region) }
    
    // three unit floating values
    public func thisMonthDayHour() -> MonthDayHour { return MonthDayHour(instant: thisInstant(), region: region) }
    public func thisDayHourMinute() -> DayHourMinute { return DayHourMinute(instant: thisInstant(), region: region) }
    public func thisHourMinuteSecond() -> HourMinuteSecond { return HourMinuteSecond(instant: thisInstant(), region: region) }
    public func thisMinuteSecondNanosecond() -> MinuteSecondNanosecond { return MinuteSecondNanosecond(instant: thisInstant(), region: region) }
    
    // four unit floating values
    public func thisMonthDayHourMinute() -> MonthDayHourMinute { return MonthDayHourMinute(instant: thisInstant(), region: region) }
    public func thisDayHourMinuteSecond() -> DayHourMinuteSecond { return DayHourMinuteSecond(instant: thisInstant(), region: region) }
    public func thisHourMinuteSecondNanosecond() -> HourMinuteSecondNanosecond { return HourMinuteSecondNanosecond(instant: thisInstant(), region: region) }
    
    // five unit floating values
    public func thisMonthDayHourMinuteSecond() -> MonthDayHourMinuteSecond { return MonthDayHourMinuteSecond(instant: thisInstant(), region: region) }
    public func thisDayHourMinuteSecondNanosecond() -> DayHourMinuteSecondNanosecond { return DayHourMinuteSecondNanosecond(instant: thisInstant(), region: region) }
    
    // six unit floating values
    public func thisMonthDayHourMinuteSecondNanosecond() -> MonthDayHourMinuteSecondNanosecond { return MonthDayHourMinuteSecondNanosecond(instant: thisInstant(), region: region) }
}
