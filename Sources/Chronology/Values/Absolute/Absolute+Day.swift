//
//  Absolute+Day.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Smallest == Day, Largest == Era {
    
    func firstHour() -> Absolute<Hour> { return first() }
    func lastHour() -> Absolute<Hour> { return last() }
    func nthHour(_ ordinal: Int) throws -> Absolute<Hour> { return try nth(ordinal) }
    
    func hours() -> AbsoluteValueSequence<Hour> {
        return AbsoluteValueSequence(parent: self)
    }
    
    func minutes() -> AbsoluteValueSequence<Minute> {
        return AbsoluteValueSequence(parent: self)
    }
}
