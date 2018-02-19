//
//  YearMonth.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct YearMonth: CalendarValue, EraField, YearField, MonthField, Anchored, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
