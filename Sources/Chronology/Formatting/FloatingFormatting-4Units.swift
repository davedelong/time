//
//  FloatingFormatting-4Units.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension CalendarValue where Self: YearMonthDayHourFields {
    func format(year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [year, month, day, hour, timeZone])
    }
}

public extension CalendarValue where Self: MonthDayHourMinuteFields {
    func format(month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [month, day, hour, minute, timeZone])
    }
}

public extension CalendarValue where Self: DayHourMinuteSecondFields {
    func format(day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [day, hour, minute, second, timeZone])
    }
}

public extension CalendarValue where Self: HourMinuteSecondNanosecondFields {
    func format(hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [hour, minute, second, nanosecond, timeZone])
    }
}
