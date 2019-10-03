//
//  RelativeFields.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

/// Access the two-unit relative values

public extension CalendarValue where Self: MonthDayFields {
    var monthDay: Relative<Day, Year> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayHourFields {
    var dayHour: Relative<Hour, Month> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: HourMinuteFields {
    var hourMinute: Relative<Minute, Day> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: MinuteSecondFields {
    var minuteSecond: Relative<Second, Hour> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: SecondNanosecondFields {
    var secondNanosecond: Relative<Nanosecond, Minute> { return Relative(region: region, dateComponents: dateComponents) }
}

/// Access the three-unit relative values

public extension CalendarValue where Self: MonthDayHourFields {
    var monthDayHour: Relative<Hour, Year> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayHourMinuteFields {
    var dayHourMinute: Relative<Minute, Month> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: HourMinuteSecondFields {
    var hourMinuteSecond: Relative<Second, Day> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: MinuteSecondNanosecondFields {
    var minuteSecondNanosecond: Relative<Nanosecond, Hour> { return Relative(region: region, dateComponents: dateComponents) }
}

/// Access the four-unit relative values

public extension CalendarValue where Self: MonthDayHourMinuteFields {
    var monthDayHourMinute: Relative<Minute, Year> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayHourMinuteSecondFields {
    var dayHourMinuteSecond: Relative<Second, Month> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: HourMinuteSecondNanosecondFields {
    var hourMinuteSecondNanosecond: Relative<Nanosecond, Day> { return Relative(region: region, dateComponents: dateComponents) }
}

/// Access the five- and six-unit relative values

public extension CalendarValue where Self: MonthDayHourMinuteSecondFields {
    var monthDayHourMinuteSecond: Relative<Second, Year> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayHourMinuteSecondNanosecondFields {
    var dayHourMinuteSecondNanosecond: Relative<Nanosecond, Month> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: MonthDayHourMinuteSecondNanosecondFields {
    var monthDayHourMinuteSecondNanosecond: Relative<Nanosecond, Year> { return Relative(region: region, dateComponents: dateComponents) }
}

