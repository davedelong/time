import Foundation

/// `TimeDifference` is a type used for expressing the difference between two fixed values and adjusting them forward or backwards in time.
///
/// This wrapper enables syntax like `today + .days(3)`.
///
/// - Parameter MinimumGranularity: The smallest representable ``Unit`` expressed in this time difference.
/// - Parameter MaximumGranularity: The largest represesntable ``Unit`` expressed in this time difference.
///
public struct TimeDifference<MinimumGranularity: Unit, MaximumGranularity: Unit> {
    internal let dateComponents: DateComponents
    
    internal init(_ dateComponents: DateComponents) {
        let allowed = Calendar.Component.from(lower: MinimumGranularity.self, to: MaximumGranularity.self)
        self.dateComponents = dateComponents.restrict(to: allowed)
    }
    
    internal init(value: Int, unit: Calendar.Component) {
        self.init(DateComponents(value: value, component: unit))
    }
    
    /// Negate the time difference
    /// - Returns: A new `TimeDifference` value where all the represented unit values have been negated.
    public var negated: TimeDifference {
        return TimeDifference(dateComponents.scale(by: -1))
    }
    
    internal func scale(by scale: Int) -> Self {
        if scale == 1 { return self }
        return Self(dateComponents.scale(by: scale))
    }
}

extension TimeDifference where MinimumGranularity: LTOEYear, MaximumGranularity == Era {
    
    /// Create a time difference representing a specific number of eras
    /// - Parameter value: the number of eras
    /// - Returns: A `TimeDifference` that describes an interval of `value` eras.
    /// - Warning: Most commonly-used calendars do not use eras and struggle to correctly perform calculations involving them.
    public static func eras(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .era) }

    /// Retrieve the number of eras in a calendrical difference.
    public var eras: Int {
        return dateComponents.era
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have an era value")
    }
}

extension TimeDifference where MinimumGranularity: LTOEYear, MaximumGranularity: GTOEYear {
    
    /// Create a time difference representing a specific number of years
    /// - Parameter value: the number of years
    /// - Returns: A `TimeDifference` that represents an interval of `value` years.
    /// - Note: Most calendars perform [intercalation](https://en.wikipedia.org/wiki/Intercalation_%28timekeeping%29), and so years may
    /// not have a consistent length. Therefore, a `TimeDifference` of `.years(1)` can represent *many* possible absolute intervals, depending on the
    /// fixed values to which the interval is applied.
    public static func years(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .year) }
    
    /// Retrieve the number of years in a calendrical difference.
    public var years: Int {
        return dateComponents.year
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have a year value")
    }
}

extension TimeDifference where MinimumGranularity: LTOEMonth, MaximumGranularity: GTOEMonth {
    
    /// Create a time difference representing a specific number of months
    /// - Parameter value: the number of months
    /// - Returns: A `TimeDifference` that represents an interval of `value` months.
    /// - Note: Most calendars describe months that do not have a consistent length. Therefore, a `TimeDifference` of `.months(1)`
    /// can represent *many* possible absolute intervals, depending on the fixed values to which the interval is applied.
    public static func months(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .month) }
    
    /// Retrieve the number of months in a calendrical difference.
    public var months: Int {
        return dateComponents.month
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have a month value")
    }
}

extension TimeDifference where MinimumGranularity: LTOEDay, MaximumGranularity: GTOEDay {
    
    /// Create a time difference representing a specific number of days
    /// - Parameter value: the number of days
    /// - Returns: A `TimeDifference` that represents an interval of `value` days.
    /// - Note: Most calendars describe days that do not have a consistent length, especially when consider Daylight Saving Time. Therefore,
    /// a `TimeDifference` of `.days(1)` can represent *many* possible absolute intervals, depending on the fixed values to which the interval is applied.
    public static func days(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .day) }
    
    /// Retrieve the number of days in a calendrical difference.
    public var days: Int {
        return dateComponents.day.unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have a day value")
    }
}

extension TimeDifference where MinimumGranularity: LTOEHour, MaximumGranularity: GTOEHour {
    
    /// Create a time difference representing a specific number of hours
    /// - Parameter value: the number of hours
    /// - Returns: A `TimeDifference` that represents an interval of `value` hours.
    public static func hours(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .hour) }
    
    /// Retrieve the number of hours in a calendrical difference.
    public var hours: Int {
        return dateComponents.hour
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have an hour value")
    }
}

extension TimeDifference where MinimumGranularity: LTOEMinute, MaximumGranularity: GTOEMinute {
    
    /// Create a time difference representing a specific number of minutes
    /// - Parameter value: the number of minutes
    /// - Returns: A `TimeDifference` that represents an interval of `value` minutes.
    public static func minutes(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .minute) }
    
    /// Retrieve the number of minutes in a calendrical difference.
    public var minutes: Int {
        return dateComponents.minute
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have a minute value")
    }
}

extension TimeDifference where MinimumGranularity: LTOESecond, MaximumGranularity: GTOESecond {
    
    /// Create a time difference representing a specific number of seconds
    /// - Parameter value: the number of seconds
    /// - Returns: A `TimeDifference` that represents an interval of `value` seconds.
    public static func seconds(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .second) }
    
    /// Retrieve the number of seconds in a calendrical difference.
    public var seconds: Int {
        return dateComponents.second
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have a second value")
    }
}

extension TimeDifference where MinimumGranularity: LTOENanosecond, MaximumGranularity: GTOENanosecond {
    
    /// Create a time difference representing a specific number of nanoseconds
    /// - Parameter value: the number of nanoseconds
    /// - Returns: A `TimeDifference` that represents an interval of `value` nanoseconds.
    public static func nanoseconds(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .nanosecond) }
    
    /// Retrieve the number of nanoseconds in a calendrical difference.
    public var nanoseconds: Int {
        return dateComponents.nanosecond
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have a nanosecond value")
    }
}
