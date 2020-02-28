//
//  Adjustment.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

/// An Adjustment is a way to mutate a Value in a calendrically safe way.
/// Adjustments of this sort are typically "relative" adjustments, like adding or subtracting offsets,
/// or finding the next or previous occurence of a particular event.
internal struct Adjustment<IS: Unit, IL: Unit, OS: Unit, OL: Unit> {
    
    fileprivate let adjust: (Value<IS, IL>) -> Value<OS, OL>
    
    internal init(_ adjuster: @escaping (Value<IS, IL>) -> Value<OS, OL>) {
        self.adjust = adjuster
    }
    
}

/// An UnsafeAdjustment is a mutation to a Value that may result in a non-existant value.
/// For example, any attempt to *set* the value of a particular field is unsafe,
/// because there is no guarantee that the specified value calendrically exists.
/// A trivial demonstration would be attempting to set the day of February to 31; this should throw.
internal struct UnsafeAdjustment<IS: Unit, IL: Unit, OS: Unit, OL: Unit> {
    
    fileprivate let adjust: (Value<IS, IL>) throws -> Value<OS, OL>
    
    internal init(_ adjuster: @escaping (Value<IS, IL>) throws -> Value<OS, OL>) {
        self.adjust = adjuster
    }
    
}

internal extension Value {
    
    func applying<OS: Unit, OL: Unit>(_ adjustment: Adjustment<Smallest, Largest, OS, OL>) -> Value<OS, OL> {
        return adjustment.adjust(self)
    }
    
    func applying<OS: Unit, OL: Unit>(_ adjustment: UnsafeAdjustment<Smallest, Largest, OS, OL>) throws -> Value<OS, OL> {
        return try adjustment.adjust(self)
    }
    
}
