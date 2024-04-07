import Foundation

extension Fixed {
    
    /// Apply a time difference to a fixed value
    ///
    /// This operator is equivalent to `lhs.applying(difference: rhs)`
    ///
    /// - Parameters:
    ///   - lhs: A fixed value
    ///   - rhs: A time difference
    /// - Returns: A new fixed value that has been adjusted forward or backwards in time
    public static func +(lhs: Self, rhs: TimeDifference<Granularity, Era>) -> Self {
        return lhs.applying(difference: rhs)
    }
    
    /// Apply a time difference to a fixed value
    ///
    /// This operator is equivalent to `lhs.applying(difference: rhs.negated)`
    ///
    /// - Parameters:
    ///   - lhs: A fixed value
    ///   - rhs: A time difference
    /// - Returns: A new fixed value that has been adjusted forward or backwards in time
    public static func -(lhs: Self, rhs: TimeDifference<Granularity, Era>) -> Self {
        return lhs.applying(difference: rhs.negated)
    }
    
    /// Adjust a fixed value by applying a temporal delta value.
    ///
    /// - Parameter difference: The `TimeDifference` that describes the difference between the fixed value
    /// and the produced value.
    /// - Returns: A new fixed value that has been adjusted forwards or backwards in time
    public func applying(difference: TimeDifference<Granularity, Era>) -> Self {
        let d = self.range.lowerBound.date
        let diff = difference.dateComponents
        let newDate = self.calendar.date(byAdding: diff, to: d).unwrap("Unable to add \(diff) to \(self)")
        return Self(region: self.region, date: newDate)
    }
    
    /// Adjust the fixed value forwards or backwards.
    ///
    /// The amount of adjustment depends on the value's granularity. For example, if you have a `Fixed<Day>`, then `.offset(by: 2)`
    /// moves the value 2 days forward in time. If you have a `Fixed<Month>`, then `.offset(by: 2)` moves the value 2 *months* forward
    /// in time.
    /// - Parameter count: The number of units by which to adjust this fixed value.
    /// - Returns: A new fixed value that has been adjusted forward or backwards in time.
    public func offset(by count: Int) -> Self {
        guard count != 0 else { return self }
        
        let difference = TimeDifference<Granularity, Era>(value: count, unit: Granularity.component)
        return applying(difference: difference)
    }
    
    /// Adjust the fixed value forward by one `Granularity` unit.
    ///
    /// This is equivalent to `.offset(by: 1)`
    public var next: Self { offset(by: 1) }
    
    /// Adjust the fixed value backward by one `Granularity` unit.
    ///
    /// This is equivalent to `.offset(by: -1)`
    public var previous: Self { offset(by: -1) }

}

extension Fixed where Granularity: StandardUnit & LTOEYear {
    
    /// Create a new `Fixed` value by moving forward one year.
    public var nextYear: Self { return adding(years: 1) }
    
    /// Create a new `Fixed` value by moving backward one year.
    public var previousYear: Self { return subtracting(years: 1) }
    
    /// Create a new `Fixed` value by moving forward some number of years.
    /// - Parameter years: The number of years by which to move forward.
    public func adding(years: Int) -> Self { return applying(difference: .years(years)) }
    
    /// Create a new `Fixed` value by moving backward some number of years.
    /// - Parameter years: The number of years by which to move backward.
    public func subtracting(years: Int) -> Self { return applying(difference: .years(-years)) }
    
}

extension Fixed where Granularity: StandardUnit & LTOEMonth {
    
    /// Create a new `Fixed` value by moving forward one month.
    public var nextMonth: Self { return adding(months: 1) }
    
    /// Create a new `Fixed` value by moving backward one month.
    public var previousMonth: Self { return subtracting(months: 1) }
    
    /// Create a new `Fixed` value by moving forward some number of months.
    /// - Parameter months: The number of months by which to move forward.
    public func adding(months: Int) -> Self { return applying(difference: .months(months)) }
    
    /// Create a new `Fixed` value by moving backward some number of months.
    /// - Parameter months: The number of months by which to move backward.
    public func subtracting(months: Int) -> Self { return applying(difference: .months(-months)) }
    
}

extension Fixed where Granularity: LTMonth {
    
    /// Create a new `Fixed` value by moving forward one week.
    public var nextWeek: Self { return adding(weeks: 1) }
    
    /// Create a new `Fixed` value by moving backward one week.
    public var previousWeek: Self { return subtracting(weeks: 1) }
    
    /// Create a new `Fixed` value by moving forward some number of weeks.
    /// - Parameter months: The number of weeks by which to move forward.
    public func adding(weeks: Int) -> Self { return applying(difference: .weeks(weeks)) }
    
    /// Create a new `Fixed` value by moving backward some number of weeks.
    /// - Parameter months: The number of weeks by which to move backward.
    public func subtracting(weeks: Int) -> Self { return applying(difference: .weeks(-weeks)) }
    
}

extension Fixed where Granularity: StandardUnit & LTOEDay {
    
    /// Adjust the date to the beginning of the calendar's week.
    public var startOfWeek: Self {
        return self.fixedWeek.first()
    }
    
    /// Create a new `Fixed` value by moving forward one day.
    public var nextDay: Self { return adding(days: 1) }
    
    /// Create a new `Fixed` value by moving backward one day.
    public var previousDay: Self { return subtracting(days: 1) }
    
