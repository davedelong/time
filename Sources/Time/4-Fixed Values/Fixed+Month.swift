//
//  Fixed+Month.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Fixed where Smallest == Month {
    
    public var firstDay: Fixed<Day> { return first() }
    public var lastDay: Fixed<Day> { return last() }
    public func nthDay(_ ordinal: Int) throws -> Fixed<Day> { return try nth(ordinal) }
    public func day(_ number: Int) -> Fixed<Day>? { return numbered(number) }
    
    public var days: FixedSequence<Day> {
        return FixedSequence<Day>(parent: self)
    }
    
    public var firstHour: Fixed<Hour> { return first() }
    public var lastHour: Fixed<Hour> { return last() }
    public var hours: FixedSequence<Hour> {
        return FixedSequence<Hour>(parent: self)
    }
    
}