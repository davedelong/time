//
//  FloatingValue-1Unit.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Month: CalendarValue, MonthField {
    public static var representedComponents: Set<Calendar.Component> = [.month]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct Day: CalendarValue, DayField {
    public static var representedComponents: Set<Calendar.Component> = [.day]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct Hour: CalendarValue, HourField {
    public static var representedComponents: Set<Calendar.Component> = [.hour]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct Minute: CalendarValue, MinuteField {
    public static var representedComponents: Set<Calendar.Component> = [.minute]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct Second: CalendarValue, SecondField {
    public static var representedComponents: Set<Calendar.Component> = [.second]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct Nanosecond: CalendarValue, NanosecondField {
    public static var representedComponents: Set<Calendar.Component> = [.nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}
