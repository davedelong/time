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
                minute: FormatTemplate<MinuteField>) -> String {
        return formatFloating(using: [year, month, day, hour, minute])
    }
}

public extension CalendarValue where Self: MonthDayHourMinuteSecondFields {
    func format(month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>) -> String {
        return formatFloating(using: [month, day, hour, minute, second])
    }
}

public extension CalendarValue where Self: DayHourMinuteSecondNanosecondFields {
    func format(day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>) -> String {
        return formatFloating(using: [day, hour, minute, second, nanosecond])
    }
}


public extension CalendarValue where Self: YearMonthDayHourMinuteSecondFields {
    func format(year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>) -> String {
        return formatFloating(using: [year, month, day, hour, minute, second])
    }
}

public extension CalendarValue where Self: MonthDayHourMinuteSecondNanosecondFields {
    func format(month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>) -> String {
        return formatFloating(using: [month, day, hour, minute, second, nanosecond])
    }
}


public extension CalendarValue where Self: YearMonthDayHourMinuteSecondNanosecondFields {
    func format(year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>) -> String {
        return formatFloating(using: [year, month, day, hour, minute, second, nanosecond])
    }
}
