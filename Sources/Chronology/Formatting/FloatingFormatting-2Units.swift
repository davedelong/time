//
//  FloatingFormatting-2Units.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension CalendarValue where Self: YearMonthFields {
    func format(year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>) -> String {
        return formatFloating(using: [year, month])
    }
}

public extension CalendarValue where Self: MonthDayFields {
    func format(month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                weekday: FormatTemplate<Weekday>? = nil) -> String {
        return formatFloating(using: [month, day, weekday])
    }
}

public extension CalendarValue where Self: DayHourFields {
    func format(day: FormatTemplate<DayField>,
                weekday: FormatTemplate<Weekday>? = nil,
                hour: FormatTemplate<HourField>) -> String {
        return formatFloating(using: [day, weekday, hour])
    }
}

public extension CalendarValue where Self: HourMinuteFields {
    func format(hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>) -> String {
        return formatFloating(using: [hour, minute])
    }
}

public extension CalendarValue where Self: MinuteSecondFields {
    func format(minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>) -> String {
        return formatFloating(using: [minute, second])
    }
}

public extension CalendarValue where Self: SecondNanosecondFields {
    func format(second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>) -> String {
        return formatFloating(using: [second, nanosecond])
    }
}
