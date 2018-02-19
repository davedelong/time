//
//  YearMonthDayHour.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol HourField {
    var hourValue: Int { get }
}

public extension HourField where Self: DateComponentsField {
    var hourValue: Int { return dateComponents.hour.unwrap("Cannot create an HourField without an hour value") }
}

public struct YearMonthDayHour: RegionField, EraField, YearField, MonthField, DayField, HourField, DateComponentsField, Anchored {
    
    public let region: Region
    public let dateComponents: DateComponents
    public var range: ClosedRange<Instant> { return getRange(self, unit: .hour) }
    
    internal init(dateComponents: DateComponents, region: Region) {
        require(dateComponents.hour != nil, "Cannot create a YearMonthDayHour without an hour value")
        require(dateComponents.day != nil, "Cannot create a YearMonthDayHour without a day value")
        require(dateComponents.month != nil, "Cannot create a YearMonthDayHour without a month value")
        require(dateComponents.year != nil, "Cannot create a YearMonthDayHour without a year value")
        require(dateComponents.era != nil, "Cannot create a YearMonthDayHour without an era value")
        
        self.region = region
        self.dateComponents = dateComponents
    }
    
}
