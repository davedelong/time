//
//  File.swift
//

import Foundation

extension Fixed where Granularity == Era {
    
    /// Retrieve the first year of this era
    public var firstYear: Fixed<Year> { return first() }
    
    /// Retrieve the last year of this era
    ///
    /// - Warning: Many calendars do not support accurate computations around eras. Depending on the
    /// `.calendar`, this value will likely be wrong.
    public var lastYear: Fixed<Year> { return last() }
    
    /// Retrieve a specific 1-based year from this era.
    ///
    /// Example:
    /// ```
    /// let firstYear = try thisFixedEra.nthYear(1)
    /// let secondYear = try thisFixedEra.nthYear(2)
    /// ```
    ///
    /// - Parameter ordinal: The offset of the desired year, as measured from the start of this era
    /// - Returns: a fixed year
    /// - Throws: This method throws a `TimeError` if `ordinal` is outside the range of values allowed by the `.calendar`.
    public func nthYear(_ ordinal: Int) throws -> Fixed<Year> { return try nth(ordinal) }
    
    /// Retrieve a year in this era with a specific number
    /// - Parameter number: The number of the year (`1492`, `2024`, etc)
    /// - Returns: A `Fixed<Year>` whose `.year` is equal to the provided `number`, or `nil` if no such year can be found
    public func year(_ number: Int) -> Fixed<Year>? { return numbered(number) }
    
    
    /// Get a sequence of all the years in this era.
    ///
    /// - Warning: Many calendars do not support accurate computations around eras. Depending on the
    /// `.calendar`, this sequence may produce unexpected results.
    public var years: FixedSequence<Year> {
        return FixedSequence(parent: self)
    }
    
}
