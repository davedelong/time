//
//  Fixed+Minute.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Fixed where Smallest == Minute {
    
    public var firstSecond: Fixed<Second> { return first() }
    public var lastSecond: Fixed<Second> { return last() }
    public func nthSecond(_ ordinal: Int) throws -> Fixed<Second> { return try nth(ordinal) }
    public func second(_ number: Int) -> Fixed<Second>? { return numbered(number) }
    
    public var seconds: AbsoluteSequence<Second> {
        return AbsoluteSequence(parent: self)
    }
}
