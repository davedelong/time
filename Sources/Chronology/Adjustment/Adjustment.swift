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
    
    fileprivate let adjust: (I) -> O
    
    public init(_ adjuster: @escaping (I) -> O) {
        self.adjust = adjuster
    }
    
}

/// An UnsafeAdjustment is a mutation to a CalendarValue that may result in a non-existant value.
/// For example, any attempt to *set* the value of a particular field is unsafe,
/// because there is no guarantee that the specified value calendrically exists.
/// A trivial demonstration would be attempting to set the day of February to 31; this should throw.
public struct UnsafeAdjustment<I: CalendarValue, O: CalendarValue> {
    
    fileprivate let adjust: (I) throws -> O
    
    public init(_ adjuster: @escaping (I) throws -> O) {
        self.adjust = adjuster
    }
    
}

public struct AdjustmentError: Error {
    internal init() { }
}

public extension CalendarValue {
    
    func apply<O>(_ adjustment: Adjustment<Self, O>) -> O {
        return adjustment.adjust(self)
    }
    
    func apply<O>(_ adjustment: UnsafeAdjustment<Self, O>) throws -> O {
        return try adjustment.adjust(self)
    }
    
}
