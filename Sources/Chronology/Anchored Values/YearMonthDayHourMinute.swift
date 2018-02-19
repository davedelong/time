//
//  YearMonthDayHourMinute.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol MinuteField {
    var minuteValue: Int { get }
}

public extension MinuteField where Self: CalendarValue {
    var minute: Minute { return Minute(dateComponents: dateComponents, region: region) }
    var minuteValue: Int { return dateComponents.minute.unwrap("Cannot create an MinuteField without a minute value") }
}

public extension MinuteField where Self: Anchored, Self: CalendarValue {
    var yearMonthDayHour: YearMonthDayHour { return YearMonthDayHour(dateComponents: self.dateComponents, region: region) }
}

public struct YearMonthDayHourMinute: CalendarValue, EraField, YearField, MonthField, DayField, HourField, MinuteField, Anchored, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    internal init(dateComponents: DateComponents, region: Region) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
    
}
