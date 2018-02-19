//
//  Day.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Day: CalendarValue, DayField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.day]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}


