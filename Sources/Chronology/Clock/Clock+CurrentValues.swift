//
//  Clock+CurrentValues.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Clock {
    func now() -> Instant { return thisInstant() }
    func this<C: CalendarValue & Anchored>() -> C { return C.init(instant: thisInstant(), region: region) }
    
    func today() -> YearMonthDay { return this() }
    func tomorrow() -> YearMonthDay { return today() + .days(1) }
    func yesterday() -> YearMonthDay { return today() - .days(1) }
    
    func thisEra() -> Era { return this() }
    func thisYear() -> Year { return this() }
    func thisMonth() -> YearMonth { return this() }
    func thisDay() -> YearMonthDay { return this() }
    func thisHour() -> YearMonthDayHour { return this() }
    func thisMinute() -> YearMonthDayHourMinute { return this() }
    func thisSecond() -> YearMonthDayHourMinuteSecond { return this() }
    func thisNanosecond() -> YearMonthDayHourMinuteSecondNanosecond { return this() }
    
    func nextYear() -> Year { return this() + .years(1) }
    func nextMonth() -> YearMonth { return this() + .months(1) }
    func nextDay() -> YearMonthDay { return this() + .days(1) }
    func nextHour() -> YearMonthDayHour { return this() + .hours(1) }
    func nextMinute() -> YearMonthDayHourMinute { return this() + .minutes(1) }
    func nextSecond() -> YearMonthDayHourMinuteSecond { return this() + .seconds(1) }
    
    func previousYear() -> Year { return this() - .years(1) }
    func previousMonth() -> YearMonth { return this() - .months(1) }
    func previousDay() -> YearMonthDay { return this() - .days(1) }
    func previousHour() -> YearMonthDayHour { return this() - .hours(1) }
    func previousMinute() -> YearMonthDayHourMinute { return this() - .minutes(1) }
    func previousSecond() -> YearMonthDayHourMinuteSecond { return this() - .seconds(1) }
}
