//
//  Fixed+Year.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Fixed where Granularity == Year {
    
    /// Retrieve the first month of this year
    public var firstMonth: Fixed<Month> { return first() }
    
    /// Retrieve the last month of this year
    public var lastMonth: Fixed<Month> { return last() }
    
    /// Retrieve a specific 1-based month from this year
    ///
    /// Example:
    /// ```
    /// let firstMonth = try thisFixedYear.nthMonth(1)
    /// let secondMonth = try thisFixedYear.nthMonth>(2)
    /// ```
    ///
    /// - Parameter ordinal: The offset of the desired month, as measured from the start of this value's range
    /// - Returns: a fixed month
    /// - Throws: This method throws a ``TimeError`` if `ordinal` is outside the range of values allowed by the `.calendar`.
    public func nthMonth(_ ordinal: Int) throws -> Fixed<Month> { return try nth(ordinal) }
    
    /// Retrieve a month in this year with a specific number
    /// - Parameter month: The number of the month (`1`, `8`, etc)
    /// - Returns: A `Fixed<Month>` whose `.month` is equal to the provided `number`, or `nil` if no such month can be found
    public func month(_ number: Int) -> Fixed<Month>? { return numbered(number) }
    
    /// Get a sequence of all the months in this year
    public var months: FixedSequence<Month> {
        return FixedSequence(parent: self)
    }
    
}
