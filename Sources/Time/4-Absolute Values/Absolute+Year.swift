//
//  Absolute+Year.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Absolute where Smallest == Year {
    
    public var firstMonth: Absolute<Month> { return first() }
    public var lastMonth: Absolute<Month> { return last() }
    public func nthMonth(_ ordinal: Int) throws -> Absolute<Month> { return try nth(ordinal) }
    public func month(_ number: Int) -> Absolute<Month>? { return numbered(number) }
    
    public var months: AbsoluteSequence<Month> {
        return AbsoluteSequence(parent: self)
    }
    
    public var firstDay: Absolute<Day> { return first() }
    public var lastDay: Absolute<Day> { return last() }
    public var days: AbsoluteSequence<Day> {
        return AbsoluteSequence(parent: self)
    }
    
}
