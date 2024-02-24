#if os(Linux)
@preconcurrency import Foundation
#else
import Foundation
#endif

/// A `Region` contains all of the information necessary to refer to a user's preferences for expressing calendrical values.
///
/// It contains:
/// - a `Calendar` value, which describes their preferred system for measuring time
/// - a `TimeZone` value, which describes their local application of the calendar
/// - a `Locale` value, which describes their preferences around formatting values
public struct Region: Hashable, Sendable {
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        guard lhs.locale.isEquivalent(to: rhs.locale) else { return false }
        guard lhs.timeZone.isEquivalent(to: rhs.timeZone) else { return false }
        guard lhs.calendar.isEquivalent(to: rhs.calendar) else { return false }
        
        return true
    }
    
    /// A snapshot of the user's current `Region`.
    public static let current = Region(calendar: .current, timeZone: .current, locale: .current)
    
    /// The POSIX region: the Gregorian calendar in the UTC time zone, using the `en_US_POSIX` locale.
    public static let posix = Region(calendar: Calendar(identifier: .gregorian), 
                                     timeZone: TimeZone(secondsFromGMT: 0)!,
                                     locale: Locale(identifier: "en_US_POSIX"))
    
    /// The "autoupdating" current region. This Region will automatically track changes to the user's selected time zone, calendar, and locale.
    public static let autoupdatingCurrent = Region(autoupdating: ())
    
    /// The `Calendar` used in this `Region`.
    public let calendar: Calendar
    
    /// The `TimeZone` used in this `Region`.
    public let timeZone: TimeZone
    
    /// The `Locale` used in this `Region`.
    public let locale: Locale
    
    internal let isAutoupdating: Bool
    
    private init(autoupdating: Void = ()) {
        self.calendar = .autoupdatingCurrent
        self.timeZone = .autoupdatingCurrent
        self.locale = .autoupdatingCurrent
        self.isAutoupdating = true
    }
    
    /// Construct a `Region` given a `Calendar`, `TimeZone`, and `Locale`.
    ///
    /// The constructed region *always* uses a snapshot of the provided calendar, locale, and time zone. This means that
    /// if you attempt to pass in any of the `.autoupdatingCurrent` values, they will be "frozen" and the region will not
    /// automatically update to reflect any changes the user makes to their time zone, locale, or calendar
    /// while the process is running.
    ///
    /// The only way to get a `Region` with autoupdating values is to use ``Region/autoupdatingCurrent``.
    ///
    /// - Parameters:
    ///   - calendar: The region's `Calendar`
    ///   - timeZone: The region's `TimeZone`
    ///   - locale: The region's `Locale`
    public init(calendar: Calendar, timeZone: TimeZone, locale: Locale) {
        if calendar.timeZone != timeZone || calendar.locale != locale {
            var actualCalendar = calendar.snapshot()
            actualCalendar.timeZone = timeZone
            actualCalendar.locale = locale
            
            self.calendar = actualCalendar
        } else {
            self.calendar = calendar.snapshot()
        }
        self.timeZone = timeZone.snapshot()
        self.locale = locale.snapshot()
        self.isAutoupdating = false
    }

    /// Create a "deep" copy of the receiver.
    ///
    /// This method is useful if you're on a platform that doesn't provide thread safety for the underlying date
    /// primatives, most notably Linux at the time of writing (mid-2023). If you're using `Region` objects in a
    /// multithreaded environment and are seeing odd behaviour, you may need to work with copies.
    ///
    /// For more detail, see the discussion on `Fixed<Unit>._forcedCopy()`.
    public func _forcedCopy() -> Self {
        return self.snapshot(forced: true)
    }
    
    /// Indicates whether time values in this region will be formatted using 12-hour ("1:00 PM") or 24-hour ("13:00") time.
    public var wants24HourTime: Bool { locale.wants24HourTime }
    
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
    
    internal func snapshot(forced: Bool) -> Region {
        if forced == false && self.isAutoupdating == false { return self }
        
        return Region(calendar: calendar.snapshot(),
                      timeZone: timeZone.snapshot(),
                      locale: locale.snapshot())
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(calendar.identifier)
        hasher.combine(timeZone.identifier)
        hasher.combine(locale.identifier)
    }
}
