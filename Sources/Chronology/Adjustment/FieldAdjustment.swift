//
//  FieldAdjustment.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation


/// This is a nominal wrapper to an adjust to a single field on a CalendarValue
/// This wrapper enables syntax like "today + .days(3)"
public struct FieldAdjustment<F: CalendarValueField> {
    public let value: Int
}

public extension FieldAdjustment where F: YearField {
    public static func years(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public extension FieldAdjustment where F: MonthField {
    public static func months(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public extension FieldAdjustment where F: DayField {
    public static func days(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public extension FieldAdjustment where F: HourField {
    public static func hours(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public extension FieldAdjustment where F: MinuteField {
    public static func minutes(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public extension FieldAdjustment where F: SecondField {
    public static func seconds(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public extension FieldAdjustment where F: NanosecondField {
    public static func nanoseconds(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}


public func +<C: Anchored & YearField>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs.apply(.add(years: rhs.value))
}

public func -<C: Anchored & YearField>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs + FieldAdjustment(value: -rhs.value)
}

public func +<C: Anchored & YearField & MonthField>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs.apply(.add(months: rhs.value))
}

public func -<C: Anchored & YearField & MonthField>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs + FieldAdjustment(value: -rhs.value)
}

public func +<C: Anchored & DateFields>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs.apply(.add(days: rhs.value))
}

public func -<C: Anchored & DateFields>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs + FieldAdjustment(value: -rhs.value)
}

public func +<C: Anchored & DateFields & HourField>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs.apply(.add(hours: rhs.value))
}

public func -<C: Anchored & DateFields & HourField>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs + FieldAdjustment(value: -rhs.value)
}

public func +<C: Anchored & DateFields & HourField & MinuteField>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs.apply(.add(minutes: rhs.value))
}

public func -<C: Anchored & DateFields & HourField & MinuteField>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs + FieldAdjustment(value: -rhs.value)
}

public func +<C: Anchored & DateFields & HourField & MinuteField & SecondField>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs.apply(.add(seconds: rhs.value))
}

public func -<C: Anchored & DateFields & HourField & MinuteField & SecondField>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs + FieldAdjustment(value: -rhs.value)
}

public func +<C: Anchored & DateFields & TimeFields>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs.apply(.add(nanoseconds: rhs.value))
}

public func -<C: Anchored & DateFields & TimeFields>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    return lhs + FieldAdjustment(value: -rhs.value)
}
