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
