//
//  AbsoluteFields.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension CalendarValue where Largest: GTOEEra {
    var absoluteEra: Absolute<Era> { return Absolute<Era>(region: region, dateComponents: dateComponents) }
}

extension CalendarValue where Smallest: LTOEYear, Largest: GTOEEra {
    var absoluteYear: Absolute<Year> { return Absolute<Year>(region: region, dateComponents: dateComponents) }
}

extension CalendarValue where Smallest: LTOEMonth, Largest: GTOEEra {
    var absoluteMonth: Absolute<Month> { return Absolute<Month>(region: region, dateComponents: dateComponents) }
}

extension CalendarValue where Smallest: LTOEDay, Largest: GTOEEra {
    var absoluteDay: Absolute<Day> { return Absolute<Day>(region: region, dateComponents: dateComponents) }
}
 
/*
extension CalendarValue where Smallest: LessThanMonth, Largest: GreaterThanHour {
    var isWeekend: Bool { return calendar.isDateInWeekend(approximateMidPoint.date) }
    var isWeekday: Bool { return !isWeekend }
    var dayOfWeek: Int { return calendar.component(.weekday, from: approximateMidPoint.date) }
}
*/

extension CalendarValue where Smallest: LTOEHour, Largest: GTOEEra {
    var absoluteHour: Absolute<Hour> { return Absolute<Hour>(region: region, dateComponents: dateComponents) }
}

extension CalendarValue where Smallest: LTOEMinute, Largest: GTOEEra {
    var absoluteMinute: Absolute<Minute> { return Absolute<Minute>(region: region, dateComponents: dateComponents) }
}

extension CalendarValue where Smallest: LTOESecond, Largest: GTOEEra {
    var absoluteSecond: Absolute<Second> { return Absolute<Second>(region: region, dateComponents: dateComponents) }
}
