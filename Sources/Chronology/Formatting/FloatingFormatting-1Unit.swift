//
//  FloatingFormatting.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension CalendarValue where Self: YearField {
    func format(year: FormatTemplate<YearField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [year, timeZone])
    }
}

public extension CalendarValue where Self: MonthField {
    func format(month: FormatTemplate<Standalone<MonthField>>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [month, timeZone])
    }
}

public extension CalendarValue where Self: DayField {
    func format(day: FormatTemplate<DayField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [day, timeZone])
    }
    func format(weekday: FormatTemplate<Standalone<Weekday>>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [weekday, timeZone])
    }
}

public extension CalendarValue where Self: HourField {
    func format(hour: FormatTemplate<HourField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [hour, timeZone])
    }
}

public extension CalendarValue where Self: MinuteField {
    func format(minute: FormatTemplate<MinuteField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [minute, timeZone])
    }
}

public extension CalendarValue where Self: SecondField {
    func format(second: FormatTemplate<SecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [second, timeZone])
    }
}

public extension CalendarValue where Self: NanosecondField {
    func format(nanosecond: FormatTemplate<NanosecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return format(floating: [nanosecond, timeZone])
    }
}
