//
//  DateComponentsField.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol DateComponentsField: RegionField {
    static var representedComponents: Set<Calendar.Component> { get }
    
    var dateComponents: Foundation.DateComponents { get }
    
}

public extension DateComponentsField {
    
    public static var smalledRepresentedComponent: Calendar.Component {
        let order: Array<Calendar.Component> = [.nanosecond, .second, .minute, .hour, .day, .month, .year, .era]
        let represented = self.representedComponents
        for c in order {
            if represented.contains(c) { return c }
        }
        fatalError("\(Self.self) defines impossible represented units: \(represented)")
    }
    
}

internal protocol DateComponentsInitializable: DateComponentsField {
    init(dateComponents: DateComponents, region: Region)
}

extension DateComponentsInitializable {
    
    init(instant: Instant, region: Region) {
        let components = Self.representedComponents
        let date = Date(timeIntervalSinceReferenceDate: instant.intervalSinceReferenceEpoch.value)
        let dateComponents = region.calendar.dateComponents(components, from: date)
        self.init(dateComponents: dateComponents, region: region)
    }
    
}
