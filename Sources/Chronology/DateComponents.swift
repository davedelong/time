//
//  DateComponents.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

internal extension DateComponents {
    
    func requireAndRestrict(to components: Set<Calendar.Component>, file: StaticString = #file, line: UInt = #line, function: StaticString = #function) -> DateComponents {
        var final = DateComponents()
        for component in components {
            guard let value = self.value(for: component) else {
                fatalError("Unable to retrieve \(component) value in \(function)", file: file, line: line)
            }
            final.setValue(value, for: component)
        }
        return final
    }
    
}

internal protocol DateComponentsInitializable: CalendarValue {
    init(region: Region, dateComponents: DateComponents)
}

extension DateComponentsInitializable {
    
    init(dateComponents: DateComponents, region: Region) {
        self.init(region: region, dateComponents: dateComponents.requireAndRestrict(to: Self.representedComponents))
    }
    
    init(instant: Instant, region: Region) {
        let components = Self.representedComponents
        let dateComponents = region.calendar.dateComponents(components, from: instant.date)
        self.init(dateComponents: dateComponents, region: region)
    }
    
}
