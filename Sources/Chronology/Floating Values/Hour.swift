//
//  Hour.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Hour: CalendarValue, HourField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.hour]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
