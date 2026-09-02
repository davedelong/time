import Foundation

extension FixedFormat {
    
    /// Create a format for the time zone of a fixed value
    /// - Parameter timeZone: The template for formatting the time zone
    public init(timeZone: Template<TimeZone>) {
        self.init(templates: [timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEYear {
    
    /// Create a format for the year of a fixed value
    /// - Parameters:
    ///   - year: The template for formatting the year
    ///   - timeZone: The template for formatting the time zone
    public init(year: Template<Year>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [year, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEMonth {
    
    /// Create a format for the month of a fixed value
    /// - Parameters:
    ///   - month: The template for formatting the month
    ///   - timeZone: The template for formatting the time zone
    public init(month: Template<Standalone<Month>>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [month, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEDay {
    
    /// Create a format for the day of a fixed value
    /// - Parameters:
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - timeZone: The template for formatting the time zone
    public init(day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [day, weekday, timeZone])
    }
    
    /// Create a format for the weekday of a fixed value
    /// - Parameters:
    ///   - weekday: The template for formatting the day of the week
    ///   - timeZone: The template for formatting the time zone
    public init(weekday: Template<Standalone<Weekday>>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [weekday, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEHour {
    
    /// Create a format for the hour of a fixed value
    /// - Parameters:
    ///   - hour: The template for formatting the hour
    ///   - timeZone: The template for formatting the time zone
    public init(hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [hour, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEMinute {
    
    /// Create a format for the minute of a fixed value
    /// - Parameters:
    ///   - minute: The template for formatting the minute
    ///   - timeZone: The template for formatting the time zone
    public init(minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [minute, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOESecond {
    
    /// Create a format for the second of a fixed value
    /// - Parameters:
    ///   - second: The template for formatting the second
    ///   - timeZone: The template for formatting the time zone
    public init(second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [second, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOENanosecond {
    
    /// Create a format for the nanosecond of a fixed value
    /// - Parameters:
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    public init(nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [nanosecond, timeZone])
    }
    
}


extension Fixed {
    
    /// Format the time zone of a fixed value
    /// - Parameter timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted time zone information
    public func format(timeZone: Template<TimeZone>) -> String {
        let format = FixedFormat<Granularity>(templates: [timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEYear {
    
    /// Format the year of a fixed value
    /// - Parameters:
    ///   - year: The template for formatting the year
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted year information
    public func format(year: Template<Year>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [year, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEMonth {
    
    /// Format the month of a fixed value
    /// - Parameters:
    ///   - month: The template for formatting the month
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted month information
    public func format(month: Template<Standalone<Month>>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [month, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEDay {
    
    /// Format the day of a fixed value
    /// - Parameters:
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted day information
    public func format(day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [day, weekday, timeZone])
        return self.format(using: format)
    }
    
    /// Format the weekday of a fixed value
    /// - Parameters:
    ///   - weekday: The template for formatting the day of the week
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted weekday information
    public func format(weekday: Template<Standalone<Weekday>>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [weekday, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEHour {
    
    /// Format the hour of a fixed value
    /// - Parameters:
    ///   - hour: The template for formatting the hour
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted hour information
    public func format(hour: Template<Hour>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [hour, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEMinute {
    
    /// Format the minute of a fixed value
    /// - Parameters:
    ///   - minute: The template for formatting the minute
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted minute information
    public func format(minute: Template<Minute>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [minute, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOESecond {
    
    /// Format the second of a fixed value
    /// - Parameters:
    ///   - second: The template for formatting the second
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted second information
    public func format(second: Template<Second>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [second, timeZone])
        return self.format(using: format)
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOENanosecond {
    
    /// Format the nanosecond of a fixed value
    /// - Parameters:
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted nanosecond information
    public func format(nanosecond: Template<Nanosecond>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        let format = FixedFormat<Granularity>(templates: [nanosecond, timeZone])
        return self.format(using: format)
    }
    
}
