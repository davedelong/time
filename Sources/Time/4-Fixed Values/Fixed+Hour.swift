//
//  Fixed+Hour.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Fixed where Smallest == Hour {
    
    public var firstMinute: Fixed<Minute> { return first() }
    public var lastMinute: Fixed<Minute> { return last() }
    public func nthMinute(_ ordinal: Int) throws -> Fixed<Minute> { return try nth(ordinal) }
    public func minute(_ number: Int) -> Fixed<Minute>? { return numbered(number) }
    
    public var minutes: FixedSequence<Minute> {
        return FixedSequence(parent: self)
    }
    
    public var firstSecond: Fixed<Second> { return first() }
    public var lastSecond: Fixed<Second> { return last() }
    public var seconds: FixedSequence<Second> {
        return FixedSequence(parent: self)
    }
}
