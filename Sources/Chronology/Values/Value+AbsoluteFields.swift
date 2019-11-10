//
//  AbsoluteFields.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Value where Largest: GTOEEra {
    
    /// Retrieve the `Range` of `Instants` described by this absolute `Value`.
    ///
    /// All absolute values contain many possible `Instants`. This property allows you
    /// to retrieve that range to use in calculations, such as knowing things like:
    /// - do these two calendar values overlap?
    /// - is this calendar value contained within this other calendar value?
    /// - etc
    public var range: Range<Instant> {
        let date = calendar.date(from: dateComponents).unwrap("Absolute values must always be convertible to a concrete NSDate")
        
        var start = Date()
        var length: TimeInterval = 0
        let succeeded = calendar.dateInterval(of: Smallest.component, start: &start, interval: &length, for: date)
        require(succeeded, "We should always be able to get the range of a calendar component")
        
        let startInsant = Instant(date: start)
        let endInstant = Instant(date: start.addingTimeInterval(length))
        return startInsant..<endInstant
    }
    
    /// Retrieve the first `Instant` known to occur within this `Value`
    public var firstInstant: Instant { return range.lowerBound }
    
}

extension Value where Smallest: LTOEYear, Largest: GTOEEra {
    
    /// Retrieve the absolute era described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the era will be removed.
    public var absoluteEra: Absolute<Era> { subComponents() }
}

extension Value where Smallest: LTOEMonth, Largest: GTOEEra {
    
    /// Retrieve the absolute year described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the year will be removed.
    public var absoluteYear: Absolute<Year> { subComponents() }
}

extension Value where Smallest: LTOEDay, Largest: GTOEEra {
    
    /// Retrieve the absolute month described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the month will be removed.
    public var absoluteMonth: Absolute<Month> { subComponents() }
    
    /// Returns `true` if the receiver is known to occur during the weekend.
    ///
    /// The definition of a "weekend" is supplied by the `Region`'s `Calendar`.
    public var isWeekend: Bool { return calendar.isDateInWeekend(approximateMidPoint.date) }
    
    /// Returns `true` if the receiver is known to *not* occur during the weekend.
    ///
    /// The definition of a "weekend" is supplied by the `Region`'s `Calendar`.
    public var isWeekday: Bool { return !isWeekend }
    
    /// Returns the numerical representation of the receiver's day of the week.
    ///
    /// For the gregorian calendar, 1 = Sunday, 2 = Monday, ... 7 = Saturday
    public var dayOfWeek: Int { return calendar.component(.weekday, from: approximateMidPoint.date) }
    
    /// Returns the day of the month on which the receiver occurs.
    ///
    /// For example, given a value that represents "Halloween" (October 31st) on the gregorian calendar,
    /// this property returns "31"
    public var dayOfMonth: Int { return day }
    
    /// Returns the day of the year on which the receiver occurs
    ///
    /// For example, given a value that represents the first of February on the gregorian calendar,
    /// this property returns "32"
    public var dayOfYear: Int { return calendar.ordinality(of: .day, in: .year, for: approximateMidPoint.date)! }
    
    /// Returns the ordinal of the receiver's weekday within its month.
    ///
    /// For example, if the receiver falls on the second "Friday" of a month on the gregorian calendar,
    /// then `dayOfWeek` returns `6` ("Friday"), and this property returns `2` (the second friday).
    public var dayOfWeekOrdinal: Int { return calendar.component(.weekdayOrdinal, from: approximateMidPoint.date) }
}

extension Value where Smallest: LTOEHour, Largest: GTOEEra {
    
    /// Retrieve the absolute day described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the day will be removed.
    public var absoluteDay: Absolute<Day> { subComponents() }
}

extension Value where Smallest: LTOEMinute, Largest: GTOEEra {
    
    /// Retrieve the absolute hour described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the hour will be removed.
    public var absoluteHour: Absolute<Hour> { subComponents() }
}

extension Value where Smallest: LTOESecond, Largest: GTOEEra {
    
    /// Retrieve the absolute minute described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the minute will be removed.
    public var absoluteMinute: Absolute<Minute> { subComponents() }
}

extension Value where Smallest: LTOENanosecond, Largest: GTOEEra {
    
    /// Retrieve the absolute second described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the second will be removed.
    public var absoluteSecond: Absolute<Second> { subComponents() }
}
