//
//  Second.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Second: CalendarValue, SecondField, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.second]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
