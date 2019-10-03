//
//  ValueIterator.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 10/4/18.
//

import Foundation

/*
public struct ValueSequence<C: Absolute>: Sequence {
    
    private let iteratorConstructor: () -> ValueIterator<C>
    
    public init<P: Absolute>(parent: P) {
        iteratorConstructor = { ValueIterator(parent: parent) }
    }
    
    public func makeIterator() -> ValueIterator<C> {
        return iteratorConstructor()
    }
    
}

public struct ValueIterator<C: Absolute>: IteratorProtocol {
    private let region: Region
    private let range: ClosedRange<Instant>
    
    private var nextStartInstant: Instant
    
    public init<P: Absolute>(parent: P) {
        self.region = parent.region
        self.range = parent.range
        nextStartInstant = range.lowerBound
    }
    
    public mutating func next() -> C? {
        guard range.contains(nextStartInstant) else { return nil }
        let value = C.init(instant: nextStartInstant, region: region)
        nextStartInstant = value.range.upperBound + 0.5
        return value
    }
}
*/
