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
    static func years(_ value: Int) -> Difference { return self.init(value: value, unit: .year) }
}

public extension Difference where Smallest: LTOEMonth, Largest: GTOEMonth {
    static func months(_ value: Int) -> Difference { return self.init(value: value, unit: .month) }
}

public extension Difference where Smallest: LTOEDay, Largest: GTOEDay {
    static func days(_ value: Int) -> Difference { return self.init(value: value, unit: .day) }
}

public extension Difference where Smallest: LTOEHour, Largest: GTOEHour {
    static func hours(_ value: Int) -> Difference { return self.init(value: value, unit: .hour) }
}

public extension Difference where Smallest: LTOEMinute, Largest: GTOEMinute {
    static func minutes(_ value: Int) -> Difference { return self.init(value: value, unit: .minute) }
}

public extension Difference where Smallest: LTOESecond, Largest: GTOESecond {
    static func seconds(_ value: Int) -> Difference { return self.init(value: value, unit: .second) }
}

public extension Difference where Smallest: LTOENanosecond, Largest: GTOENanosecond {
    static func nanoseconds(_ value: Int) -> Difference { return self.init(value: value, unit: .nanosecond) }
}

// absolute adjustment
public func +<S, L>(lhs: Value<S, L>, rhs: Difference<S, L>) -> Value<S, L> where L: GTOEEra {
    return lhs.applying(delta: rhs)
}

public func -<S, L>(lhs: Value<S, L>, rhs: Difference<S, L>) -> Value<S, L> where L: GTOEEra {
    return lhs.applying(delta: rhs.negated())
}

// relative adjustment
public func +<S, L>(lhs: Value<S, L>, rhs: Difference<S, L>) -> Value<S, L> where L: LTOEYear {
    fatalError("Unimplemented")
}

public func -<S, L>(lhs: Value<S, L>, rhs: Difference<S, L>) -> Value<S, L> where L: LTOEYear {
    return lhs + rhs.negated()
}
