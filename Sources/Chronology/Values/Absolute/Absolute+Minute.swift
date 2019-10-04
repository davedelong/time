//
//  Absolute+Minute.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Lower == Minute {
    
    func firstSecond() -> Absolute<Second> { return first() }
    
    func lastSecond() -> Absolute<Second> { return last() }
    
    func nthSecond(_ ordinal: Int) throws -> Absolute<Second> { return try nth(ordinal) }
    
    func seconds() -> AbsoluteValueSequence<Second> {
        return AbsoluteValueSequence(parent: self)
    }
}
