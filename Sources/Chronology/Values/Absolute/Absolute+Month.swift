//
//  Absolute+Month.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Lower == Month {
    
    func firstDay() -> Absolute<Day> { return first() }
    
    func lastDay() -> Absolute<Day> { return last() }
    
    func nthDay(_ ordinal: Int) throws -> Absolute<Day> { return try nth(ordinal) }
    
    func days() -> AbsoluteValueSequence<Day> {
        return AbsoluteValueSequence(parent: self)
    }
    
    func hours() -> AbsoluteValueSequence<Hour> {
        return AbsoluteValueSequence(parent: self)
    }
    
}
