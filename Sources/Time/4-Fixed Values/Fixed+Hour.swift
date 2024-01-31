//
//  Fixed+Hour.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Fixed where Smallest: GTOEHour {
    
    public var firstMinute: Fixed<Minute> { return first() }
    public var lastMinute: Fixed<Minute> { return last() }
    public func nthMinute(_ ordinal: Int) throws -> Fixed<Minute> { return try nth(ordinal) }
    public func minute(_ number: Int) -> Fixed<Minute>? { return numbered(number) }
    
    public var minutes: FixedSequence<Minute> {
        return FixedSequence(parent: self)
    }
}
