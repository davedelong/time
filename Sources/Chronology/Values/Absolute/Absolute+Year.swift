//
//  Absolute+Year.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Smallest == Year, Largest == Era {
    
    func firstMonth() -> Absolute<Month> { return first() }
    func lastMonth() -> Absolute<Month> { return last() }
    func nthMonth(_ ordinal: Int) throws -> Absolute<Month> { return try nth(ordinal) }
    func month(_ number: Int) -> Absolute<Month>? { return numbered(number) }
    
    func months() -> AbsoluteValueSequence<Month> {
        return AbsoluteValueSequence(parent: self)
    }
    
    func days() -> AbsoluteValueSequence<Day> {
        return AbsoluteValueSequence(parent: self)
    }
    
}
