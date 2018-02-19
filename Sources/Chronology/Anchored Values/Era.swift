//
//  Era.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol EraField {
    var eraValue: Int { get }
}

public extension EraField where Self: CalendarValue {
    var eraValue: Int { return dateComponents.era.unwrap("Cannot create an EraField without an era value") }
}

public struct Era: CalendarValue, EraField, Anchored, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.era]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    internal init(dateComponents: DateComponents, region: Region) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
    
}
