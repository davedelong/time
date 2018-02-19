//
//  YearMonthDayHourMinuteSecondNanosecond.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol NanosecondField {
    var nanosecondValue: Int { get }
}

public extension NanosecondField where Self: CalendarValue {
    var nanosecond: Nanosecond { return Nanosecond(dateComponents: dateComponents, region: region) }
    var nanosecondValue: Int { return dateComponents.nanosecond.unwrap("Cannot create an NanosecondField without a nanosecond value") }
}

public extension NanosecondField where Self: Anchored, Self: CalendarValue {
    var yearMonthDayHourMinuteSecond: YearMonthDayHourMinuteSecond { return YearMonthDayHourMinuteSecond(dateComponents: self.dateComponents, region: region) }
}

public struct YearMonthDayHourMinuteSecondNanosecond: CalendarValue, EraField, YearField, MonthField, DayField, HourField, MinuteField, SecondField, NanosecondField, Anchored, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second, .nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
