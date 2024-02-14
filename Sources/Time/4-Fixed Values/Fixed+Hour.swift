//
//  Fixed+Hour.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Fixed where Granularity: GTOEHour, Granularity: LTOEYear {
    
    /// Retrieve the first minute of this fixed value
    public var firstMinute: Fixed<Minute> { return first() }
    
    /// Retrieve the last minute of this fixed value
    public var lastMinute: Fixed<Minute> { return last() }
    
    /// Retrieve a specific 1-based minute from this fixed value
    ///
    /// Example:
    /// ```
    /// let firstMinute = try thisFixedYear.nthMinute(1)
    /// let secondMinute = try thisFixedYear.nthMinute(2)
    /// ```
    ///
    /// - Parameter ordinal: The offset of the desired minute, as measured from the start of this value's range
    /// - Returns: a fixed minute
    /// - Throws: This method throws a ``TimeError`` if `ordinal` is outside the range of values allowed by the `.calendar`.
    ///
    /// - Note: The allowable values for `ordinal` depend on the fixed value's `.calendar` and granularity.
    /// For example, getting the `.nthMinute(72)` of a `Fixed<Hour>` will throw an error, because no supported calendar has more
    /// 60 minutes in an hour. However, getting the `.nthMinute(72)` of a `Fixed<Day>` is fine, because days typically have more
    /// than 1,440 minutes in them.
    public func nthMinute(_ ordinal: Int) throws -> Fixed<Minute> { return try nth(ordinal) }
    
    /// Get a sequence of all the minutes in this fixed value.
    ///
    /// - If this is a `Fixed<Hour>`, the sequence produces all the minutes in that hour
    /// - If this is a `Fixed<Day>`, the sequence produces all the minutes in that day
    /// - If this is a `Fixed<Month>`, the sequence produces all the minutes in that month
    /// - If this is a `Fixed<Year>`, the sequence produces all the minutes in that year
    public var minutes: FixedSequence<Minute> {
        return FixedSequence(parent: self)
    }
}

extension Fixed where Granularity == Hour {
    
    /// Retrieve a minute in this hour with a specific number
    /// - Parameter number: The number of the minute (`0`, `42`, etc)
    /// - Returns: A `Fixed<Minute>` whose `.minute` is equal to the provided `number`, or `nil` if no such minute can be found
    public func minute(_ number: Int) -> Fixed<Minute>? { return numbered(number) }
    
}
