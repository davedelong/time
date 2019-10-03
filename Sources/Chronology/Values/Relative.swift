//
//  Relative.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 10/4/18.
//

import Foundation

/// A marker protocol for generic constraints.
/// A value that is not Absolute is Relative.
public protocol Relative: CalendarValue { }

/// Access the three-unit relative values

public extension CalendarValue where Self: MonthDayHourFields {
    var monthDayHour: MonthDayHour { return MonthDayHour(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayHourMinuteFields {
    var dayHourMinute: DayHourMinute { return DayHourMinute(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: HourMinuteSecondFields {
    var hourMinuteSecond: HourMinuteSecond { return HourMinuteSecond(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: MinuteSecondNanosecondFields {
    var minuteSecondNanosecond: MinuteSecondNanosecond { return MinuteSecondNanosecond(region: region, dateComponents: dateComponents) }
}

/// Access the four-unit relative values

public extension CalendarValue where Self: MonthDayHourMinuteFields {
    var monthDayHourMinute: MonthDayHourMinute { return MonthDayHourMinute(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayHourMinuteSecondFields {
    var dayHourMinuteSecond: DayHourMinuteSecond { return DayHourMinuteSecond(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: HourMinuteSecondNanosecondFields {
    var hourMinuteSecondNanosecond: HourMinuteSecondNanosecond { return HourMinuteSecondNanosecond(region: region, dateComponents: dateComponents) }
}

/// Access the five- and six-unit relative values

public extension CalendarValue where Self: MonthDayHourMinuteSecondFields {
    var monthDayHourMinuteSecond: MonthDayHourMinuteSecond { return MonthDayHourMinuteSecond(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayHourMinuteSecondNanosecondFields {
    var dayHourMinuteSecondNanosecond: DayHourMinuteSecondNanosecond { return DayHourMinuteSecondNanosecond(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: MonthDayHourMinuteSecondNanosecondFields {
    var monthDayHourMinuteSecondNanosecond: MonthDayHourMinuteSecondNanosecond { return MonthDayHourMinuteSecondNanosecond(region: region, dateComponents: dateComponents) }
}
