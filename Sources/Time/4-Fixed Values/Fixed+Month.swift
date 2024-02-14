//
//  Fixed+Month.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Fixed where Granularity: GTOEMonth {
    
    public var firstDay: Fixed<Day> { return first() }
    public var lastDay: Fixed<Day> { return last() }
    public func nthDay(_ ordinal: Int) throws -> Fixed<Day> { return try nth(ordinal) }
    
    public var days: FixedSequence<Day> {
        return FixedSequence<Day>(parent: self)
    }
    
}

extension Fixed where Granularity == Month {
    
    /// Retrieve a day in this month with a specific number
    /// - Parameter number: The number of the day (`1`, `13`, etc)
    /// - Returns: A `Fixed<Day>` whose `.day` is equal to the provided `number`, or `nil` if no such day can be found
    public func day(_ number: Int) -> Fixed<Day>? { return numbered(number) }
    
}
