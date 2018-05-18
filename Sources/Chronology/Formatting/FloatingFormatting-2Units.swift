//
//  FloatingFormatting-2Units.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension CalendarValue where Self: YearMonthFields {
    func format(year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [year, month, timeZone])
    }
}

public extension CalendarValue where Self: MonthDayFields {
    func format(month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                weekday: FormatTemplate<Weekday>? = nil,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [month, day, weekday, timeZone])
    }
}

public extension CalendarValue where Self: DayHourFields {
    func format(day: FormatTemplate<DayField>,
                weekday: FormatTemplate<Weekday>? = nil,
                hour: FormatTemplate<HourField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [day, weekday, hour, timeZone])
    }
}

public extension CalendarValue where Self: HourMinuteFields {
    func format(hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [hour, minute, timeZone])
    }
}

public extension CalendarValue where Self: MinuteSecondFields {
    func format(minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [minute, second, timeZone])
    }
}

public extension CalendarValue where Self: SecondNanosecondFields {
    func format(second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [second, nanosecond, timeZone])
    }
}
