//
//  YearMonthDay.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol DayField {
    var dayValue: Int { get }
}

public extension DayField where Self: DateComponentsField {
    var day: Day { return Day(dateComponents: dateComponents, region: region) }
    var dayValue: Int { return dateComponents.day.unwrap("Cannot create a DayField without a day value") }
}

public extension DayField where Self: Anchored, Self: DateComponentsField {
    var yearMonth: YearMonth { return YearMonth(dateComponents: self.dateComponents, region: region) }
}

public struct YearMonthDay: RegionField, EraField, YearField, MonthField, DayField, DateComponentsField, Anchored, DateComponentsInitializable {
    internal static var representedComponents: Set<Calendar.Component> = [.era, .year, .month, .day]
    
    public let region: Region
    public let dateComponents: DateComponents
    public var range: ClosedRange<Instant> { return getRange(self, unit: .day) }
    
    internal init(dateComponents: DateComponents, region: Region) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
    
}
