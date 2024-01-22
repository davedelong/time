//
//  Absolute+Minute.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Absolute where Smallest == Minute {
    
    public var firstSecond: Absolute<Second> { return first() }
    public var lastSecond: Absolute<Second> { return last() }
    public func nthSecond(_ ordinal: Int) throws -> Absolute<Second> { return try nth(ordinal) }
    public func second(_ number: Int) -> Absolute<Second>? { return numbered(number) }
    
    public var seconds: AbsoluteSequence<Second> {
        return AbsoluteSequence(parent: self)
    }
}
