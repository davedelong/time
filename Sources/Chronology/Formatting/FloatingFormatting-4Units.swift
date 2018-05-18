//
//  FloatingFormatting-4Units.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension CalendarValue where Self: YearMonthDayHourFields {
    func format(year: Template<YearField>,
                month: Template<MonthField>,
                day: Template<DayField>,
                hour: Template<HourField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(floating: [year, month, day, hour, timeZone])
    }
}

public extension CalendarValue where Self: MonthDayHourMinuteFields {
    func format(month: Template<MonthField>,
                day: Template<DayField>,
                hour: Template<HourField>,
                minute: Template<MinuteField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(floating: [month, day, hour, minute, timeZone])
    }
}

public extension CalendarValue where Self: DayHourMinuteSecondFields {
    func format(day: Template<DayField>,
                hour: Template<HourField>,
                minute: Template<MinuteField>,
                second: Template<SecondField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(floating: [day, hour, minute, second, timeZone])
    }
}

public extension CalendarValue where Self: HourMinuteSecondNanosecondFields {
    func format(hour: Template<HourField>,
                minute: Template<MinuteField>,
                second: Template<SecondField>,
                nanosecond: Template<NanosecondField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(floating: [hour, minute, second, nanosecond, timeZone])
    }
}
