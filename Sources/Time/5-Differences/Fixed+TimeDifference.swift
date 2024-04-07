import Foundation

extension Fixed {
    
    /// Compute the difference between two Fixed values
    ///
    /// This operator is equivalent to `lhs.difference(to: rhs)`.
    ///
    /// - Parameters:
    ///   - lhs: A fixed value
    ///   - rhs: A fixed value
    /// - Returns: The calendrical difference between the two fixed values.
    public static func - (lhs: Self, rhs: Self) -> TimeDifference<Granularity, Era> {
        return lhs.difference(to: rhs)
    }
    
    /// Compute the difference from this value to another fixed value.
    ///
    /// The granularity of the difference is determined by the granularity of the fixed values. Computing the difference between
    /// two `Fixed<Day>` values will return a `TimeDifference` that describes the interval in terms of years, months, and days.
    /// The time difference between two `Fixed<Second>` values will be described in terms of years, months, days, hours, minutes, and seconds.
    ///
    /// For specific granularity comparisions, such as the difference in whole days between two `Fixed<Day>` values regardless of
    /// their respective months or years, see the various `differenceInWhole...` methods.
    ///
    /// - Warning: This method allows you to find the difference between two values that belong to different regions. This is typically
    /// undesireable and/or nonsensical.
    ///
    /// - Parameter other: A fixed value
    /// - Returns: A ``TimeDifference`` that describes the calendrical difference between the two fixed values.
    public func difference(to other: Self) -> TimeDifference<Granularity, Era> {
        return computeDifference(to: other)
    }
    
}

extension Fixed where Granularity: LTOEYear {
    
    /// Compute the difference in whole years from this value to another fixed value.
    ///
    /// In order for the returned `TimeDifference` to represent a non-zero value, there must be *at least* a full elapsed year
    /// between the two fixed values. For example, even though `30 December 2023` is *almost* a full year away from `29 December 2024`,
    /// it is still less than a whole year, and therefore the difference in whole years between those two values is zero.
    ///
    /// - Parameter other: A fixed value
    /// - Returns: A ``TimeDifference`` that describes the difference in whole years between the two fixed values.
    public func differenceInWholeYears(to other: Self) -> TimeDifference<Year, Year> {
        return computeWholeDifference(to: other)
    }
    
}

extension Fixed where Granularity: LTOEMonth {
    
    /// Compute the difference in whole months from this value to another fixed value.
    ///
    /// In order for the returned `TimeDifference` to represent a non-zero value, there must be *at least* a full elapsed month
    /// between the two fixed values. For example, even though `1 October` is *almost* a full month away from `31 October`,
    /// it is still less than a whole month, and therefore the difference in whole months between those two values is zero.
    ///
    /// - Parameter other: A fixed value
    /// - Returns: A ``TimeDifference`` that describes the difference in whole months between the two fixed values.
    public func differenceInWholeMonths(to other: Self) -> TimeDifference<Month, Month> {
        return computeWholeDifference(to: other)
    }
    
}

extension Fixed where Granularity: LTOEDay {
    
    /// Compute the difference in whole days from this value to another fixed value.
    ///
    /// In order for the returned `TimeDifference` to represent a non-zero value, there must be *at least* a full elapsed day
    /// between the two fixed values. For example, even though `1 February 9:00 AM` is *almost* a full day away from `2 February 8:00 AM`,
    /// it is still less than a whole day, and therefore the difference in whole days between those two values is zero.
    ///
    /// - Parameter other: A fixed value
    /// - Returns: A ``TimeDifference`` that describes the difference in whole days between the two fixed values.
    public func differenceInWholeDays(to other: Self) -> TimeDifference<Day, Day> {
        return computeWholeDifference(to: other)
    }
    
}

extension Fixed where Granularity: LTOEHour {
    
    /// Compute the difference in whole hours from this value to another fixed value.
    ///
    /// In order for the returned `TimeDifference` to represent a non-zero value, there must be *at least* a full elapsed hour
    /// between the two fixed values. For example, even though `1 February 9:13 AM` is *almost* a full hour away from `1 February 10:06 AM`,
    /// it is still less than a whole hour, and therefore the difference in whole hours between those two values is zero.
    ///
    /// - Parameter other: A fixed value
    /// - Returns: A ``TimeDifference`` that describes the difference in whole hours between the two fixed values.
    public func differenceInWholeHours(to other: Self) -> TimeDifference<Hour, Hour> {
        return computeWholeDifference(to: other)
    }
    
}

extension Fixed where Granularity: LTOEMinute {
    
    /// Compute the difference in whole minutes from this value to another fixed value.
    ///
    /// In order for the returned `TimeDifference` to represent a non-zero value, there must be *at least* a full elapsed minute
    /// between the two fixed values. For example, even though `1 February 9:13:40 AM` is *almost* a full minute away from `1 February 9:14:39 AM`,
    /// it is still less than a whole minute, and therefore the difference in whole minutes between those two values is zero.
    ///
    /// - Parameter other: A fixed value
    /// - Returns: A ``TimeDifference`` that describes the difference in whole minutes between the two fixed values.
    public func differenceInWholeMinutes(to other: Self) -> TimeDifference<Minute, Minute> {
        return computeWholeDifference(to: other)
    }
    
}

extension Fixed where Granularity: LTOESecond {
    
    /// Compute the difference in whole seconds from this value to another fixed value.
    ///
    /// In order for the returned `TimeDifference` to represent a non-zero value, there must be *at least* a full elapsed second
    /// between the two fixed values. For example, even though `1 February 9:13:40.123 AM` is *almost* a full minute away from `1 February 9:13:41.012 AM`,
    /// it is still less than a whole second, and therefore the difference in whole seconds between those two values is zero.
    ///
    /// - Parameter other: A fixed value
    /// - Returns: A ``TimeDifference`` that describes the difference in whole seconds between the two fixed values.
    public func differenceInWholeSeconds(to other: Self) -> TimeDifference<Second, Second> {
        return computeWholeDifference(to: other)
    }
    
}
