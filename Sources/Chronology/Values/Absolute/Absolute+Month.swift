//
//  Absolute+Month.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Smallest == Month, Largest == Era {
    
    func firstDay() -> Absolute<Day> { return first() }
    func lastDay() -> Absolute<Day> { return last() }
    func nthDay(_ ordinal: Int) throws -> Absolute<Day> { return try nth(ordinal) }
    func day(_ number: Int) -> Absolute<Day>? { return numbered(number) }
    
    func days() -> AbsoluteValueSequence<Day> {
        return AbsoluteValueSequence<Day>(parent: self)
    }
    
    func hours() -> AbsoluteValueSequence<Hour> {
        return AbsoluteValueSequence<Hour>(parent: self)
    }
    
}
