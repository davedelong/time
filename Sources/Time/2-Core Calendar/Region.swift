//
//  Region.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

/// A `Region` contains all of the information necessary to refer to a user's preferences for expressing calendrical values.
///
/// It contains:
/// - a `Calendar` value, which describes their preferred system for measuring time
/// - a `TimeZone` value, which describes their local application of the calendar
/// - a `Locale` value, which describes their preferences around formatting values
public struct Region: Hashable, Sendable {
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        guard lhs.locale.identifier == rhs.locale.identifier else { return false }
        guard lhs.timeZone.identifier == rhs.timeZone.identifier else { return false }
        guard lhs.calendar.identifier == rhs.calendar.identifier else { return false }
        
        return true
    }
    
    /// A snapshot of the user's current `Region`.
    public static let current = Region(calendar: .current, timeZone: .current, locale: .current)
    
    /// The POSIX region: the Gregorian calendar in the UTC time zone, using the `en_US_POSIX` locale.
    public static let posix = Region(calendar: Calendar(identifier: .gregorian), 
                                     timeZone: TimeZone(secondsFromGMT: 0)!,
                                     locale: Locale(identifier: "en_US_POSIX"))
    
    /// The "autoupdating" current region. This Region will automatically track changes to the user's selected time zone, calendar, and locale.
    public static let autoupdatingCurrent = Region(calendar: .autoupdatingCurrent, 
                                                   timeZone: .autoupdatingCurrent,
                                                   locale: .autoupdatingCurrent)
    
    /// The `Calendar` used in this `Region`.
    public let calendar: Calendar
    
    /// The `TimeZone` used in this `Region`.
    public let timeZone: TimeZone
    
    /// The `Locale` used in this `Region`.
    public let locale: Locale
    
    /// Construct a `Region` given a `Calendar`, `TimeZone`, and `Locale`.
    public init(calendar: Calendar, timeZone: TimeZone, locale: Locale) {
        if calendar.timeZone != timeZone || calendar.locale != locale {
            var actualCalendar = calendar
            actualCalendar.timeZone = timeZone
            actualCalendar.locale = locale
            
            self.calendar = actualCalendar
        } else {
            self.calendar = calendar
        }
        self.timeZone = timeZone
        self.locale = locale
    }

    /// Create a "deep" copy of the receiver.
    ///
    /// This method is useful if you're on a platform that doesn't provide thread safety for the underlying date
    /// primatives, most notably Linux at the time of writing (mid-2023). If you're using `Region` objects in a
    /// multithreaded environment and are seeing odd behaviour, you may need to work with copies.
    ///
    /// For more detail, see the discussion on `Fixed<Unit>._forcedCopy()`.
    public func _forcedCopy() -> Self {
        return self.snapshot()
    }
    
    /// Indicates whether time values in this region will be formatted using 12-hour ("1:00 PM") or 24-hour ("13:00") time.
    public var wants24HourTime: Bool {
        let formatString = DateFormatter.dateFormat(fromTemplate: "J", options: 0, locale: locale)
        return formatString?.contains("H") == true
    }
    
    public func setTimeZone(_ timeZone: TimeZone) -> Region {
        if timeZone == self.timeZone { return self }
        return Region(calendar: self.calendar, timeZone: timeZone, locale: self.locale)
    }
    
    public func setCalendar(_ calendar: Calendar) -> Region {
        if calendar == self.calendar { return self }
        return Region(calendar: calendar, timeZone: self.timeZone, locale: self.locale)
    }
    
    public func setLocale(_ locale: Locale) -> Region {
        if locale == self.locale { return self }
        return Region(calendar: self.calendar, timeZone: self.timeZone, locale: locale)
    }
    
    internal func snapshot() -> Region {
        return Region(calendar: calendar.snapshot(),
                      timeZone: timeZone.snapshot(),
                      locale: locale.snapshot())
    }
}
