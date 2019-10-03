//
//  RelativeFormatting-2Units.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension CalendarValue where Self: YearMonthFields {
    func format(year: Template<YearField>,
                month: Template<MonthField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [year, month, timeZone])
    }
}

public extension CalendarValue where Self: MonthDayFields {
    func format(month: Template<MonthField>,
                day: Template<DayField>,
                weekday: Template<Weekday>? = nil,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [month, day, weekday, timeZone])
    }
}

public extension CalendarValue where Self: DayHourFields {
    func format(day: Template<DayField>,
                weekday: Template<Weekday>? = nil,
                hour: Template<HourField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [day, weekday, hour, timeZone])
    }
}

public extension CalendarValue where Self: HourMinuteFields {
    func format(hour: Template<HourField>,
                minute: Template<MinuteField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [hour, minute, timeZone])
    }
}

public extension CalendarValue where Self: MinuteSecondFields {
    func format(minute: Template<MinuteField>,
                second: Template<SecondField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [minute, second, timeZone])
    }
}

public extension CalendarValue where Self: SecondNanosecondFields {
    func format(second: Template<SecondField>,
                nanosecond: Template<NanosecondField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [second, nanosecond, timeZone])
    }
}
