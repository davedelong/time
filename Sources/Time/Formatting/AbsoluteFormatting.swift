//
//  AbsoluteFormatting.swift
//  Time
//
//  Created by Dave DeLong on 5/17/18.
//

import Foundation

public extension Absolute where Largest == Era {
    
    /// Format an Absolute value using hard-coded format string.
    ///
    /// The localized format options provided for Absolute values are not always sufficient.
    /// The most common scenario for needing a hard-coded format string is when communicating with servers,
    /// which tend to expect a timestamp in a very specific format (ex: ISO8601). This requirement
    /// is at odds with the locale-sensitive formatting provided by this package.
    ///
    /// This method allows you to provided an explicit format string while formatting.
    ///
    /// The format string is checked to make sure the specified calendar components are
    /// all represented by this value. If they are not *and* the `strict` parameter is `true` (the default),
    /// then a `TimeError` is thrown indicating that there are missing components while parsing.
    ///
    /// If the format string specifies unrepresented calendar components and `strict` is `false`, then
    /// the `firstInstant` of the value is used.
    ///
    /// An error is thrown if-and-only-if the `strict` parameter is `true`. If you specify that `strict`
    /// is `false`, then you may safely "`try!`" this method.
    ///
    /// - Parameters:
    ///   - rawFormatString: The raw, unlocalized format string to be used for formatting.
    ///   - strict: Whether or not this method should throw a `TimeError` if the format string specifies
    ///     unrepresented calendar components.
    func format(using rawFormatString: String, strict: Bool = true) throws -> String {
        let desiredUnits = calendarComponents(in: rawFormatString)
        let missingUnits = desiredUnits.subtracting(representedComponents)
        if missingUnits.isEmpty == false {
            
            if strict == true {
                // the format string specified units that are not represented by this value
                let desc = "The provided format string '\(rawFormatString)' includes components (\(missingUnits)) that are not represented in a \(Self.self) value (\(Self.representedComponents))"
                throw TimeError.missingCalendarComponents(missingUnits, whileParsing: true, description: desc)
            } else {
                return formatRaw(rawFormatString, using: firstInstant.date)
            }
        } else {
            return formatRaw(rawFormatString)
        }
    }
}

public extension Absolute where Smallest: LTOEDay {
    func format(date dateStyle: DateFormatter.Style) -> String {
        return formatUsing(dateStyle: dateStyle, timeStyle: .none)
    }
}

public extension Absolute where Smallest: LTOESecond {
    func format(date dateStyle: DateFormatter.Style, time timeStyle: DateFormatter.Style) -> String {
        return formatUsing(dateStyle: dateStyle, timeStyle: timeStyle)
    }
    
    func format(time timeStyle: DateFormatter.Style) -> String {
        return formatUsing(dateStyle: .none, timeStyle: timeStyle)
    }
}

public extension Absolute where Smallest: LTOEEra {
    func format(era: Template<Era>) -> String {
        return format([era])
    }
}

public extension Absolute where Smallest: LTOEYear {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, timeZone])
    }
}

public extension Absolute where Smallest: LTOEMonth {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, timeZone])
    }
}

public extension Absolute where Smallest: LTOEDay {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, day, weekday, timeZone])
    }
}

public extension Absolute where Smallest: LTOEHour {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, day, weekday, hour, timeZone])
    }
}

public extension Absolute where Smallest: LTOEMinute {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, day, weekday, hour, minute, timeZone])
    }
}

public extension Absolute where Smallest: LTOESecond {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, day, weekday, hour, minute, second, timeZone])
    }
}

public extension Absolute where Smallest: LTOENanosecond {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, day, weekday, hour, minute, second, nanosecond, timeZone])
    }
}
