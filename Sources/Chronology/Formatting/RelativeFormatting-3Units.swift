//
//  RelativeFormatting-3Units.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension CalendarValue where Self: YearMonthDayFields {
    func format(year: Template<YearField>,
                month: Template<MonthField>,
                day: Template<DayField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [year, month, day, timeZone])
    }
}

public extension CalendarValue where Self: MonthDayHourFields {
    func format(month: Template<MonthField>,
                day: Template<DayField>,
                hour: Template<HourField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [month, day, hour, timeZone])
    }
}

public extension CalendarValue where Self: DayHourMinuteFields {
    func format(day: Template<DayField>,
                hour: Template<HourField>,
                minute: Template<MinuteField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [day, hour, minute, timeZone])
    }
}

public extension CalendarValue where Self: HourMinuteSecondFields {
    func format(hour: Template<HourField>,
                minute: Template<MinuteField>,
                second: Template<SecondField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [hour, minute, second, timeZone])
    }
}

public extension CalendarValue where Self: MinuteSecondNanosecondFields {
    func format(minute:Template<MinuteField>,
                second: Template<SecondField>,
                nanosecond: Template<NanosecondField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [minute, second, nanosecond, timeZone])
    }
}
