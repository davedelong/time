import Foundation

extension Fixed where Granularity: GTOEDay, Granularity: LTOEYear {
    
    /// Retrieve the first hour of this fixed value
    public var firstHour: Fixed<Hour> { return first() }
    
    /// Retrieve the last hour of this fixed value
    public var lastHour: Fixed<Hour> { return last() }
    
    /// Retrieve a specific 1-based hour from this fixed value.
    ///
    /// Example:
    /// ```
    /// let firstHour = try thisFixedDay.nthHour(1)
    /// let secondHour = try thisFixedDay.nthHour(2)
    /// ```
    ///
    /// - Parameter ordinal: The offset of the desired hour, as measured from the start of this value's range
    /// - Returns: a fixed hour
    /// - Throws: This method throws a ``TimeError`` if `ordinal` is outside the range of values allowed by the `.calendar`.
    ///
    /// - Note: The allowable values for `ordinal` depends on the fixed value's `.calendar` and granularity.
    /// For example, getting the `.nthHour(50)` of a `Fixed<Day>` will throw an error, because no supported calendar has 50 hours in a day.
    /// However, getting the `.nthHour(50)` of a `Fixed<Month>` is fine, because months typically have many more than 50 hours in it.
    ///
    /// - Warning: This method does not guarantee a correspondance between the `ordinal` and the returned value's `.hour`. Offsetting
    /// and missing hours (or extra hours) may mean that the `.hour` value may be less than, equal to, or greater than the `ordinal` parameter.
    public func nthHour(_ ordinal: Int) throws -> Fixed<Hour> { return try nth(ordinal) }
    
    /// Get a sequence of all the hours in this fixed value.
    ///
    /// - If this is a `Fixed<Day>`, the sequence will produce approximately 24 `Fixed<Hour>` values.
    /// - If this is a `Fixed<Month>`, the sequence will produce between about 100 and 750 `Fixed<Hour>` values,
    /// depending on the length of the month.
    /// - If this value is a `Fixed<Year>`, the sequence will produce all the hours in the year
    public var hours: FixedSequence<Hour> {
        return FixedSequence(parent: self)
    }
    
}

extension Fixed where Granularity == Day {
    
    /// Retrieve an hour on this day with a specific number
    /// - Parameter number: The number of the hour (`0`, `13`, etc)
    /// - Returns: A `Fixed<Hour>` whose `.hour` is equal to the provided `number`, or `nil` if no such hour can be found
    public func hour(_ number: Int) -> Fixed<Hour>? { return numbered(number) }
    
}

extension Fixed where Granularity: StandardUnit & LTOEDay {
    
    /// Returns `true` if this fixed value is known to occur during the weekend.
    ///
    /// The definition of a "weekend" is supplied by the `Region`'s `Calendar`.
    public var isWeekend: Bool { return calendar.isDateInWeekend(approximateMidPoint.date) }
    
    /// Returns `true` if this fixed value is known to *not* occur during the weekend.
    ///
    /// The definition of a "weekend" is supplied by the `Region`'s `Calendar`.
    public var isWeekday: Bool { return !isWeekend }
    
    #if !os(Linux)
    /// Return this fixed value's day of the week
    ///
    /// - Warning: This property is not available on Linux
    public var weekday: Locale.Weekday { return Locale.Weekday(dayOfWeek: self.dayOfWeek) }
    #endif
    
    /// Returns the numerical representation of the this value's day of the week.
    ///
    /// For the Gregorian calendar, 1 = Sunday, 2 = Monday, ... 7 = Saturday
    public var dayOfWeek: Int { return calendar.component(.weekday, from: approximateMidPoint.date) }
    
    /// Returns the day of the month on which this fixed value occurs.
    ///
    /// For example, given a value that represents "Halloween" (October 31st) on the Gregorian calendar,
    /// this property returns "31".
    public var dayOfMonth: Int { return day }
    
    /// Returns the day of the year on which this fixed value occurs.
    ///
    /// For example, given a value that represents the first of February on the Gregorian calendar,
    /// this property returns "32".
    public var dayOfYear: Int { return calendar.ordinality(of: .day, in: .year, for: approximateMidPoint.date)! }
    
    /// Returns the ordinal of this fixed value's weekday within its month.
    ///
    /// For example, if this fixed value falls on the second "Friday" of a month on the Gregorian calendar,
    /// then `dayOfWeek` returns `6` ("Friday"), and this property returns `2` (the "second" Friday).
    public var dayOfWeekOrdinal: Int { return calendar.component(.weekdayOrdinal, from: approximateMidPoint.date) }
    
    /// Returns the week of the month on which this fixed value occurs.
    ///
    /// - Note: Since most calendars do not use years that are evenly divisible by 7, there are days around month boundaries that are
    /// attributed to a different "week of the month" than the month in which the day occurs. For example, if January 31st is a Friday, then
    /// the following day (February 1st) wil likely belong to the same week of the month as the previous day (typically 4 or 5), even though they
    /// occur in distinct calendar months. The behavior of this property is determined by the `.calendar.firstWeekday` and `.calendar.minimumDaysInFirstWeek` properties.
    public var weekOfMonth: Int { return calendar.component(.weekOfMonth, from: approximateMidPoint.date) }
    
    /// Returns the week of the year on which this fixed value occurs.
    ///
    /// This property is most useful for identifying the occurrence of a week boundary between two `Fixed<Day>` values.
    ///
    /// - Note: Since most calendars do not use years that are evenly divisible by 7, there are days around year boundaries that are
    /// attributed to a different "week of the year" than the year in which the day occurs. For example, if December 31st is a Friday, then
    /// the following day (January 1st) wil likely belong to the same week of the year as the previous day (typically 52 or 53), even though they
    /// occur in distinct calendar years. The behavior of this property is determined by the `.calendar.firstWeekday` and `.calendar.minimumDaysInFirstWeek` properties.
    public var weekOfYear: Int { return calendar.component(.weekOfYear, from: approximateMidPoint.date) }
}
