import Foundation

extension FixedFormat where Granularity: StandardUnit & LTOEMonth {
    
    /// Create a format for the year and month of a fixed value
    /// - Parameters:
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - timeZone: The template for formatting the time zone
    public init(year: Template<Year>,
                month: Template<Month>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [year, month, timeZone])
    }
    
    public static func year(_ year: Template<Year>,
                            month: Template<Month>,
                            timeZone: Template<TimeZone>? = nil) -> Self {
        self.init(templates: [year, month, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEDay {
    
    /// Create a format for the month and day of a fixed value
    /// - Parameters:
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - timeZone: The template for formatting the time zone
    public init(month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [month, day, weekday, timeZone])
    }
    
    public static func month(_ month: Template<Month>,
                             day: Template<Day>,
                             weekday: Template<Weekday>? = nil,
                             timeZone: Template<TimeZone>? = nil) -> Self {
        self.init(templates: [month, day, weekday, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEHour {
    
    /// Create a format for the day and hour of a fixed value
    /// - Parameters:
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - timeZone: The template for formatting the time zone
    public init(day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [day, weekday, hour, timeZone])
    }
    
    public static func day(_ day: Template<Day>,
                           weekday: Template<Weekday>? = nil,
                           hour: Template<Hour>,
                           timeZone: Template<TimeZone>? = nil) -> Self {
        self.init(templates: [day, weekday, hour, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEMinute {
    
    /// Create a format for the hour and minute of a fixed value
    /// - Parameters:
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - timeZone: The template for formatting the time zone
    public init(hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [hour, minute, timeZone])
    }
    
    public static func hour(_ hour: Template<Hour>,
                            minute: Template<Minute>,
                            timeZone: Template<TimeZone>? = nil) -> Self {
        self.init(templates: [hour, minute, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOESecond {
    
    /// Create a format for the minute and second of a fixed value
    /// - Parameters:
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - timeZone: The template for formatting the time zone
    public init(minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [minute, second, timeZone])
    }
    
    public static func minute(_ minute: Template<Minute>,
                              second: Template<Second>,
                              timeZone: Template<TimeZone>? = nil) -> Self {
        self.init(templates: [minute, second, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOENanosecond {
    
    /// Create a format for the second and nanosecond of a fixed value
    /// - Parameters:
    ///   - second: The template for formatting the second
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    public init(second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [second, nanosecond, timeZone])
    }
    
    public static func second(_ second: Template<Second>,
                              nanosecond: Template<Nanosecond>,
                              timeZone: Template<TimeZone>? = nil) -> Self {
        self.init(templates: [second, nanosecond, timeZone])
    }
}


extension Fixed where Granularity: StandardUnit & LTOEMonth {
    
    /// Format the year and month of a fixed value
    /// - Parameters:
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(year: Template<Year>,
                       month: Template<Month>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [year, month, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEDay {
    
    /// Format the month and day of a fixed value
    /// - Parameters:
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [month, day, weekday, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEHour {
    
    /// Format the day and hour of a fixed value
    /// - Parameters:
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       hour: Template<Hour>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [day, weekday, hour, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEMinute {
    
    /// Format the hour and minute of a fixed value
    /// - Parameters:
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(hour: Template<Hour>,
                       minute: Template<Minute>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [hour, minute, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOESecond {
    
    /// Format the minute and second of a fixed value
    /// - Parameters:
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(minute: Template<Minute>,
                       second: Template<Second>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [minute, second, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOENanosecond {
    
    /// Format the second and nanosecond of a fixed value
    /// - Parameters:
    ///   - second: The template for formatting the second
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(second: Template<Second>,
                       nanosecond: Template<Nanosecond>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [second, nanosecond, timeZone])
        return self.format(using: format)
    }
    
}
