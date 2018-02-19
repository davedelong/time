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
    var secondValue: Int { return dateComponents.second.unwrap("Cannot create an SecondField without a second value") }
}

public struct YearMonthDayHourMinuteSecond: RegionField, EraField, YearField, MonthField, DayField, HourField, MinuteField, SecondField, DateComponentsField, Anchored {
    
    public let region: Region
    public let dateComponents: DateComponents
    public var range: ClosedRange<Instant> { return getRange(self, unit: .second) }
    
    internal init(dateComponents: DateComponents, region: Region) {
        require(dateComponents.second != nil, "Cannot create a YearMonthDayHourMinuteSecond without a second value")
        require(dateComponents.minute != nil, "Cannot create a YearMonthDayHourMinuteSecond without a minute value")
        require(dateComponents.hour != nil, "Cannot create a YearMonthDayHourMinuteSecond without an hour value")
        require(dateComponents.day != nil, "Cannot create a YearMonthDayHourMinuteSecond without a day value")
        require(dateComponents.month != nil, "Cannot create a YearMonthDayHourMinuteSecond without a month value")
        require(dateComponents.year != nil, "Cannot create a YearMonthDayHourMinuteSecond without a year value")
        require(dateComponents.era != nil, "Cannot create a YearMonthDayHourMinuteSecond without an era value")
        
        self.region = region
        self.dateComponents = dateComponents
    }
    
}
