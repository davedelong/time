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

public extension HourField where Self: CalendarValue {
    var hour: Hour { return Hour(dateComponents: dateComponents, region: region) }
    var hourValue: Int { return dateComponents.hour.unwrap("Cannot create an HourField without an hour value") }
}

public extension HourField where Self: Anchored, Self: CalendarValue {
    var yearMonthDay: YearMonthDay { return YearMonthDay(dateComponents: self.dateComponents, region: region) }
}

public struct YearMonthDayHour: CalendarValue, EraField, YearField, MonthField, DayField, HourField, Anchored, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
