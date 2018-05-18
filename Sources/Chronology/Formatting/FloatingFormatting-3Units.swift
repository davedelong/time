//
//  FloatingFormatting-3Units.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension CalendarValue where Self: YearMonthDayFields {
    func format(year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [year, month, day, timeZone])
    }
}

public extension CalendarValue where Self: MonthDayHourFields {
    func format(month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [month, day, hour, timeZone])
    }
}

public extension CalendarValue where Self: DayHourMinuteFields {
    func format(day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [day, hour, minute, timeZone])
    }
}

public extension CalendarValue where Self: HourMinuteSecondFields {
    func format(hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [hour, minute, second, timeZone])
    }
}

public extension CalendarValue where Self: MinuteSecondNanosecondFields {
    func format(minute:FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [minute, second, nanosecond, timeZone])
    }
}
