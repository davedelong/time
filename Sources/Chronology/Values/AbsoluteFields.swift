//
//  AbsoluteFields.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Absolute: EraField where Lower: LessThanOrEqualToEra {
    var era: Absolute<Era> { return Absolute<Era>(region: region, dateComponents: dateComponents) }
}

extension Absolute: YearField where Lower: LessThanOrEqualToYear {
    var year: Absolute<Year> { return Absolute<Year>(region: region, dateComponents: dateComponents) }
}

extension Absolute: MonthField where Lower: LessThanOrEqualToMonth {
    var yearMonth: Absolute<Month> { return Absolute<Month>(region: region, dateComponents: dateComponents) }
    
    var isWeekend: Bool { return calendar.isDateInWeekend(approximateMidPoint.date) }
    var isWeekday: Bool { return !isWeekend }
    var dayOfWeek: Int { return calendar.component(.weekday, from: approximateMidPoint.date) }
}

extension Absolute: DayField where Lower: LessThanOrEqualToDay {
    var yearMonthDay: Absolute<Day> { return Absolute<Day>(region: region, dateComponents: dateComponents) }
}

extension Absolute: HourField where Lower: LessThanOrEqualToHour {
    var yearMonthDayHour: Absolute<Hour> { return Absolute<Hour>(region: region, dateComponents: dateComponents) }
}

extension Absolute: MinuteField where Lower: LessThanOrEqualToMinute {
    var yearMonthDayHourMinute: Absolute<Minute> { return Absolute<Minute>(region: region, dateComponents: dateComponents) }
}

extension Absolute: SecondField where Lower: LessThanOrEqualToSecond {
    var yearMonthDayHourMinuteSecond: Absolute<Second> { return Absolute<Second>(region: region, dateComponents: dateComponents) }
}

extension Absolute: NanosecondField where Lower: LessThanOrEqualToNanosecond {
}
