//
//  FloatingValue-3Units.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct MonthDayHour: CalendarValue, MonthField, DayField, HourField {
    public static var representedComponents: Set<Calendar.Component> = [.month, .day, .hour]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct DayHourMinute: CalendarValue, DayField, HourField, MinuteField {
    public static var representedComponents: Set<Calendar.Component> = [.day, .hour, .minute]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct HourMinuteSecond: CalendarValue, HourField, MinuteField, SecondField {
    public static var representedComponents: Set<Calendar.Component> = [.hour, .minute, .second]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct MinuteSecondNanosecond: CalendarValue, MinuteField, SecondField, NanosecondField {
    public static var representedComponents: Set<Calendar.Component> = [.minute, .second, .nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}
