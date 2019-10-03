//
//  Clock+CurrentValues.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Clock {
    func now() -> Instant { return thisInstant() }
    func this<C: Unit>() -> Absolute<C> { return Absolute(instant: thisInstant(), region: region) }
    
    func today() -> Absolute<Day> { return this() }
//    func tomorrow() -> YearMonthDay { return today() + .days(1) }
//    func yesterday() -> YearMonthDay { return today() - .days(1) }
    
    func thisEra() -> Absolute<Era> { return this() }
    func thisYear() -> Absolute<Year> { return this() }
    func thisMonth() -> Absolute<Month> { return this() }
    func thisDay() -> Absolute<Day> { return this() }
    func thisHour() -> Absolute<Hour> { return this() }
    func thisMinute() -> Absolute<Minute> { return this() }
    func thisSecond() -> Absolute<Second> { return this() }
    func thisNanosecond() -> Absolute<Nanosecond> { return this() }
    
//    func nextYear() -> Year { return this() + .years(1) }
//    func nextMonth() -> YearMonth { return this() + .months(1) }
//    func nextDay() -> YearMonthDay { return this() + .days(1) }
//    func nextHour() -> YearMonthDayHour { return this() + .hours(1) }
//    func nextMinute() -> YearMonthDayHourMinute { return this() + .minutes(1) }
//    func nextSecond() -> YearMonthDayHourMinuteSecond { return this() + .seconds(1) }
//
//    func previousYear() -> Year { return this() - .years(1) }
//    func previousMonth() -> YearMonth { return this() - .months(1) }
//    func previousDay() -> YearMonthDay { return this() - .days(1) }
//    func previousHour() -> YearMonthDayHour { return this() - .hours(1) }
//    func previousMinute() -> YearMonthDayHourMinute { return this() - .minutes(1) }
//    func previousSecond() -> YearMonthDayHourMinuteSecond { return this() - .seconds(1) }
}
