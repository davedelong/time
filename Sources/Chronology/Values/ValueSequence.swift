//
//  File.swift
//  
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

public struct ValueSequence<S: Unit, L: Unit>: Sequence {
    
    private let constructor: () -> ValueIterator<S, L>
    
    internal init<PS, PL>(parent: Value<PS, PL>) {
        constructor = { ValueIterator(parent: parent) }
    }
    
    public __consuming func makeIterator() -> ValueIterator<S, L> {
        return constructor()
    }
    
}

public struct ValueIterator<S: Unit, L: Unit>: IteratorProtocol {
    
    internal init<PS, PL>(parent: Value<PS, PL>) {
        
    }
    
    public mutating func next() -> Value<S, L>? {
        return nil
    }
    
}


/*

public struct AbsoluteValueIterator<U: Unit>: IteratorProtocol {
    private let region: Region
    private let range: ClosedRange<Instant>
    
    private var nextStartInstant: Instant
    
    public init<P: Unit>(parent: Absolute<P>) {
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
 */
