import Foundation

extension FixedFormat {
    
    /// Create a format for the era of a fixed value
    /// - Parameter era: The template for formatting the era
    public init(era: Template<Era>) {
        self.init(templates: [era])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEYear {
    
    /// Create a format for the year of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - timeZone: The template for formatting the time zone
    public init(era: Template<Era>,
                year: Template<Year>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [era, year, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEMonth {
    
    /// Create a format for the year and month of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - timeZone: The template for formatting the time zone
    public init(era: Template<Era>,
                year: Template<Year>,
                month: Template<Month>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [era, year, month, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEDay {
    
    /// Create a format for the year, month, and day of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - timeZone: The template for formatting the time zone
    public init(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [era, year, month, day, weekday, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEHour {
    
    /// Create a format for the year, month, day, and hour of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - timeZone: The template for formatting the time zone
    public init(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [era, year, month, day, weekday, hour, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOEMinute {
    
    /// Create a format for the year, month, day, hour, and minute of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - timeZone: The template for formatting the time zone
    public init(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [era, year, month, day, weekday, hour, minute, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOESecond {
    
    /// Create a format for the year, month, day, hour, minute, and second of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - timeZone: The template for formatting the time zone
    public init(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [era, year, month, day, weekday, hour, minute, second, timeZone])
    }
    
}

extension FixedFormat where Granularity: StandardUnit & LTOENanosecond {
    
    /// Create a format for the year, month, day, hour, minute, second, and nanosecond of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    public init(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) {
        self.init(templates: [era, year, month, day, weekday, hour, minute, second, nanosecond, timeZone])
    }
    
}


extension Fixed {
    
    /// Format the era of a fixed value
    /// - Parameter era: The template for formatting the era
    /// - Returns: A string with the formatted era information
    public func format(era: Template<Era>) -> String {
        return format([era])
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEYear {
    
    /// Format the year of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(era: Template<Era>,
                       year: Template<Year>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, timeZone])
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEMonth {
    
    /// Format the year and month of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(era: Template<Era>,
                       year: Template<Year>,
                       month: Template<Month>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, timeZone])
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEDay {
    
    /// Format the year, month, and day of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(era: Template<Era>? = nil,
                       year: Template<Year>,
                       month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, day, weekday, timeZone])
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEHour {
    
    /// Format the year, month, day, and hour of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(era: Template<Era>? = nil,
                       year: Template<Year>,
                       month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       hour: Template<Hour>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, day, weekday, hour, timeZone])
    }
    
}

extension Fixed where Granularity: StandardUnit & LTOEMinute {
    
    /// Format the year, month, day, hour, and minute of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(era: Template<Era>? = nil,
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

extension Fixed where Granularity: StandardUnit & LTOESecond {
    
    /// Format the year, month, day, hour, minute, and second of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(era: Template<Era>? = nil,
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

extension Fixed where Granularity: StandardUnit & LTOENanosecond {
    
    /// Format the year, month, day, hour, minute, second, and nanosecond of a fixed value
    /// - Parameters:
    ///   - era: The template for formatting the era
    ///   - year: The template for formatting the year
    ///   - month: The template for formatting the month
    ///   - day: The template for formatting the day
    ///   - weekday: The template for formatting the day of the week
    ///   - hour: The template for formatting the hour
    ///   - minute: The template for formatting the minute
    ///   - second: The template for formatting the second
    ///   - nanosecond: The template for formatting the nanosecond
    ///   - timeZone: The template for formatting the time zone
    /// - Returns: A string with the formatted date components
    public func format(era: Template<Era>? = nil,
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
