//
//  Absolute+Month.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Smallest == Month, Largest == Era {
    
    var firstDay: Absolute<Day> { return first() }
    var lastDay: Absolute<Day> { return last() }
    func nthDay(_ ordinal: Int) throws -> Absolute<Day> { return try nth(ordinal) }
    func day(_ number: Int) -> Absolute<Day>? { return numbered(number) }
    
    var days: AbsoluteTimePeriodSequence<Day> {
        return AbsoluteTimePeriodSequence<Day>(parent: self)
    }
    
    var firstHour: Absolute<Hour> { return first() }
    var lastHour: Absolute<Hour> { return last() }
    var hours: AbsoluteTimePeriodSequence<Hour> {
        return AbsoluteTimePeriodSequence<Hour>(parent: self)
    }
    
}
