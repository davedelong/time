//
//  Adjustment.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

/// An Adjustment is a way to mutate a TimePeriod in a calendrically safe way.
/// Adjustments of this sort are typically "relative" adjustments, like adding or subtracting offsets,
/// or finding the next or previous occurrence of a particular event.
internal struct Adjustment<IS: Unit, IL: Unit, OS: Unit, OL: Unit> {
    
    fileprivate let adjust: (TimePeriod<IS, IL>) -> TimePeriod<OS, OL>
    
    internal init(_ adjuster: @escaping (TimePeriod<IS, IL>) -> TimePeriod<OS, OL>) {
        self.adjust = adjuster
    }
    
}

/// A StrictAdjustment is a mutation to a Value that may result in a non-existent value.
/// For example, any attempt to *set* the value of a particular field is unsafe,
/// because there is no guarantee that the specified value calendrically exists.
/// A trivial demonstration would be attempting to set the day of February to 31; this should throw.
internal struct StrictAdjustment<IS: Unit, IL: Unit, OS: Unit, OL: Unit> {
    
    fileprivate let adjust: (TimePeriod<IS, IL>) throws -> TimePeriod<OS, OL>
    
    internal init(_ adjuster: @escaping (TimePeriod<IS, IL>) throws -> TimePeriod<OS, OL>) {
        self.adjust = adjuster
    }
    
}

internal extension TimePeriod {
    
    func applying<OS: Unit, OL: Unit>(_ adjustment: Adjustment<Smallest, Largest, OS, OL>) -> TimePeriod<OS, OL> {
        return adjustment.adjust(self)
    }
    
    func applying<OS: Unit, OL: Unit>(_ adjustment: StrictAdjustment<Smallest, Largest, OS, OL>) throws -> TimePeriod<OS, OL> {
        return try adjustment.adjust(self)
    }
    
}
