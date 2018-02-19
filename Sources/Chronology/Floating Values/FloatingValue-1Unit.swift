//
//  FloatingValue-1Unit.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Month: CalendarValue, MonthField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.month]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct Day: CalendarValue, DayField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.day]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct Hour: CalendarValue, HourField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.hour]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct Minute: CalendarValue, MinuteField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.minute]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct Second: CalendarValue, SecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.second]
    
    public let region: Region
    public let dateComponents: DateComponents
}

public struct Nanosecond: CalendarValue, NanosecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
}
