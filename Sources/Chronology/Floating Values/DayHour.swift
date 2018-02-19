//
//  DayHour.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct DayHour: CalendarValue, DayField, HourField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.day, .hour]
    
    public let region: Region
    public let dateComponents: DateComponents
}
