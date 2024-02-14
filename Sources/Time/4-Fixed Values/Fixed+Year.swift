//
//  Fixed+Year.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Fixed where Granularity: GTOEYear {
    
    public var firstMonth: Fixed<Month> { return first() }
    public var lastMonth: Fixed<Month> { return last() }
    public func nthMonth(_ ordinal: Int) throws -> Fixed<Month> { return try nth(ordinal) }
    public func month(_ number: Int) -> Fixed<Month>? { return numbered(number) }
    
    public var months: FixedSequence<Month> {
        return FixedSequence(parent: self)
    }
    
}
