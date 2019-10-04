//
//  RelativeFields.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

/// Access the one-unit absolute values

public extension CalendarValue where Self: EraField {
    var era: Absolute<Era> { return Absolute(region: region, dateComponents: dateComponents) }
    var eraValue: Int { return dateComponents.era.unwrap("An EraField must have an era value") }
}

public extension CalendarValue where Self: YearField {
    var year: Absolute<Year> { return Absolute(region: region, dateComponents: dateComponents) }
    var yearValue: Int { return dateComponents.year.unwrap("A YearField must have a year value") }
}

/// Access the one-unit relative values

public extension CalendarValue where Self: MonthField {
    var month: Relative<Month, Year> { return Relative(region: region, dateComponents: dateComponents) }
    var monthValue: Int { return dateComponents.month.unwrap("A MonthField must have a month value") }
}

public extension CalendarValue where Self: DayField {
    var day: Relative<Day, Month> { return Relative(region: region, dateComponents: dateComponents) }
    var dayValue: Int { return dateComponents.day.unwrap("A DayField must have a day value") }
}

public extension CalendarValue where Self: HourField {
    var hour: Relative<Hour, Day> { return Relative(region: region, dateComponents: dateComponents) }
    var hourValue: Int { return dateComponents.hour.unwrap("An HourField must have an hour value") }
}

public extension CalendarValue where Self: MinuteField {
    var minute: Relative<Minute, Hour> { return Relative(region: region, dateComponents: dateComponents) }
    var minuteValue: Int { return dateComponents.minute.unwrap("A MinuteField must have a minute value") }
}

public extension CalendarValue where Self: SecondField {
    var second: Relative<Second, Minute> { return Relative(region: region, dateComponents: dateComponents) }
    var secondValue: Int { return dateComponents.second.unwrap("A SecondField must have a second value") }
}

public extension CalendarValue where Self: NanosecondField {
    var nanosecond: Relative<Nanosecond, Second> { return Relative(region: region, dateComponents: dateComponents) }
    var nanosecondValue: Int { return dateComponents.nanosecond.unwrap("A NanosecondField must have a nanosecond value") }
}

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

