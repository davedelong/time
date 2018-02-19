//
//  Era.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Era: CalendarValue, EraField, Anchored, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.era]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
