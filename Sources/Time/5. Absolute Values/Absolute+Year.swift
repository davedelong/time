//
//  Absolute+Year.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Smallest == Year, Largest == Era {
    
    var firstMonth: Absolute<Month> { return first() }
    var lastMonth: Absolute<Month> { return last() }
    func nthMonth(_ ordinal: Int) throws -> Absolute<Month> { return try nth(ordinal) }
    func month(_ number: Int) -> Absolute<Month>? { return numbered(number) }
    
    var months: AbsoluteTimePeriodSequence<Month> {
        return AbsoluteTimePeriodSequence(parent: self)
    }
    
    var days: AbsoluteTimePeriodSequence<Day> {
        return AbsoluteTimePeriodSequence(parent: self)
    }
    
}
