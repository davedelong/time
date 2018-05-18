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
                hour: FormatTemplate<HourField>) -> String {
        return formatFloating(using: [year, month, day, hour])
    }
}

public extension CalendarValue where Self: MonthDayHourMinuteFields {
    func format(month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>) -> String {
        return formatFloating(using: [month, day, hour, minute])
    }
}

public extension CalendarValue where Self: DayHourMinuteSecondFields {
    func format(day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>) -> String {
        return formatFloating(using: [day, hour, minute, second])
    }
}

public extension CalendarValue where Self: HourMinuteSecondNanosecondFields {
    func format(hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>) -> String {
        return formatFloating(using: [hour, minute, second, nanosecond])
    }
}
