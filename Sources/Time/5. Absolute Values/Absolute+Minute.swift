//
//  Absolute+Minute.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Smallest == Minute, Largest == Era {
    
    var firstSecond: Absolute<Second> { return first() }
    var lastSecond: Absolute<Second> { return last() }
    func nthSecond(_ ordinal: Int) throws -> Absolute<Second> { return try nth(ordinal) }
    func second(_ number: Int) -> Absolute<Second>? { return numbered(number) }
    
    var seconds: AbsoluteTimePeriodSequence<Second> {
        return AbsoluteTimePeriodSequence(parent: self)
    }
}
