//
//  YearMonthDayHourMinuteSecondNanosecond.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol NanosecondField {
    var nanosecondValue: Int { get }
}

public extension NanosecondField where Self: DateComponentsField {
    var nanosecondValue: Int { return dateComponents.nanosecond.unwrap("Cannot create an NanosecondField without a nanosecond value") }
}

public extension NanosecondField where Self: Anchored, Self: DateComponentsField {
    var yearMonthDayHourMinuteSecond: YearMonthDayHourMinuteSecond { return YearMonthDayHourMinuteSecond(dateComponents: self.dateComponents, region: region) }
}

public struct YearMonthDayHourMinuteSecondNanosecond: RegionField, EraField, YearField, MonthField, DayField, HourField, MinuteField, SecondField, NanosecondField, DateComponentsField, Anchored {
    
    public let region: Region
    public let dateComponents: DateComponents
    public var range: ClosedRange<Instant> { return getRange(self, unit: .nanosecond) }
    
    internal init(dateComponents: DateComponents, region: Region) {
        require(dateComponents.nanosecond != nil, "Cannot create a YearMonthDayHourMinuteSecondNanosecond without a nanosecond value")
        require(dateComponents.second != nil, "Cannot create a YearMonthDayHourMinuteSecondNanosecond without a second value")
        require(dateComponents.minute != nil, "Cannot create a YearMonthDayHourMinuteSecondNanosecond without a minute value")
        require(dateComponents.hour != nil, "Cannot create a YearMonthDayHourMinuteSecondNanosecond without an hour value")
        require(dateComponents.day != nil, "Cannot create a YearMonthDayHourMinuteSecondNanosecond without a day value")
        require(dateComponents.month != nil, "Cannot create a YearMonthDayHourMinuteSecondNanosecond without a month value")
        require(dateComponents.year != nil, "Cannot create a YearMonthDayHourMinuteSecondNanosecond without a year value")
        require(dateComponents.era != nil, "Cannot create a YearMonthDayHourMinuteSecondNanosecond without an era value")
        
        self.region = region
        self.dateComponents = dateComponents
    }
    
}
