//
//  Absolute+Month.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Absolute where Smallest == Month {
    
    public var firstDay: Absolute<Day> { return first() }
    public var lastDay: Absolute<Day> { return last() }
    public func nthDay(_ ordinal: Int) throws -> Absolute<Day> { return try nth(ordinal) }
    public func day(_ number: Int) -> Absolute<Day>? { return numbered(number) }
    
    public var days: AbsoluteSequence<Day> {
        return AbsoluteSequence<Day>(parent: self)
    }
    
    public var firstHour: Absolute<Hour> { return first() }
    public var lastHour: Absolute<Hour> { return last() }
    public var hours: AbsoluteSequence<Hour> {
        return AbsoluteSequence<Hour>(parent: self)
    }
    
}
