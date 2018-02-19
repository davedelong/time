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
    var minuteValue: Int { return dateComponents.minute.unwrap("Cannot create an MinuteField without a minute value") }
}

public struct YearMonthDayHourMinute: RegionField, EraField, YearField, MonthField, DayField, HourField, MinuteField, DateComponentsField, Anchored {
    
    public let region: Region
    public let dateComponents: DateComponents
    public var range: ClosedRange<Instant> { return getRange(self, unit: .minute) }
    
    internal init(dateComponents: DateComponents, region: Region) {
        require(dateComponents.minute != nil, "Cannot create a YearMonthDayHourMinute without a minute value")
        require(dateComponents.hour != nil, "Cannot create a YearMonthDayHourMinute without an hour value")
        require(dateComponents.day != nil, "Cannot create a YearMonthDayHourMinute without a day value")
        require(dateComponents.month != nil, "Cannot create a YearMonthDayHourMinute without a month value")
        require(dateComponents.year != nil, "Cannot create a YearMonthDayHourMinute without a year value")
        require(dateComponents.era != nil, "Cannot create a YearMonthDayHourMinute without an era value")
        
        self.region = region
        self.dateComponents = dateComponents
    }
    
}
