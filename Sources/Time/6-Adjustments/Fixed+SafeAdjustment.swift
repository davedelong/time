//
//  Fixed+SafeAdjustment.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

extension Fixed {
    
    public static func +(lhs: Self, rhs: TimeDifference<Smallest, Era>) -> Self {
        return lhs.applying(difference: rhs)
    }

    public static func -(lhs: Self, rhs: TimeDifference<Smallest, Era>) -> Self {
        return lhs.applying(difference: rhs.negated())
    }
    
    /// Adjust a fixed value by applying a temporal delta value.
    ///
    /// - Parameter difference: The `TimeDifference` that describes the difference between the receiver
    ///    and the produced value.
    public func applying(difference: TimeDifference<Smallest, Era>) -> Self {
        let d = self.range.lowerBound.date
        let diff = difference.dateComponents
        let newDate = self.calendar.date(byAdding: diff, to: d).unwrap("Unable to add \(diff) to \(self)")
        return Self(region: self.region, date: newDate)
    }
    
    public func offset(by count: Int) -> Self {
        guard count != 0 else { return self }
        
        let difference = TimeDifference<Smallest, Era>(value: count, unit: Smallest.component)
        return applying(difference: difference)
    }
    
    public var next: Self { offset(by: 1) }
    
    public var previous: Self { offset(by: -1) }

}

extension Fixed where Smallest: LTOEYear {
    
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

extension Fixed where Smallest: LTOEMonth {
    
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

extension Fixed where Smallest: LTOEDay {
    
    /// Adjust the date to the beginning of the calendar's week.
    public var startOfWeek: Self {
        var s = self
        let targetWeekday = region.calendar.firstWeekday
        
        // TODO: this is O(n). Could this be done in O(1) by pre-computing the number of days to move backwards?
        while s.dayOfWeek != targetWeekday {
            s = s.previousDay
        }
        return s
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
    
}

extension Fixed where Smallest: LTOEHour {
    
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

extension Fixed where Smallest: LTOEMinute {
    
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

extension Fixed where Smallest: LTOESecond {
    
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

extension Fixed where Smallest: LTOENanosecond {
    
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
