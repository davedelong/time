//
//  TimeDifference+Invalid.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

/// INVALID ADDITION OPERATORS

extension Fixed where Smallest == Year {
    
    @available(*, unavailable, message: "Adding months to a year is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Month, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding days to a year is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Day, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding hours to a year is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Hour, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding minutes to a year is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Minute, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding seconds to a year is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Second, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding nanoseconds to a year is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Nanosecond, L>) -> Never { invalid() }
    
    @available(*, unavailable, message: "Subtracting months from a year is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Month, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting days from a year is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Day, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting hours from a year is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Hour, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting minutes from a year is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Minute, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting seconds from a year is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Second, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting nanoseconds from a year is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Nanosecond, L>) -> Never { invalid() }
}

extension Fixed where Smallest == Month {
    
    @available(*, unavailable, message: "Adding days to a month is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Day, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding hours to a month is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Hour, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding minutes to a month is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Minute, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding seconds to a month is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Second, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding nanoseconds to a month is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Nanosecond, L>) -> Never { invalid() }
    
    @available(*, unavailable, message: "Subtracting days from a month is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Day, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting hours from a month is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Hour, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting minutes from a month is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Minute, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting seconds from a month is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Second, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting nanoseconds from a month is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Nanosecond, L>) -> Never { invalid() }
    
}

extension Fixed where Smallest == Day {
    
    @available(*, unavailable, message: "Adding hours to a day is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Hour, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding minutes to a day is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Minute, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding seconds to a day is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Second, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding nanoseconds to a day is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Nanosecond, L>) -> Never { invalid() }
    
    @available(*, unavailable, message: "Subtracting hours from a day is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Hour, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting minutes from a day is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Minute, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting seconds from a day is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Second, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting nanoseconds from a day is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Nanosecond, L>) -> Never { invalid() }
    
}

extension Fixed where Smallest == Hour {
    
    @available(*, unavailable, message: "Adding minutes to an hour is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Minute, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding seconds to an hour is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Second, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding nanoseconds to an hour is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Nanosecond, L>) -> Never { invalid() }
    
    @available(*, unavailable, message: "Subtracting minutes from an hour is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Minute, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting seconds from an hour is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Second, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting nanoseconds from an hour is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Nanosecond, L>) -> Never { invalid() }
    
}

extension Fixed where Smallest == Minute {
    
    @available(*, unavailable, message: "Adding seconds to a minute is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Second, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Adding nanoseconds to a minute is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Nanosecond, L>) -> Never { invalid() }
    
    @available(*, unavailable, message: "Subtracting seconds from a minute is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Second, L>) -> Never { invalid() }
    @available(*, unavailable, message: "Subtracting nanoseconds from a minute is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Nanosecond, L>) -> Never { invalid() }
    
}

extension Fixed where Smallest == Second {
    
    @available(*, unavailable, message: "Adding nanoseconds to a second is invalid")
    public static func +<L>(lhs: Self, rhs: TimeDifference<Nanosecond, L>) -> Never { invalid() }
    
    @available(*, unavailable, message: "Subtracting nanoseconds from a second is invalid")
    public static func -<L>(lhs: Self, rhs: TimeDifference<Nanosecond, L>) -> Never { invalid() }
    
}
