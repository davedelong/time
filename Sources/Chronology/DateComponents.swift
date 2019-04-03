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
    
    func scale(by factor: Int) -> DateComponents {
        let s: (Int?) -> Int? = { $0.map { $0 * factor } }
        
        return DateComponents(calendar: calendar,
                              timeZone: timeZone,
                              era: s(era),
                              year: s(year),
                              month: s(month),
                              day: s(day),
                              hour: s(hour),
                              minute: s(minute),
                              second: s(second),
                              nanosecond: s(nanosecond),
                              weekday: s(weekday),
                              weekdayOrdinal: s(weekdayOrdinal),
                              quarter: s(quarter),
                              weekOfMonth: s(weekOfMonth),
                              weekOfYear: s(weekOfYear),
                              yearForWeekOfYear: s(yearForWeekOfYear))
    }
    
}
