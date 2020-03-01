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
public struct Region: Hashable {
    
    /// A snapshot of the user's current `Region`.
    public static let current = Region(calendar: .current, timeZone: .current, locale: .current)
    
    /// The POSIX region: the Gregorian calendar in the UTC time zone, using the `en_US_POSIX` locale.
    public static let posix = Region(calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(secondsFromGMT: 0)!, locale: Locale(identifier: "en_US_POSIX"))
    
    /// The "autoupdating" current region. This Region will automatically track changes to the user's selected timeZone, calendar, and locale.
    public static let autoupdatingCurrent = Region(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, locale: .autoupdatingCurrent)
    
    /// The `Calendar` used in this `Region`.
    public let calendar: Calendar
    
    /// The `TimeZone` used in this `Region`.
    public let timeZone: TimeZone
    
    /// The `Locale` used in this `Region`.
    public let locale: Locale
    
    /// Construct a `Region` given a `Calendar`, `TimeZone`, and `Locale`.
    public init(calendar: Calendar, timeZone: TimeZone, locale: Locale) {
        var actualCalendar = calendar
        actualCalendar.timeZone = timeZone
        actualCalendar.locale = locale
        
        self.calendar = actualCalendar
        self.timeZone = timeZone
        self.locale = locale
    }
    
}
