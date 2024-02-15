//
//  Fixed+Minute.swift
//

import Foundation

extension Fixed where Granularity: GTOEMinute, Granularity: LTOEYear {
    
    /// Retrieve the first second of this fixed value
    public var firstSecond: Fixed<Second> { return first() }
    
    /// Retrieve the last second of this fixed value
    public var lastSecond: Fixed<Second> { return last() }
    
    /// Retrieve a specific 1-based second from this fixed value.
    ///
    /// Example:
    /// ```
    /// let firstSecond = try thisFixedDay.nthSecond(1)
    /// let secondSecond = try thisFixedDay.nthSecond(2)
    /// ```
    ///
    /// - Parameter ordinal: The offset of the desired second, as measured from the start of this value's range
    /// - Returns: a fixed second
    /// - Throws: This method throws a ``TimeError`` if `ordinal` is outside the range of values allowed by the `.calendar`.
    ///
    /// - Note: The allowable values for `ordinal` depends on the fixed value's `.calendar` and granularity.
    /// For example, getting the `.nthSecond(100)` of a `Fixed<Minute>` will throw an error, because no supported calendar has more than 60 seconds in a minute.
    /// However, getting the `.nthSecond(100)` of a `Fixed<Day>` is fine, because a day typically has about 86,400 seconds in it.
    ///
    /// - Warning: This method does not guarantee a correspondance between the `ordinal` and the returned value's `.second`. Offsetting
    /// and missing seconds (or extra seconds) may mean that the `.second` value may be less than, equal to, or greater than the `ordinal` parameter.
    public func nthSecond(_ ordinal: Int) throws -> Fixed<Second> { return try nth(ordinal) }
    
    /// Get a sequence of all the seconds in this fixed value.
    ///
    /// - If this is a `Fixed<Minute>`, the sequence produces all the seconds in the minute
    /// - If this is a `Fixed<Hour>`, the sequence produces all the seconds in the hour
    /// - If this is a `Fixed<Day>`, the sequence produces all the seconds in the day
    /// - etc.
    public var seconds: FixedSequence<Second> {
        return FixedSequence(parent: self)
    }
    
}

extension Fixed where Granularity == Minute {
    
    /// Retrieve a second in this minute with a specific number
    /// - Parameter number: The number of the second (`0`, `13`, etc)
    /// - Returns: A `Fixed<Second>` whose `.sour` is equal to the provided `number`, or `nil` if no such second can be found
    public func second(_ number: Int) -> Fixed<Second>? { return numbered(number) }
    
}
