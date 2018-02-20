//
//  Clock+CurrentValues.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Clock {
    
    public func now() -> Instant { return thisInstant() }
    public func this<C: CalendarValue & Anchored>() -> C { return C.init(instant: thisInstant(), region: region) }
    
    public func today() -> YearMonthDay { return this() }
    public func tomorrow() -> YearMonthDay { return today() + .days(1) }
    public func yesterday() -> YearMonthDay { return today() - .days(1) }
    
    public func thisEra() -> Era { return this() }
    public func thisYear() -> Year { return this() }
    public func thisMonth() -> YearMonth { return this() }
    public func thisDay() -> YearMonthDay { return this() }
    public func thisHour() -> YearMonthDayHour { return this() }
    public func thisMinute() -> YearMonthDayHourMinute { return this() }
    public func thisSecond() -> YearMonthDayHourMinuteSecond { return this() }
    public func thisNanosecond() -> YearMonthDayHourMinuteSecondNanosecond { return this() }
    
    public func nextYear() -> Year { return this() + .years(1) }
    public func nextMonth() -> YearMonth { return this() + .months(1) }
    public func nextDay() -> YearMonthDay { return this() + .days(1) }
    public func nextHour() -> YearMonthDayHour { return this() + .hours(1) }
    public func nextMinute() -> YearMonthDayHourMinute { return this() + .minutes(1) }
    public func nextSecond() -> YearMonthDayHourMinuteSecond { return this() + .seconds(1) }
    
    public func previousYear() -> Year { return this() - .years(1) }
    public func previousMonth() -> YearMonth { return this() - .months(1) }
    public func previousDay() -> YearMonthDay { return this() - .days(1) }
    public func previousHour() -> YearMonthDayHour { return this() - .hours(1) }
    public func previousMinute() -> YearMonthDayHourMinute { return this() - .minutes(1) }
    public func previousSecond() -> YearMonthDayHourMinuteSecond { return this() - .seconds(1) }
}
