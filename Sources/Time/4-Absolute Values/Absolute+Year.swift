//
//  Fixed+Year.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Fixed where Smallest == Year {
    
    public var firstMonth: Fixed<Month> { return first() }
    public var lastMonth: Fixed<Month> { return last() }
    public func nthMonth(_ ordinal: Int) throws -> Fixed<Month> { return try nth(ordinal) }
    public func month(_ number: Int) -> Fixed<Month>? { return numbered(number) }
    
    public var months: AbsoluteSequence<Month> {
        return AbsoluteSequence(parent: self)
    }
    
    public var firstDay: Fixed<Day> { return first() }
    public var lastDay: Fixed<Day> { return last() }
    public var days: AbsoluteSequence<Day> {
        return AbsoluteSequence(parent: self)
    }
    
}
