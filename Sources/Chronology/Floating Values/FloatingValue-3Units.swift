//
//  FloatingValue-3Units.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct MonthDayHour: CalendarValue, MonthField, DayField, HourField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.month, .day, .hour]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct DayHourMinute: CalendarValue, DayField, HourField, MinuteField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.day, .hour, .minute]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct HourMinuteSecond: CalendarValue, HourField, MinuteField, SecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.hour, .minute, .second]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct MinuteSecondNanosecond: CalendarValue, MinuteField, SecondField, NanosecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.minute, .second, .nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
}
