//
//  MonthDay.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct MonthDay: CalendarValue, MonthField, DayField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.month, .day]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