    /// Create a new `Fixed` value by moving forward some number of days.
    /// - Parameter days: The number of days by which to move forward.
    public func adding(days: Int) -> Self { return applying(difference: .days(days)) }
    
    /// Create a new `Fixed` value by moving backward some number of days.
    /// - Parameter days: The number of days by which to move backward.
    public func subtracting(days: Int) -> Self { return applying(difference: .days(-days)) }
    
    /// Create a new `Fixed` value that corresponds to the specified day of the week
    /// - Parameter dayOfWeek: The numeric value for the day of the week. 
    /// For the Gregorian calendar, 1 = Sunday, 2 = Monday, ... 7 = Saturday
    /// - Returns: A fixed value whose `.dayOfWeek` is equal to the `dayOfWeek` parameter.
    public func next(dayOfWeek: Int) -> Self {
        let daysInWeek = calendar.maximumRange(of: .weekday) ?? 1 ..< 8
        var day = dayOfWeek
        while day < daysInWeek.lowerBound { day += daysInWeek.count }
        day %= daysInWeek.count
        
        let thisDay = self.dayOfWeek
        
        var offset = 0
        if day < thisDay {
            offset = (day + daysInWeek.count) - thisDay
        } else if day == thisDay {
            offset = daysInWeek.count
        } else {
            offset = day - thisDay
        }
        
        // try the "O(1)" jump first
        let proposed = self.adding(days: offset)
        if proposed.dayOfWeek == day { return proposed }
        
        // something went wrong. manually scan forward
        var current = self.nextDay
        while current.dayOfWeek != day {
            current = current.nextDay
        }
        return current
    }
    
    #if !os(Linux)
    /// Create a new `Fixed` value that corresponds to the specified weekday
    /// - Parameter weekday: The day of the week.
    /// - Returns: A fixed value whose `.weekday` is equal to the `weekday` parameter.
    /// - Warning: This property is not available on Linux
    public func next(weekday: Locale.Weekday) -> Self {
        return self.next(dayOfWeek: weekday.dayOfWeek)
    }
    #endif
    
}

extension Fixed where Granularity: LTOEHour {
    
    /// Create a new `Fixed` value by moving forward one hour.
    public var nextHour: Self { return adding(hours: 1) }
    
    /// Create a new `Fixed` value by moving backward one hour.
    public var previousHour: Self { return subtracting(hours: 1) }
    
    /// Create a new `Fixed` value by moving forward some number of hours.
    /// - Parameter hours: The number of hours by which to move forward.
    public func adding(hours: Int) -> Self { return applying(difference: .hours(hours)) }
    
    /// Create a new `Fixed` value by moving backward some number of hours.
    /// - Parameter hours: The number of hours by which to move backward.
    public func subtracting(hours: Int) -> Self { return applying(difference: .hours(-hours)) }
    
}

extension Fixed where Granularity: LTOEMinute {
    
    /// Create a new `Fixed` value by moving forward one minute.
    public var nextMinute: Self { return adding(minutes: 1) }
    
    /// Create a new `Fixed` value by moving backward one minute.
    public var previousMinute: Self { return subtracting(minutes: 1) }
    
    /// Create a new `Fixed` value by moving forward some number of minutes.
    /// - Parameter minutes: The number of minutes by which to move forward.
    public func adding(minutes: Int) -> Self { return applying(difference: .minutes(minutes)) }
    
    /// Create a new `Fixed` value by moving backward some number of minutes.
    /// - Parameter minutes: The number of minutes by which to move backward.
    public func subtracting(minutes: Int) -> Self { return applying(difference: .minutes(-minutes)) }
    
}

extension Fixed where Granularity: LTOESecond {
    
    /// Create a new `Fixed` value by moving forward one second.
    public var nextSecond: Self { return adding(seconds: 1) }
    
    /// Create a new `Fixed` value by moving backward one second.
    public var previousSecond: Self { return subtracting(seconds: 1) }
    
    /// Create a new `Fixed` value by moving forward some number of seconds.
    /// - Parameter seconds: The number of seconds by which to move forward.
    public func adding(seconds: Int) -> Self { return applying(difference: .seconds(seconds)) }
    
    /// Create a new `Fixed` value by moving backward some number of seconds.
    /// - Parameter seconds: The number of seconds by which to move backward.
    public func subtracting(seconds: Int) -> Self { return applying(difference: .seconds(-seconds)) }
    
}

extension Fixed where Granularity: LTOENanosecond {
    
    /// Create a new `Fixed` value by moving forward one nanosecond.
    public var nextNanosecond: Self { return adding(nanoseconds: 1) }
    
    /// Create a new `Fixed` value by moving backward one nanosecond.
    public var previousNanosecond: Self { return subtracting(nanoseconds: 1) }
    
    /// Create a new `Fixed` value by moving forward some number of nanoseconds.
    /// - Parameter nanoseconds: The number of nanoseconds by which to move forward.
    public func adding(nanoseconds: Int) -> Self { return applying(difference: .nanoseconds(nanoseconds)) }
    
    /// Create a new `Fixed` value by moving backward some number of nanoseconds.
    /// - Parameter nanoseconds: The number of nanoseconds by which to move backward.
    public func subtracting(nanoseconds: Int) -> Self { return applying(difference: .nanoseconds(-nanoseconds)) }
    
}
