//
//  Clock+CurrentValues.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Clock {
    func now() -> Instant { return thisInstant() }
    func this<C: Unit>() -> Absolute<C> { return Absolute(region: region, instant: thisInstant()) }
    
    func today() -> Absolute<Day> { return this() }
    func tomorrow() -> Absolute<Day> { return today() + .days(1) }
    func yesterday() -> Absolute<Day> { return today() - .days(1) }
    
    func thisEra() -> Absolute<Era> { return this() }
    func thisYear() -> Absolute<Year> { return this() }
    func thisMonth() -> Absolute<Month> { return this() }
    func thisDay() -> Absolute<Day> { return this() }
    func thisHour() -> Absolute<Hour> { return this() }
    func thisMinute() -> Absolute<Minute> { return this() }
    func thisSecond() -> Absolute<Second> { return this() }
    func thisNanosecond() -> Absolute<Nanosecond> { return this() }
    
    func nextYear() -> Absolute<Year> { return this() + .years(1) }
    func nextMonth() -> Absolute<Month> { return this() + .months(1) }
    func nextDay() -> Absolute<Day> { return this() + .days(1) }
    func nextHour() -> Absolute<Hour> { return this() + .hours(1) }
    func nextMinute() -> Absolute<Minute> { return this() + .minutes(1) }
    func nextSecond() -> Absolute<Second> { return this() + .seconds(1) }

    func previousYear() -> Absolute<Year> { return this() - .years(1) }
    func previousMonth() -> Absolute<Month> { return this() - .months(1) }
    func previousDay() -> Absolute<Day> { return this() - .days(1) }
    func previousHour() -> Absolute<Hour> { return this() - .hours(1) }
    func previousMinute() -> Absolute<Minute> { return this() - .minutes(1) }
    func previousSecond() -> Absolute<Second> { return this() - .seconds(1) }
}
