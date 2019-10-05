//
//  File.swift
//  
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

public struct AbsoluteValueSequence<U: Unit>: Sequence {
    
    private let constructor: () -> AbsoluteValueIterator<U>
    
    internal init<PS>(parent: Value<PS, Era>, stride: DateComponents = DateComponents(value: 1, component: U.component)) {
        constructor = { AbsoluteValueIterator(parent: parent, stride: stride) }
    }
    
    public __consuming func makeIterator() -> AbsoluteValueIterator<U> {
        return constructor()
    }
    
}

public struct AbsoluteValueIterator<U: Unit>: IteratorProtocol {
    private let region: Region
    
    private let range: ClosedRange<Instant>
    private let start: Absolute<U>
    
    private var scale = 0
    private let stride: DateComponents
    
    public init(region: Region, range: ClosedRange<Instant>, stride: DateComponents) {
        print("Striding from \(range.lowerBound.date) ..< \(range.upperBound.date) by \(stride)")
        self.region = region
        self.range = range
        self.start = Absolute<U>(region: region, instant: range.lowerBound)
        self.stride = stride
    }
    
    public init<P: Unit>(parent: Absolute<P>, stride: DateComponents) {
        self.init(region: parent.region, range: parent.range, stride: stride)
    }
    
    public mutating func next() -> Absolute<U>? {
        let next = stride.scale(by: scale)
        scale += 1
        
        let delta = Delta<U, Era>(next)
        let n = start + delta
        guard range.contains(n.lastInstant) else { return nil }
        
        return n
    }
}
