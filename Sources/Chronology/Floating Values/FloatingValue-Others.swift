//
//  FloatingValue-Others.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct MonthDayHourMinuteSecond: CalendarValue, MonthField, DayField, HourField, MinuteField, SecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.month, .day, .hour, .minute, .second]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct DayHourMinuteSecondNanosecond: CalendarValue, DayField, HourField, MinuteField, SecondField, NanosecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.day, .hour, .minute, .second, .nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct MonthDayHourMinuteSecondNanosecond: CalendarValue, MonthField, DayField, HourField, MinuteField, SecondField, NanosecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.month, .day, .hour, .minute, .second, .nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
}
