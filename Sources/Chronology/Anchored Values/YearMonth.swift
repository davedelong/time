//
//  YearMonth.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol MonthField {
    var monthValue: Int { get }
}

public extension MonthField where Self: CalendarValue {
    var month: Month { return Month(dateComponents: dateComponents, region: region) }
    var monthValue: Int { return dateComponents.month.unwrap("Cannot create a MonthField without a month value") }
}

public extension MonthField where Self: Anchored, Self: CalendarValue {
    var year: Year { return Year(dateComponents: self.dateComponents, region: region) }
}

public struct YearMonth: CalendarValue, EraField, YearField, MonthField, Anchored, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
