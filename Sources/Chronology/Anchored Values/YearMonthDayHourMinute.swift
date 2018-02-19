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

public extension MinuteField where Self: DateComponentsField {
    var minute: Minute { return Minute(dateComponents: dateComponents, region: region) }
    var minuteValue: Int { return dateComponents.minute.unwrap("Cannot create an MinuteField without a minute value") }
}

public extension MinuteField where Self: Anchored, Self: DateComponentsField {
    var yearMonthDayHour: YearMonthDayHour { return YearMonthDayHour(dateComponents: self.dateComponents, region: region) }
}

public struct YearMonthDayHourMinute: RegionField, EraField, YearField, MonthField, DayField, HourField, MinuteField, DateComponentsField, Anchored, DateComponentsInitializable {
    internal static var representedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute]
    
    public let region: Region
    public let dateComponents: DateComponents
    public var range: ClosedRange<Instant> { return getRange(self, unit: .minute) }
    
    internal init(dateComponents: DateComponents, region: Region) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
    
}
