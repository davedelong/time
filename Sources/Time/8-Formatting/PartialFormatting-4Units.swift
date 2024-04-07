import Foundation

extension Fixed where Granularity: StandardUnit & LTOEHour {
    
    /// Format the year, month, day, and hour of a fixed value
    /// - Parameters:
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(year: Template<Year>,
                       month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       hour: Template<Hour>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, day, weekday, hour, timeZone])
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEMinute {
    
    /// Format the month, day, hour, and minute of a fixed value
    /// - Parameters:
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, day, weekday, hour, minute, timeZone])
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOESecond {
    
    /// Format the day, hour, minute, and second of a fixed value
    /// - Parameters:
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week   
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([day, weekday, hour, minute, second, timeZone])
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOENanosecond {
    
    /// Format the hour, minute, second, and nanosecond of a fixed value
    /// - Parameters:
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       nanosecond: Template<Nanosecond>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([hour, minute, second, nanosecond, timeZone])
    }
    
}
