//
//  DateComponentsField.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol DateComponentsField: RegionField {
    
    var dateComponents: Foundation.DateComponents { get }
    
}

internal protocol DateComponentsInitializable {
    static var representedComponents: Set<Calendar.Component> { get }
    
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
