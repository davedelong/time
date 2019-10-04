//
//  FieldAdjustment.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

/// This is a nominal wrapper to an adjust to a single field on a CalendarValue
/// This wrapper enables syntax like "today + .days(3)"
public struct FieldAdjustment<U: Unit> {
    public let value: Int
    
    internal init(value: Int) {
        self.value = value
    }
}

public extension FieldAdjustment where U == Year {
    static func years(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public extension FieldAdjustment where U == Month {
    static func months(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public extension FieldAdjustment where U == Day {
    static func days(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public extension FieldAdjustment where U == Hour {
    static func hours(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public extension FieldAdjustment where U == Minute {
    static func minutes(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public extension FieldAdjustment where U == Second {
    static func seconds(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public extension FieldAdjustment where U == Nanosecond {
    static func nanoseconds(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

 
public func +<C: CalendarValue, U: Unit>(lhs: C, rhs: FieldAdjustment<U>) -> C {
    let adjustment = Adjustment<C, C>.add(value: rhs.value, unit: U.component)
    return lhs.apply(adjustment)
}

public func -<C: CalendarValue, U: Unit>(lhs: C, rhs: FieldAdjustment<U>) -> C {
    return lhs + FieldAdjustment<U>(value: -rhs.value)
}
