//
//  DateComponents.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

internal extension DateComponents {
    
    init(value: Int, component: Calendar.Component) {
        self.init()
        self.setValue(value, for: component)
    }
    
    func requireAndRestrict(to components: Set<Calendar.Component>) throws -> DateComponents {
        var final = DateComponents()
        var missing = Set<Calendar.Component>()
        for component in components {
            if let value = self.value(for: component) {
                final.setValue(value, for: component)
            } else {
                missing.insert(component)
            }
        }
        if missing.isEmpty == false {
            throw TimeError.missingCalendarComponents(missing)
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
    
    var representedComponents: Set<Calendar.Component> {
        let contained = Calendar.Component.ascendingOrder.filter { self.value(for: $0) != nil }
        return Set(contained)
    }
    
    func isLessThan(other: DateComponents) -> Bool {
        for unit in Calendar.Component.descendingOrder {
            let lValue = self.value(for: unit)
            let rValue = other.value(for: unit)
            
            switch (lValue, rValue) {
                case (.none, .none): continue
                case (.none, .some(_)): return true
                case (.some(_), .none): return false
                case (.some(let l), .some(let r)):
                    if l < r { return true }
                    if l > r { return false }
                    continue
            }
        }
        return false
    }
    
    func isGreaterThan(other: DateComponents) -> Bool {
        return isLessThan(other: other) == false && (self != other)
    }
    
    func setting(era: Int? = nil, year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil) -> DateComponents {
        let merge = DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
        return merging(merge)
    }
    
    func merging(_ other: DateComponents) -> DateComponents {
        var copy = self
        for unit in Calendar.Component.descendingOrder {
            if let value = other.value(for: unit) {
                copy.setValue(value, for: unit)
            }
        }
        return copy
    }
    
}
