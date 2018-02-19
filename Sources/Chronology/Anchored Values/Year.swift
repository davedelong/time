//
//  Year.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Year: CalendarValue, EraField, YearField, Anchored, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
