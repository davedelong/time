//
//  SecondNanosecond.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct SecondNanosecond: CalendarValue, SecondField, NanosecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.second, .nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
}
