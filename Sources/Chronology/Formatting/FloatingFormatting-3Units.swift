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
                day: FormatTemplate<DayField>) -> String {
        return formatFloating(using: [year, month, day])
    }
}

public extension CalendarValue where Self: MonthDayHourFields {
    func format(month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>) -> String {
        return formatFloating(using: [month, day, hour])
    }
}

public extension CalendarValue where Self: DayHourMinuteFields {
    func format(day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>) -> String {
        return formatFloating(using: [day, hour, minute])
    }
}

public extension CalendarValue where Self: HourMinuteSecondFields {
    func format(hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>) -> String {
        return formatFloating(using: [hour, minute, second])
    }
}

public extension CalendarValue where Self: MinuteSecondNanosecondFields {
    func format(minute:FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>) -> String {
        return formatFloating(using: [minute, second, nanosecond])
    }
}
