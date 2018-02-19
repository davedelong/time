//
//  FloatingValue-2Units.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct MonthDay: CalendarValue, MonthField, DayField {
    public static var representedComponents: Set<Calendar.Component> = [.month, .day]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct DayHour: CalendarValue, DayField, HourField {
    public static var representedComponents: Set<Calendar.Component> = [.day, .hour]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct HourMinute: CalendarValue, HourField, MinuteField {
    public static var representedComponents: Set<Calendar.Component> = [.hour, .minute]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct MinuteSecond: CalendarValue, MinuteField, SecondField {
    public static var representedComponents: Set<Calendar.Component> = [.minute, .second]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct SecondNanosecond: CalendarValue, SecondField, NanosecondField {
    public static var representedComponents: Set<Calendar.Component> = [.second, .nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}
