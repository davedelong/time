//
//  RelativeValue-Others.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct MonthDayHourMinuteSecond: Relative, MonthDayHourMinuteSecondFields {
    public static var representedComponents: Set<Calendar.Component> = [.month, .day, .hour, .minute, .second]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct DayHourMinuteSecondNanosecond: Relative, DayHourMinuteSecondNanosecondFields {
    public static var representedComponents: Set<Calendar.Component> = [.day, .hour, .minute, .second, .nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

public struct MonthDayHourMinuteSecondNanosecond: Relative, MonthDayHourMinuteSecondNanosecondFields {
    public static var representedComponents: Set<Calendar.Component> = [.month, .day, .hour, .minute, .second, .nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}
