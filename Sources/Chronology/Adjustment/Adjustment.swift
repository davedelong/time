//
//  Adjustment.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

/// An Adjustment is a way to mutate a CalendarValue in a calendrically safe way.
/// Adjustments of this sort are typically "relative" adjustments, like adding or subtracting offsets,
/// or finding the next or previous occurence of a particular event.
public struct Adjustment<I: CalendarValue, O: CalendarValue> {
    
    private let adjuster: (I) -> O
    
    public init(_ adjuster: @escaping (I) -> O) {
        self.adjuster = adjuster
    }
    
    public func adjust(_ input: I) -> O {
        return adjuster(input)
    }
    
}

/// An UnsafeAdjustment is a mutation to a CalendarValue that may result in a non-existant value.
/// For example, any attempt to *set* the value of a particular field is unsafe,
/// because there is no guarantee that the specified value calendrically exists.
/// A trivial demonstration would be attempting to set the day of February to 31; this should throw.
public struct UnsafeAdjustment<I: CalendarValue, O: CalendarValue> {
    
    private let adjuster: (I) throws -> O
    
    public init(_ adjuster: @escaping (I) throws -> O) {
        self.adjuster = adjuster
    }
    
    public func adjust(_ input: I) throws -> O {
        return try adjuster(input)
    }
    
}


/// This is a nominal wrapper to an adjust to a single field on a CalendarValue
/// This wrapper enables syntax like "today + .days(3)"
public struct FieldAdjustment<F: CalendarValueField> {
    public let value: Int
}
