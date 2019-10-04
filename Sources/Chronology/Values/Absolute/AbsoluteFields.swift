//
//  AbsoluteFields.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension AbsoluteValue where Self: EraField {
    var era: Absolute<Era> { return Absolute<Era>(region: region, dateComponents: dateComponents) }
}

extension AbsoluteValue where Self: YearField {
    var year: Absolute<Year> { return Absolute<Year>(region: region, dateComponents: dateComponents) }
}

extension AbsoluteValue where Self: MonthField {
    var yearMonth: Absolute<Month> { return Absolute<Month>(region: region, dateComponents: dateComponents) }
}

extension AbsoluteValue where Self: DayField {
    var yearMonthDay: Absolute<Day> { return Absolute<Day>(region: region, dateComponents: dateComponents) }
    
    var isWeekend: Bool { return calendar.isDateInWeekend(approximateMidPoint.date) }
    var isWeekday: Bool { return !isWeekend }
    var dayOfWeek: Int { return calendar.component(.weekday, from: approximateMidPoint.date) }
}

extension AbsoluteValue where Self: HourField {
    var yearMonthDayHour: Absolute<Hour> { return Absolute<Hour>(region: region, dateComponents: dateComponents) }
}

extension AbsoluteValue where Self: MinuteField {
    var yearMonthDayHourMinute: Absolute<Minute> { return Absolute<Minute>(region: region, dateComponents: dateComponents) }
}

extension AbsoluteValue where Self: SecondField {
    var yearMonthDayHourMinuteSecond: Absolute<Second> { return Absolute<Second>(region: region, dateComponents: dateComponents) }
}

extension AbsoluteValue where Self: NanosecondField { }
