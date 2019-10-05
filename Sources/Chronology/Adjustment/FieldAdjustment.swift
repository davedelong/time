//
//  FieldAdjustment.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

/// This is a nominal wrapper to an adjust to a single field on a CalendarValue
/// This wrapper enables syntax like "today + .days(3)"
public struct FieldAdjustment<Smallest: Unit, Largest: Unit> {
    public let value: Int
    public let unit: Calendar.Component
    
    internal init(value: Int, unit: Calendar.Component) {
        self.value = value
        self.unit = unit
    }
}

public extension FieldAdjustment where Smallest: LTOEYear, Largest: GTOEYear {
    static func years(_ value: Int) -> FieldAdjustment { return self.init(value: value, unit: .year) }
}

public extension FieldAdjustment where Smallest: LTOEMonth, Largest: GTOEMonth {
    static func months(_ value: Int) -> FieldAdjustment { return self.init(value: value, unit: .month) }
}

public extension FieldAdjustment where Smallest: LTOEDay, Largest: GTOEDay {
    static func days(_ value: Int) -> FieldAdjustment { return self.init(value: value, unit: .day) }
}

public extension FieldAdjustment where Smallest: LTOEHour, Largest: GTOEHour {
    static func hours(_ value: Int) -> FieldAdjustment { return self.init(value: value, unit: .hour) }
}

public extension FieldAdjustment where Smallest: LTOEMinute, Largest: GTOEMinute {
    static func minutes(_ value: Int) -> FieldAdjustment { return self.init(value: value, unit: .minute) }
}

public extension FieldAdjustment where Smallest: LTOESecond, Largest: GTOESecond {
    static func seconds(_ value: Int) -> FieldAdjustment { return self.init(value: value, unit: .second) }
}

public extension FieldAdjustment where Smallest: LTOENanosecond, Largest: GTOENanosecond {
    static func nanoseconds(_ value: Int) -> FieldAdjustment { return self.init(value: value, unit: .nanosecond) }
}

// absolute adjustment
public func +<S, L>(lhs: Value<S, L>, rhs: FieldAdjustment<S, L>) -> Value<S, L> where L: GTOEEra {
    let adjustment = Adjustment<S, L, S, L>.add(value: rhs.value, unit: rhs.unit)
    return lhs.apply(adjustment)
}

public func -<S, L>(lhs: Value<S, L>, rhs: FieldAdjustment<S, L>) -> Value<S, L> where L: GTOEEra {
    return lhs + FieldAdjustment<S, L>(value: -rhs.value, unit: rhs.unit)
}

// relative adjustment
public func +<S, L>(lhs: Value<S, L>, rhs: FieldAdjustment<S, L>) -> Value<S, L> where L: LTOEYear {
    fatalError("Unimplemented")
}

public func -<S, L>(lhs: Value<S, L>, rhs: FieldAdjustment<S, L>) -> Value<S, L> where L: LTOEYear {
    return lhs + FieldAdjustment<S, L>(value: -rhs.value, unit: rhs.unit)
}
