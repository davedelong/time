//
//  DateComponents.swift
//  Time
//

import Foundation

internal extension DateComponents {
    
    init(value: Int, component: Calendar.Component) {
        self.init()
        self.setValue(value, for: component)
    }
    
    /// Restrict the receiver to only the provided set of calendar components
    ///
    /// This is used for constructing ``Fixed`` values, because fixed time periods must contain
    /// values for all relevant calendar components. The exception to this is that some calendars can omit the `.era` unit
    /// and still correctly interpret the set of component values. In those cases, `[.era]` is typically passed in as the set
    /// of "lenient" components for which this code will allow a missing component value.
    ///
    /// - Parameters:
    ///   - components: the set of ``Calendar.Component`` values that must all be present in the returned value
    ///   - lenient: a set of ``Calendar.Component`` values that may be omitted from the returned value
    /// - Returns: a ``DateComponents`` value that will only contain the required components. If a component is missing from the receiver,
    /// and that component is *not* present in the `lenient` set, then this will throw an error
    func requireAndRestrict(to components: Set<Calendar.Component>, lenient: Set<Calendar.Component>) throws -> DateComponents {
        
        var final = DateComponents()
        var missing = Set<Calendar.Component>()
        for component in components {
            if let value = self.value(for: component), value != NSNotFound {
                final.setValue(value, for: component)
            } else if lenient.contains(component) == false {
                missing.insert(component)
            }
        }
        
        if missing.isEmpty == false {
            throw TimeError.missingCalendarComponents(missing, in: self)
        }
        
        return final
    }
    
    /// Restrict the receiver to only the provided set of calendar components
    /// - Parameter components: The set of ``Calendar.Component`` values that *may* be present in the returned value
    /// - Returns: A ``DateComponents`` value that will contain zero or more calendar components
    func restrict(to components: Set<Calendar.Component>) -> DateComponents {
        var final = DateComponents()
        for component in components {
            if let value = self.value(for: component), value != NSNotFound {
                final.setValue(value, for: component)
            }
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
    
    func has(component: Calendar.Component) -> Bool {
        let val = self.value(for: component)
        return val != nil && val != NSNotFound
    }
    
    var representedComponents: Set<Calendar.Component> {
        let contained = Calendar.Component.ascendingOrder.filter { self.has(component: $0) }
        return Set(contained)
    }
    
    var smallestRepresentedComponent: Calendar.Component? {
        return Calendar.Component.ascendingOrder.first(where: { self.has(component: $0) })
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
            if let value = other.value(for: unit), value != NSNotFound {
                copy.setValue(value, for: unit)
            }
        }
        return copy
    }
    
}
