import Foundation

extension FixedFormat where Granularity: StandardUnit & LTOEMinute {
    
    /// Create a format for the year, month, day, hour, and minute of a fixed value
    /// - Parameters:
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - timeZone: The template for formatting the time zone
    public init(year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [year, month, day, weekday, hour, minute, timeZone])
    }
    
    public static func year(_ year: Template<Year>,
                            month: Template<Month>,
                            day: Template<Day>,
                            weekday: Template<Weekday>? = nil,
                            hour: Template<Hour>,
                            minute: Template<Minute>,
                            timeZone: Template<TimeZone>? = nil) -> Self {
        self.init(templates: [year, month, day, weekday, hour, minute, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOESecond {
    
    /// Create a format for the month, day, hour, minute, and second of a fixed value
    /// - Parameters:
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - timeZone: The template for formatting the time zone
    public init(month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [month, day, weekday, hour, minute, second, timeZone])
    }
    
    public static func month(_ month: Template<Month>,
                             day: Template<Day>,
                             weekday: Template<Weekday>? = nil,
                             hour: Template<Hour>,
                             minute: Template<Minute>,
                             second: Template<Second>,
                             timeZone: Template<TimeZone>? = nil) -> Self {
        self.init(templates: [month, day, weekday, hour, minute, second, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOENanosecond {
    
    /// Create a format for the day, hour, minute, second, and nanosecond of a fixed value
    /// - Parameters:
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    public init(day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [day, weekday, hour, minute, second, nanosecond, timeZone])
    }
    
    public static func day(_ day: Template<Day>,
                           weekday: Template<Weekday>? = nil,
                           hour: Template<Hour>,
                           minute: Template<Minute>,
                           second: Template<Second>,
                           nanosecond: Template<Nanosecond>,
                           timeZone: Template<TimeZone>? = nil) -> Self {
        self.init(templates: [day, weekday, hour, minute, second, nanosecond, timeZone])
    }
    
}


extension FixedFormat where Granularity: StandardUnit & LTOESecond {
    
    /// Create a format for the year, month, day, hour, minute, and second of a fixed value
    /// - Parameters:
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - timeZone: The template for formatting the time zone
    public init(year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [year, month, day, weekday, hour, minute, second, timeZone])
    }
    
    public static func year(_ year: Template<Year>,
                            month: Template<Month>,
                            day: Template<Day>,
                            weekday: Template<Weekday>? = nil,
                            hour: Template<Hour>,
                            minute: Template<Minute>,
                            second: Template<Second>,
                            timeZone: Template<TimeZone>? = nil) -> Self {
        self.init(templates: [year, month, day, weekday, hour, minute, second, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOENanosecond {
    
    /// Create a format for the month, day, hour, minute, second, and nanosecond of a fixed value
    /// - Parameters:
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    public init(month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [month, day, weekday, hour, minute, second, nanosecond, timeZone])
    }
    
    public static func month(_ month: Template<Month>,
                             day: Template<Day>,
                             weekday: Template<Weekday>? = nil,
                             hour: Template<Hour>,
                             minute: Template<Minute>,
                             second: Template<Second>,
                             nanosecond: Template<Nanosecond>,
                             timeZone: Template<TimeZone>? = nil) -> Self {
        self.init(templates: [month, day, weekday, hour, minute, second, nanosecond, timeZone])
    }
    
}


extension FixedFormat where Granularity: StandardUnit & LTOENanosecond {
    
    /// Create a format for the year, month, day, hour, minute, second, and nanosecond of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    public init(year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [year, month, day, weekday, hour, minute, second, nanosecond, timeZone])
    }
    
    public static func year(_ year: Template<Year>,
                            month: Template<Month>,
                            day: Template<Day>,
                            weekday: Template<Weekday>? = nil,
                            hour: Template<Hour>,
                            minute: Template<Minute>,
                            second: Template<Second>,
                            nanosecond: Template<Nanosecond>,
                            timeZone: Template<TimeZone>? = nil) -> Self {
        self.init(templates: [year, month, day, weekday, hour, minute, second, nanosecond, timeZone])
    }
    
}


extension Fixed where Granularity: StandardUnit & LTOEMinute {
    
    /// Format the year, month, day, hour, and minute of a fixed value
    /// - Parameters:
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(year: Template<Year>,
                       month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [year, month, day, weekday, hour, minute, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOESecond {
    
    /// Format the month, day, hour, minute, and second of a fixed value
    /// - Parameters:
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [month, day, weekday, hour, minute, second, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOENanosecond {
    
    /// Format the day, hour, minute, second, and nanosecond of a fixed value
    /// - Parameters:
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       nanosecond: Template<Nanosecond>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [day, weekday, hour, minute, second, nanosecond, timeZone])
        return self.format(using: format)
    }
    
}


extension Fixed where Granularity: StandardUnit & LTOESecond {
    
    /// Format the year, month, day, hour, minute, and second of a fixed value
    /// - Parameters:
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(year: Template<Year>,
                       month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [year, month, day, weekday, hour, minute, second, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOENanosecond {
    
    /// Format the month, day, hour, minute, second, and nanosecond of a fixed value
    /// - Parameters:
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       nanosecond: Template<Nanosecond>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [month, day, weekday, hour, minute, second, nanosecond, timeZone])
        return self.format(using: format)
    }
    
}


extension Fixed where Granularity: StandardUnit & LTOENanosecond {
    
    /// Format the year, month, day, hour, minute, second, and nanosecond of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(year: Template<Year>,
                       month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       nanosecond: Template<Nanosecond>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [year, month, day, weekday, hour, minute, second, nanosecond, timeZone])
        return self.format(using: format)
    }
    
}
