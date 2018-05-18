//
//  FloatingFormatting-Others.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension CalendarValue where Self: YearMonthDayHourMinuteFields {
    func format(year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [year, month, day, hour, minute, timeZone])
    }
}

public extension CalendarValue where Self: MonthDayHourMinuteSecondFields {
    func format(month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [month, day, hour, minute, second, timeZone])
    }
}

public extension CalendarValue where Self: DayHourMinuteSecondNanosecondFields {
    func format(day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [day, hour, minute, second, nanosecond, timeZone])
    }
}


public extension CalendarValue where Self: YearMonthDayHourMinuteSecondFields {
    func format(year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [year, month, day, hour, minute, second, timeZone])
    }
}

public extension CalendarValue where Self: MonthDayHourMinuteSecondNanosecondFields {
    func format(month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [month, day, hour, minute, second, nanosecond, timeZone])
    }
}


public extension CalendarValue where Self: YearMonthDayHourMinuteSecondNanosecondFields {
    func format(year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [year, month, day, hour, minute, second, nanosecond, timeZone])
    }
}
