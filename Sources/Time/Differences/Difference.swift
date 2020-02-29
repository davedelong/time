//
//  Difference.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

/// This is a nominal wrapper to an adjust to a single field on a CalendarValue
/// This wrapper enables syntax like "today + .days(3)"
public struct Difference<Smallest: Unit, Largest: Unit> {
    internal let dateComponents: DateComponents
    
    internal init(_ dateComponents: DateComponents) {
        let allowed = componentsFrom(lower: Smallest.self, to: Largest.self)
        self.dateComponents = try! dateComponents.requireAndRestrict(to: allowed)
    }
    
    internal init(value: Int, unit: Calendar.Component) {
        self.init(DateComponents(value: value, component: unit))
    }
    
    internal func negated() -> Difference {
        return Difference(dateComponents.scale(by: -1))
    }
}

public extension Difference where Smallest: LTOEYear, Largest: GTOEYear {
    static func eras(_ value: Int) -> Difference { return self.init(value: value, unit: .era) }

    /// Retrieve the number of eras in a calendrical difference
    var eras: Int {
        return dateComponents.era
            .unwrap("A Difference<\(Smallest.self), \(Largest.self)> must have an era value")
    }
}

public extension Difference where Smallest: LTOEYear, Largest: GTOEYear {
    static func years(_ value: Int) -> Difference { return self.init(value: value, unit: .year) }
    
    /// Retrieve the number of years in a calendrical difference
    var years: Int {
        return dateComponents.year
            .unwrap("A Difference<\(Smallest.self), \(Largest.self)> must have a year value")
    }
}

public extension Difference where Smallest: LTOEMonth, Largest: GTOEMonth {
    static func months(_ value: Int) -> Difference { return self.init(value: value, unit: .month) }
    
    /// Retrieve the number of months in a calendrical difference
    var months: Int {
        return dateComponents.month
            .unwrap("A Difference<\(Smallest.self), \(Largest.self)> must have a month value")
    }
}

public extension Difference where Smallest: LTOEDay, Largest: GTOEDay {
    static func days(_ value: Int) -> Difference { return self.init(value: value, unit: .day) }
    
    /// Retrieve the number of days in a calendrical difference
    var days: Int
    {
        return dateComponents.day.unwrap("A Difference<\(Smallest.self), \(Largest.self)> must have a day value")
    }
}

public extension Difference where Smallest: LTOEHour, Largest: GTOEHour {
    static func hours(_ value: Int) -> Difference { return self.init(value: value, unit: .hour) }
    
    /// Retrieve the number of hours in a calendrical difference
    var hours: Int {
        return dateComponents.hour
            .unwrap("A Difference<\(Smallest.self), \(Largest.self)> must have an hour value")
    }
}

public extension Difference where Smallest: LTOEMinute, Largest: GTOEMinute {
    static func minutes(_ value: Int) -> Difference { return self.init(value: value, unit: .minute) }
    
    /// Retrieve the number of minutes in a calendrical difference
    var minutes: Int {
        return dateComponents.minute
            .unwrap("A Difference<\(Smallest.self), \(Largest.self)> must have a minute value")
    }
}

public extension Difference where Smallest: LTOESecond, Largest: GTOESecond {
    static func seconds(_ value: Int) -> Difference { return self.init(value: value, unit: .second) }
    
    /// Retrieve the number of seconds in a calendrical difference
    var seconds: Int {
        return dateComponents.second
            .unwrap("A Difference<\(Smallest.self), \(Largest.self)> must have a second value")
    }
}

public extension Difference where Smallest: LTOENanosecond, Largest: GTOENanosecond {
    static func nanoseconds(_ value: Int) -> Difference { return self.init(value: value, unit: .nanosecond) }
    
    /// Retrieve the number of nanoseconds in a calendrical difference
    var nanoseconds: Int {
        return dateComponents.nanosecond
            .unwrap("A Difference<\(Smallest.self), \(Largest.self)> must have a nanosecond value")
    }
}

// absolute adjustment
public func +<S, L>(lhs: Value<S, L>, rhs: Difference<S, L>) -> Value<S, L> where L: GTOEEra {
    return lhs.applying(difference: rhs)
}

public func -<S, L>(lhs: Value<S, L>, rhs: Difference<S, L>) -> Value<S, L> where L: GTOEEra {
    return lhs.applying(difference: rhs.negated())
}

// relative adjustment
internal func +<S, L>(lhs: Value<S, L>, rhs: Difference<S, L>) -> Value<S, L> where L: LTOEYear {
    fatalError("Unimplemented")
}

internal func -<S, L>(lhs: Value<S, L>, rhs: Difference<S, L>) -> Value<S, L> where L: LTOEYear {
    return lhs + rhs.negated()
}
