//
//  ValueIterator.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 10/4/18.
//

import Foundation

public struct AbsoluteValueSequence<U: Unit>: Sequence {
    
    private let iteratorConstructor: () -> AbsoluteValueIterator<U>
    
    public init<V: CalendarValue>(parent: V) where V.Largest: GTOEEra {
        iteratorConstructor = { AbsoluteValueIterator<U>(parent: parent) }
    }
    
    public func makeIterator() -> AbsoluteValueIterator<U> {
        return iteratorConstructor()
    }
    
}

public struct AbsoluteValueIterator<U: Unit>: IteratorProtocol {
    private let region: Region
    private let range: ClosedRange<Instant>
    
    private var nextStartInstant: Instant
    
    public init<V: CalendarValue>(parent: V) where V.Largest: GTOEEra {
        self.region = parent.region
        self.range = parent.range
        nextStartInstant = range.lowerBound
    }
    
    public mutating func next() -> Absolute<U>? {
        guard range.contains(nextStartInstant) else { return nil }
        let value = Absolute<U>.init(region: region, instant: nextStartInstant)
        nextStartInstant = value.range.upperBound + 0.5
        return value
    }
}
