//
//  Minute.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Minute: CalendarValue, MinuteField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.minute]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
