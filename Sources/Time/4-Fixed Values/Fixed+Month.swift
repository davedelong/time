import Foundation

extension Fixed where Granularity: GTDay {
    
    /// Retrieve the first day of this fixed value
    public var firstDay: Fixed<Day> { return first() }
    
    /// Retrieve the last day of this fixed value
    public var lastDay: Fixed<Day> { return last() }
    
    /// Retrieve a specific 1-based day from this fixed value
    ///
    /// Example:
    /// ```
    /// let firstDay = try thisFixedYear.nthDay(1)
    /// let secondDay = try thisFixedYear.nthDay(2)
    /// ```
    ///
    /// - Parameter ordinal: The offset of the desired day, as measured from the start of this value's range
    /// - Returns: a fixed day
    /// - Throws: This method throws a ``TimeError`` if `ordinal` is outside the range of values allowed by the `.calendar`.
    ///
    /// - Note: The allowable values for `ordinal` depend on the fixed value's `.calendar` and granularity.
    /// For example, getting the `.nthDay(72)` of a `Fixed<Month>` will throw an error, because no supported calendar has a month
    /// with more than about 31 days. However, getting the `.nthDay(72)` of a `Fixed<Year>` is fine, because years typically have at least
    /// than 340 days in them.
    public func nthDay(_ ordinal: Int) throws -> Fixed<Day> { return try nth(ordinal) }
    
    /// Get a sequence of all the days in this fixed value.
    ///
    /// - If this is a `Fixed<Month>`, the sequence produces all the days in the month
    /// - If this is a `Fixed<Year>`, the sequence produces all the days in the year
    /// - etc.
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
