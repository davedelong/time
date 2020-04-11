//
//  Absolute+Day.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Absolute where Smallest == Day, Largest == Era {
    
    func firstHour() -> Absolute<Hour> { return first() }
    func lastHour() -> Absolute<Hour> { return last() }
    func nthHour(_ ordinal: Int) throws -> Absolute<Hour> { return try nth(ordinal) }
    func hour(_ number: Int) -> Absolute<Hour>? { return numbered(number) }
    
    func hours() -> AbsoluteTimePeriodSequence<Hour> {
        return AbsoluteTimePeriodSequence(parent: self)
    }
    
    func minutes() -> AbsoluteTimePeriodSequence<Minute> {
        return AbsoluteTimePeriodSequence(parent: self)
    }
    
    func contains<U: LTOEHour>(_ value: Absolute<U>) -> Bool {
        return containsValue(value)
    }
}

public extension Absolute where Smallest: LTOEDay, Largest == Era {
    
    /// Returns `true` if the receiver is known to occur during the weekend.
    ///
    /// The definition of a "weekend" is supplied by the `Region`'s `Calendar`.
    var isWeekend: Bool { return calendar.isDateInWeekend(approximateMidPoint.date) }
    
    /// Returns `true` if the receiver is known to *not* occur during the weekend.
    ///
    /// The definition of a "weekend" is supplied by the `Region`'s `Calendar`.
    var isWeekday: Bool { return !isWeekend }
    
    /// Returns the numerical representation of the receiver's day of the week.
    ///
    /// For the Gregorian calendar, 1 = Sunday, 2 = Monday, ... 7 = Saturday
    var dayOfWeek: Int { return calendar.component(.weekday, from: approximateMidPoint.date) }
    
    /// Returns the day of the month on which the receiver occurs.
    ///
    /// For example, given a value that represents "Halloween" (October 31st) on the Gregorian calendar,
    /// this property returns "31".
    var dayOfMonth: Int { return day }
    
    /// Returns the day of the year on which the receiver occurs.
    ///
    /// For example, given a value that represents the first of February on the Gregorian calendar,
    /// this property returns "32".
    var dayOfYear: Int { return calendar.ordinality(of: .day, in: .year, for: approximateMidPoint.date)! }
    
    /// Returns the ordinal of the receiver's weekday within its month.
    ///
    /// For example, if the receiver falls on the second "Friday" of a month on the Gregorian calendar,
    /// then `dayOfWeek` returns `6` ("Friday"), and this property returns `2` (the second Friday).
    var dayOfWeekOrdinal: Int { return calendar.component(.weekdayOrdinal, from: approximateMidPoint.date) }
}
