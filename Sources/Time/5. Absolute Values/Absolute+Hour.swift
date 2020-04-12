//
//  Absolute+Hour.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Smallest == Hour, Largest == Era {
    
    var firstMinute: Absolute<Minute> { return first() }
    var lastMinute: Absolute<Minute> { return last() }
    func nthMinute(_ ordinal: Int) throws -> Absolute<Minute> { return try nth(ordinal) }
    func minute(_ number: Int) -> Absolute<Minute>? { return numbered(number) }
    
    var minutes: AbsoluteTimePeriodSequence<Minute> {
        return AbsoluteTimePeriodSequence(parent: self)
    }
    
    var seconds: AbsoluteTimePeriodSequence<Second> {
        return AbsoluteTimePeriodSequence(parent: self)
    }
}
