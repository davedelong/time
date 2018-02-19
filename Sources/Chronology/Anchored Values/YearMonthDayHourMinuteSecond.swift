//
//  YearMonthDayHourMinuteSecond.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol SecondField {
    var secondValue: Int { get }
}

public extension SecondField where Self: DateComponentsField {
    var second: Second { return Second(dateComponents: dateComponents, region: region) }
    var secondValue: Int { return dateComponents.second.unwrap("Cannot create an SecondField without a second value") }
}

public extension SecondField where Self: Anchored, Self: DateComponentsField {
    var yearMonthDayHourMinute: YearMonthDayHourMinute { return YearMonthDayHourMinute(dateComponents: self.dateComponents, region: region) }
}

public struct YearMonthDayHourMinuteSecond: RegionField, EraField, YearField, MonthField, DayField, HourField, MinuteField, SecondField, DateComponentsField, Anchored, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    internal init(dateComponents: DateComponents, region: Region) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
    
}
