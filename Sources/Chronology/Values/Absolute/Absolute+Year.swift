//
//  Absolute+Year.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Lower == Year {
    
    init(region: Region, era: Int? = nil, year: Int) throws {
        let dc = DateComponents(era: era, year: year)
        let start = Clock(region: region).thisYear()
    }
    
    func firstMonth() -> Absolute<Month> { return first() }
    
    func lastMonth() -> Absolute<Month> { return last() }
    
    func nthMonth(_ ordinal: Int) throws -> Absolute<Month> { return try nth(ordinal) }
    
    func months() -> AbsoluteValueSequence<Month> {
        return AbsoluteValueSequence(parent: self)
    }
    
    func days() -> AbsoluteValueSequence<Day> {
        return AbsoluteValueSequence(parent: self)
    }
    
}
