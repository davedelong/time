//
//  PartialFormatting-1Unit.swift
//  Time
//

import Foundation

extension Fixed {
    
    /// Format the time zone of a fixed value
    /// - Parameter timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted time zone information
    public func format(timeZone: Template<TimeZone>) -> String {
        return format([timeZone])
    }
    
}

extension Fixed where Granularity: LTOEYear {
    
    /// Format the year of a fixed value
    /// - Parameters:
    ///   - year: The template for formatting the year
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted year information
    public func format(year: Template<Year>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, timeZone])
    }
    
}

extension Fixed where Granularity: LTOEMonth {
    
    /// Format the month of a fixed value
    /// - Parameters:
    ///   - month: The template for formatting the month
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted month information
    public func format(month: Template<Standalone<Month>>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, timeZone])
    }
    
}

extension Fixed where Granularity: LTOEDay {
    
    /// Format the day of a fixed value
    /// - Parameters:
    ///   - day: The template for formatting the day
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted day information
    public func format(day: Template<Day>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([day, timeZone])
    }
    
    /// Format the weekday of a fixed value
    /// - Parameters:
    ///   - weekday: The template for formatting the day of the week
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted weekday information
    public func format(weekday: Template<Standalone<Weekday>>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([weekday, timeZone])
    }
    
}

extension Fixed where Granularity: LTOEHour {
    
    /// Format the hour of a fixed value
    /// - Parameters:
    ///   - hour: The template for formatting the hour
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted hour information
    public func format(hour: Template<Hour>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([hour, timeZone])
    }
    
}

extension Fixed where Granularity: LTOEMinute {
    
    /// Format the minute of a fixed value
    /// - Parameters:
    ///   - minute: The template for formatting the minute
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted minute information
    public func format(minute: Template<Minute>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([minute, timeZone])
    }
    
}

extension Fixed where Granularity: LTOESecond {
    
    /// Format the second of a fixed value
    /// - Parameters:
    ///   - second: The template for formatting the second
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted second information
    public func format(second: Template<Second>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([second, timeZone])
    }
    
}

extension Fixed where Granularity: LTOENanosecond {
    
    /// Format the nanosecond of a fixed value
    /// - Parameters:
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted nanosecond information
    public func format(nanosecond: Template<Nanosecond>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([nanosecond, timeZone])
    }
    
}
