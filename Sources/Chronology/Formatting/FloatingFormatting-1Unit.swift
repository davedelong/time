//
//  FloatingFormatting.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension CalendarValue where Self: YearField {
    func format(year: Template<YearField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(floating: [year, timeZone])
    }
}

public extension CalendarValue where Self: MonthField {
    func format(month: Template<Standalone<MonthField>>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(floating: [month, timeZone])
    }
}

public extension CalendarValue where Self: DayField {
    func format(day: Template<DayField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(floating: [day, timeZone])
    }
    func format(weekday: Template<Standalone<Weekday>>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(floating: [weekday, timeZone])
    }
}

public extension CalendarValue where Self: HourField {
    func format(hour: Template<HourField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(floating: [hour, timeZone])
    }
}

public extension CalendarValue where Self: MinuteField {
    func format(minute: Template<MinuteField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(floating: [minute, timeZone])
    }
}

public extension CalendarValue where Self: SecondField {
    func format(second: Template<SecondField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(floating: [second, timeZone])
    }
}

public extension CalendarValue where Self: NanosecondField {
    func format(nanosecond: Template<NanosecondField>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(floating: [nanosecond, timeZone])
    }
}
