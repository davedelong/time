//
//  AbsoluteFields.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Absolute: EraField {
    var era: Absolute<Era> { return Absolute<Era>(region: region, dateComponents: dateComponents) }
}

extension Absolute: YearField where Lower: LessThanEra {
    var year: Absolute<Year> { return Absolute<Year>(region: region, dateComponents: dateComponents) }
}

extension Absolute: MonthField where Lower: LessThanYear {
    var yearMonth: Absolute<Month> { return Absolute<Month>(region: region, dateComponents: dateComponents) }
}

extension Absolute: DayField where Lower: LessThanMonth {
    var yearMonthDay: Absolute<Day> { return Absolute<Day>(region: region, dateComponents: dateComponents) }
    
    var isWeekend: Bool { return calendar.isDateInWeekend(approximateMidPoint.date) }
    var isWeekday: Bool { return !isWeekend }
    var dayOfWeek: Int { return calendar.component(.weekday, from: approximateMidPoint.date) }
}

extension Absolute: HourField where Lower: LessThanDay {
    var yearMonthDayHour: Absolute<Hour> { return Absolute<Hour>(region: region, dateComponents: dateComponents) }
}

extension Absolute: MinuteField where Lower: LessThanHour {
    var yearMonthDayHourMinute: Absolute<Minute> { return Absolute<Minute>(region: region, dateComponents: dateComponents) }
}

extension Absolute: SecondField where Lower: LessThanMinute {
    var yearMonthDayHourMinuteSecond: Absolute<Second> { return Absolute<Second>(region: region, dateComponents: dateComponents) }
}

extension Absolute: NanosecondField where Lower: LessThanSecond { }
