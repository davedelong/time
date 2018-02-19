//
//  FloatingValue-2Units.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct MonthDay: CalendarValue, MonthField, DayField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.month, .day]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct DayHour: CalendarValue, DayField, HourField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.day, .hour]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct HourMinute: CalendarValue, HourField, MinuteField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.hour, .minute]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct MinuteSecond: CalendarValue, MinuteField, SecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.minute, .second]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct SecondNanosecond: CalendarValue, SecondField, NanosecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.second, .nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
}
