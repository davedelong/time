//
//  FormatTemplates.swift
//  Time
//
//  Created by Dave DeLong on 5/17/18.
//

import Foundation

/// A type for defining template patterns used when formatting fixed values
public struct Template<Unit>: Equatable, Format {
    internal let template: String
    internal init(_ template: String) {
        self.template = template
    }
    
}

extension Template where Unit == Era {

    /// The abbreviated name of an era, such as "AD" or "BC"
    public static let abbreviated = Template("G")
    
    /// The narrow name of an era, such as "A" or "B"
    public static let narrow = Template("GGGGG")
    
    /// The full name of an era, such as "Anno Domini" or "Before Christ"
    public static let wide = Template("GGGG")
    
}

extension Template where Unit == Year {
    
    /// The natural length of a year, such as "5" or "2024" or "23941"
    public static let naturalDigits = Template("y")
    
    /// The last to digits of a year, such as "05", "24" or "41"
    public static let twoDigits = digits(paddedToLength: 2)
    
    /// A year padded or truncated to a fixed length
    ///
    /// For example, `.digits(paddedToLength: 3)` might result in year strings of "005", "024", or "941".
    /// - Parameter paddedToLength: The length of the resulting string. Extra leading digits are omitted, and the string is zero-padded to reach the specified length
    /// - Returns: A template for the string representation of a calendar year
    public static func digits(paddedToLength: Int) -> Template {
        guard paddedToLength > 0 else { fatalError("Cannot pad to a length less than 1") }
        let template = String(repeating: "y", count: paddedToLength)
        return Template(template)
    }
    
}

extension Template where Unit == Month {
    
    /// The natural length of a numeric month when used as part of a larger date context, such as "2" or "11"
    public static let naturalDigits = Template("M")
    
    /// The numeric month when used as part of a larger date context, zero-padded to two digits, such as "05" or "11
    public static let twoDigits = Template("MM")
    
    /// The natural name of the month when used as part of a larger date context, such as "February"
    public static let naturalName = Template("MMMM")
    
    /// The abbreviated name of the month when used as part of a larger date context, such as "Feb"
    public static let abbreviatedName = Template("MMM")
    
    /// The narrow name of the month when used as part of a larger date context, such as "F"
    public static let narrowName = Template("MMMMM")
    
}

/// A type used in conjunction with defining templates that are used by themselves.
public enum Standalone<Field> { }

extension Template where Unit == Standalone<Month> {
    
    /// The natural length of a numeric month when used by itself, such as "2" or "11"
    public static let naturalDigits = Template("L")
    
    /// The numeric month when used by itself, zero-padded to two digits, such as "05" or "11
    public static let twoDigits = Template("LL")
    
    /// The natural name of the month when used by itself, such as "February"
    public static let naturalName = Template("LLLL")
    
    /// The abbreviated name of the month when used by itself, such as "Feb"
    public static let abbreviatedName = Template("LLL")
    
    /// The narrow name of the month when used by itself, such as "F"
    public static let narrowName = Template("LLLLL")
    
}

extension Template where Unit == Day {
    
    /// The natural length of a numeric day, such as "3" or "24"
    public static let naturalDigits = Template("d")
    
    /// The numeric day, zero-padded to two digits, such as "03" or "24"
    public static let twoDigits = Template("dd")
    
}

/// A type used to construct a format template representing a named weekday
public enum Weekday { }

extension Template where Unit == Weekday {
    
    /// The natural length of the numeric weekday when used as part of a larger date context, such as "1" or "7"
    public static let naturalDigits = Template("e")
    
    /// The numeric weekday when used as part of a larger date context, zero-padded to two digits, such as "01" or "07"
    public static let twoDigits = Template("ee")
    
    /// The natural name of the weekday when used as part of a larger date context, such as "Sunday" or "Thursday"
    public static let naturalName = Template("EEEE")
    
    /// The abbreviated name of the weekday when used as part of a larger date context, such as "Sun" or "Thu"
    public static let abbreviatedName = Template("EEE")
    
    /// The short name of the weekday when used as part of a larger date context, such as "Su" or "Th"
    public static let shortName = Template("EEEEEE")
    
    /// The narrow name of the weekday when used as part of a larger date context, such as "S" or "T"
    public static let narrowName = Template("EEEEE")
    
}

extension Template where Unit == Standalone<Weekday> {
    
    /// The natural length of the numeric weekday when used by itself, such as "1" or "7"
    public static let naturalDigits = Template("c")
    
    /// The natural name of the weekday when used by itself, such as "Sunday" or "Thursday"
    public static let naturalName = Template("cccc")
    
    /// The abbreviated name of the weekday when used by itself, such as "Sun" or "Thu"
    public static let abbreviatedName = Template("ccc")
    
    /// The short name of the weekday when used by itself, such as "Su" or "Th"
    public static let shortName = Template("cccccc")
    
    /// The narrow name of the weekday when used by itself, such as "S" or "T"
    public static let narrowName = Template("ccccc")
    
}

/// A type used to construct a format template representing day periods (AM and PM)
public enum DayPeriod { }

extension Template where Unit == DayPeriod {
    
    /// The natural name of the day period, such as "AM" or "PM"
    public static let natural = Template("a")
    
    /// The wide name of the day period, such as "Ante Meridiem" or "Post Meridiem", depending on the region
    public static let wide = Template("aaaa")
    
