//
//  Absolute+Minute.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Smallest == Minute, Largest == Era {
    
    func firstSecond() -> Absolute<Second> { return first() }
    func lastSecond() -> Absolute<Second> { return last() }
    func nthSecond(_ ordinal: Int) throws -> Absolute<Second> { return try nth(ordinal) }
    func second(_ number: Int) -> Absolute<Second>? { return numbered(number) }
    
    func seconds() -> AbsoluteValueSequence<Second> {
        return AbsoluteValueSequence(parent: self)
    }
    
    func contains<U: LTOESecond>(_ value: Absolute<U>) -> Bool {
        return containsValue(value)
    }
}
