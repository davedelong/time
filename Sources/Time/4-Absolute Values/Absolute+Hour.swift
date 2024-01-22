//
//  Absolute+Hour.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Absolute where Smallest == Hour {
    
    public var firstMinute: Absolute<Minute> { return first() }
    public var lastMinute: Absolute<Minute> { return last() }
    public func nthMinute(_ ordinal: Int) throws -> Absolute<Minute> { return try nth(ordinal) }
    public func minute(_ number: Int) -> Absolute<Minute>? { return numbered(number) }
    
    public var minutes: AbsoluteSequence<Minute> {
        return AbsoluteSequence(parent: self)
    }
    
    public var firstSecond: Absolute<Second> { return first() }
    public var lastSecond: Absolute<Second> { return last() }
    public var seconds: AbsoluteSequence<Second> {
        return AbsoluteSequence(parent: self)
    }
}
