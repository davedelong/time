//
//  MinuteSecond.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct MinuteSecond: CalendarValue, MinuteField, SecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.minute, .second]
    
    public let region: Region
    public let dateComponents: DateComponents
}
