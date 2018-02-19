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

public extension DayField where Self: CalendarValue {
    var day: Day { return Day(dateComponents: dateComponents, region: region) }
    var dayValue: Int { return dateComponents.day.unwrap("Cannot create a DayField without a day value") }
}

public extension DayField where Self: Anchored, Self: CalendarValue {
    var yearMonth: YearMonth { return YearMonth(dateComponents: self.dateComponents, region: region) }
}

public struct YearMonthDay: CalendarValue, EraField, YearField, MonthField, DayField, Anchored, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month, .day]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
