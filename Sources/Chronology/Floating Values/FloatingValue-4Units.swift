//
//  FloatingValue-4Units.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct MonthDayHourMinute: CalendarValue, MonthField, DayField, HourField, MinuteField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.month, .day, .hour, .minute]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct DayHourMinuteSecond: CalendarValue, DayField, HourField, MinuteField, SecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.day, .hour, .minute, .second]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct HourMinuteSecondNanosecond: CalendarValue, HourField, MinuteField, SecondField, NanosecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.hour, .minute, .second, .nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
}

