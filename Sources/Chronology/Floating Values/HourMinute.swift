//
//  HourMinute.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct HourMinute: CalendarValue, HourField, MinuteField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.hour, .minute]
    
    public let region: Region
    public let dateComponents: DateComponents
}