    /// The narrow name of the day period, such as "a" or "p"
    public static let narrow = Template("aaaaa")
    
}

extension Template where Unit == Hour {
    
    /// The natural length of the numeric hour, with the natural day period name, depending on the region.
    ///
    /// For example "3 AM" or "14"
    public static let naturalDigits = Template.naturalDigits(dayPeriod: .natural)
    
    /// The numeric hour, zero-padded to two digits, with the natural day period name, depending on the region.
    ///
    /// For example, "03 AM" or "14"
    public static let twoDigits = Template.twoDigits(dayPeriod: .natural)
    
    /// The natural length of the numeric hour, optionally with the day period
    /// - Parameter dayPeriod: The `Template<DayPeriod>` to use when formatting; may be `nil` to omit it
    /// - Returns: A template for the string representation of an hour
    public static func naturalDigits(dayPeriod: Template<DayPeriod>?) -> Template {
        guard let p = dayPeriod else { return Template("J") }
        
        if p == .wide {
            return Template("jjj")
        } else if p == .narrow {
            return Template("jjjjj")
        } else {
            return Template("j")
        }
    }
    
    /// The numeric hour, zero-padded to two digits, optionally with the day period
    /// - Parameter dayPeriod: The `Template<DayPeriod>` to use when formatting; may be `nil` to omit it
    /// - Returns: A template for the string representation of an hour
    public static func twoDigits(dayPeriod: Template<DayPeriod>?) -> Template {
        guard let p = dayPeriod else { return Template("JJ") }
        
        if p == .wide {
            return Template("jjjj")
        } else if p == .narrow {
            return Template("jjjjjj")
        } else {
            return Template("jj")
        }
    }
    
    
}

extension Template where Unit == Minute {
    
    /// The natural length of the numeric minute, such as "6" or "42"
    public static let naturalDigits = Template("m")
    
    /// The numeric minute, zero-padded to two digits, such as "06" or "42"
    public static let twoDigits = Template("mm")
    
}

extension Template where Unit == Second {
    
    /// The natural length of the numeric second, such as "3" or "27"
    public static let naturalDigits = Template("s")
    
    /// The numeric second, zero-padded to two digits, such as "03" or "27"
    public static let twoDigits = Template("ss")
    
}

extension Template where Unit == Nanosecond {
    
    /// The numeric fractional seconds
    /// - Parameter length: The number of significant digits to include
    /// - Returns: A template for the string representation of a fractional second
    public static func digits(_ length: Int) -> Template {
        guard length > 0 else { fatalError("Cannot pad to a length less than 1") }
        let template = String(repeating: "S", count: length)
        return Template(template)
    }
    
}

extension Template where Unit == TimeZone {
    
    /// The short specific time zone name, such as "MST"
    public static let shortSpecific = Template("z")
    
    /// The long specific time zone name, such as "Mountain Standard Time"
    public static let longSpecific = Template("zzzz")
    
    /// The basic ISO8601 time zone offset, such as "-0700" (no colon)
    public static let ISO8601Basic = Template("Z")
    
    /// The extended ISO8601 time zone offset, such as "-07:00" (with colon)
    public static let ISO8601Extended = Template("ZZZZZ")
    
    /// The GMT-based time zone offset, such as "GMT-7"
    public static let shortLocalizedGMT = Template("O")
    
    /// The long GMT-based time zone offset, such as "GMT-07:00"
    public static let longLocalizedGMT = Template("ZZZZ")
    
    /// The short generic time zone name, such as "MT"
    public static let shortGeneric = Template("v")
    
    /// The long generic time zone name, such as "Mountain Time"
    public static let longGeneric = Template("vvvv")
    
    /// The short time zone identifier, such as "usden"
    public static let shortID = Template("V")
    
    /// The long time zone identifier, such as "America/Denver"
    public static let longID = Template("VV")
    
    /// The name of an "exemplar" city in the time zone, such as "Denver". If the time zone does not have an exemplar city, it produces "Unknown City"
    public static let exemplarCity = Template("VVV")
    
    /// The generic location name of the time zone, such as "Denver Time". If the time zone does not have an exemplar city, it uses the `.longLocalizedGMT` name.
    public static let genericLocation = Template("VVVV")
    
    /// The ISO8601 time zone hour offset, or potentially Z for UTC+0 time zones.
    ///
    /// May include minutes for time zones with fractional hour offsets from UTC+0.
    ///
    /// For example, "-08", "+0530", or "Z"
    ///
    /// - Parameter includingZ: Whether UTC+0 time zones format as "Z"
    /// - Returns: A template for the string representation of a time zone
    public static func ISO8601BasicWithHours(includingZ: Bool = false) -> Template {
        return Template(includingZ ? "X" : "x")
    }
    
    /// The ISO8601 time zone offset, with hours and minutes, or potentially Z for UTC+0 time zones
    ///
    /// For example, "-0800", "+05:30", or "Z"
    ///
    /// - Parameters:
    ///   - extended: Whether formatted time zone offsets should incldue a colon between the hour and minute fields
    ///   - includingZ: Whether UTC+0 time zones format as "Z"
    /// - Returns: A template for the string representation of a time zone
    public static func ISO8601WithHoursAndMinutes(extended: Bool = false, includingZ: Bool = false) -> Template {
        if extended {
            return Template(includingZ ? "XXX" : "xxx")
        } else {
            return Template(includingZ ? "XX" : "xx")
        }
    }
    
}
