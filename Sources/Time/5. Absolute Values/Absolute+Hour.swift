//
//  Absolute+Hour.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Smallest == Hour, Largest == Era {
    
    func firstMinute() -> Absolute<Minute> { return first() }
    func lastMinute() -> Absolute<Minute> { return last() }
    func nthMinute(_ ordinal: Int) throws -> Absolute<Minute> { return try nth(ordinal) }
    func minute(_ number: Int) -> Absolute<Minute>? { return numbered(number) }
    
    func minutes() -> AbsoluteTimePeriodSequence<Minute> {
        return AbsoluteTimePeriodSequence(parent: self)
    }
    
    func seconds() -> AbsoluteTimePeriodSequence<Second> {
        return AbsoluteTimePeriodSequence(parent: self)
    }
    
    func contains<U: LTOEMinute>(_ value: Absolute<U>) -> Bool {
        return containsValue(value)
    }
}
