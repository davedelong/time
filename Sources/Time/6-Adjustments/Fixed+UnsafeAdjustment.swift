//
//  Fixed+StrictAdjustment.swift
//  
//
//  Created by Dave DeLong on 11/9/19.
//

import Foundation

extension Fixed where Granularity: LTOEYear {
    
    /// Create a new fixed value by setting the `.year`
    ///
    /// This method preserves all other components (`.month`, `.day`, etc).
    ///
    /// - Parameter year: The numeric year
    /// - Returns: A new fixed value with the specified year.
    /// - Throws: Throws a ``TimeError`` if setting the year would result in a non-existent date. For example,
    /// `try aFixedDay.setting(year: -1)` would throw an error, because no supported calendar produces negative-numbered years.
    /// As another example, `try february29.setting(year: 2023)` would throw an error, because 2023 on the gregorian calendar
    /// was not a leap year, and February 29th did not exist that year.
    public func setting(year: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year))
    }
    
}

extension Fixed where Granularity: LTOEMonth {
    
    /// Create a new fixed value by setting its year and month
    /// - Parameters:
    ///   - year: The new year value
    ///   - month: The new month value
    /// - Returns: A new fixed value with the specified year and month
    /// - Throws: Throws a ``TimeError`` if setting the year and month would result in a non-existent date.
    public func setting(year: Int, month: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month))
    }
    
    /// Create a new fixed value by setting its month
    /// - Parameters:
    ///   - month: The new month value
    /// - Returns: A new fixed value with the specified month
    /// - Throws: Throws a ``TimeError`` if setting the month would result in a non-existent date.
    public func setting(month: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month))
    }
    
}

extension Fixed where Granularity: LTOEDay {
    
    /// Create a new fixed value by setting its year, month, and day
    /// - Parameters:
    ///   - year: The new year value
    ///   - month: The new month value
    ///   - day: The new day value
    /// - Returns: A new fixed value with the specified year, month, and day
    /// - Throws: Throws a ``TimeError`` if setting the year, month, and day would result in a non-existent date.
    public func setting(year: Int, month: Int, day: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month, day: day))
    }
    
    /// Create a new fixed value by setting its month and day
    /// - Parameters:
    ///   - month: The new month value
    ///   - day: The new day value
    /// - Returns: A new fixed value with the specified month and day
    /// - Throws: Throws a ``TimeError`` if setting the month and day would result in a non-existent date.
    public func setting(month: Int, day: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month, day: day))
    }
    
    /// Create a new fixed value by setting its day
    /// - Parameters:
    ///   - day: The new day value
    /// - Returns: A new fixed value with the specified day
    /// - Throws: Throws a ``TimeError`` if setting the day would result in a non-existent date.
    public func setting(day: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(day: day))
    }
    
}

extension Fixed where Granularity: LTOEHour {
    
    /// Create a new fixed value by setting its year, month, day, and hour
    /// - Parameters:
    ///   - year: The new year value
    ///   - month: The new month value
    ///   - day: The new day value
    ///   - hour: The new hour value
    /// - Returns: A new fixed value with the specified year, month, day, and hour
    /// - Throws: Throws a ``TimeError`` if setting the year, month, day, and hour would result in a non-existent date.
    public func setting(year: Int, month: Int, day: Int, hour: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month, day: day, hour: hour))
    }
    
    /// Create a new fixed value by setting its month, day, and hour
    /// - Parameters:
    ///   - month: The new month value
    ///   - day: The new day value
    ///   - hour: The new hour value
    /// - Returns: A new fixed value with the specified month, day, and hour
    /// - Throws: Throws a ``TimeError`` if setting the month, day, and hour would result in a non-existent date.
    public func setting(month: Int, day: Int, hour: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour))
    }
    
    /// Create a new fixed value by setting its day and hour
    /// - Parameters:
    ///   - day: The new day value
    ///   - hour: The new hour value
    /// - Returns: A new fixed value with the specified day and hour
    /// - Throws: Throws a ``TimeError`` if setting the day and hour would result in a non-existent date.
    public func setting(day: Int, hour: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour))
    }
    
    /// Create a new fixed value by setting its hour
    /// - Parameters:
    ///   - hour: The new hour value
    /// - Returns: A new fixed value with the specified hour
    /// - Throws: Throws a ``TimeError`` if setting the hour would result in a non-existent date.
    public func setting(hour: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(hour: hour))
    }
    
}

extension Fixed where Granularity: LTOEMinute {
    
    /// Create a new fixed value by setting its year, month, day, hour, and minute
    /// - Parameters:
    ///   - year: The new year value
    ///   - month: The new month value
    ///   - day: The new day value
    ///   - hour: The new hour value
    ///   - minute: The new minute value
    /// - Returns: A new fixed value with the specified year, month, day, hour, and minute
    /// - Throws: Throws a ``TimeError`` if setting the year, month, day, hour, and minute would result in a non-existent date.
    public func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month, day: day, hour: hour, minute: minute))
    }
    
    /// Create a new fixed value by setting its month, day, hour, and minute
    /// - Parameters:
    ///   - month: The new month value
    ///   - day: The new day value
    ///   - hour: The new hour value
    ///   - minute: The new minute value
    /// - Returns: A new fixed value with the specified month, day, hour, and minute
    /// - Throws: Throws a ``TimeError`` if setting the month, day, hour, and minute would result in a non-existent date.
    public func setting(month: Int, day: Int, hour: Int, minute: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute))
    }
    
    /// Create a new fixed value by setting its day, hour, and minute
    /// - Parameters:
    ///   - day: The new day value
    ///   - hour: The new hour value
    ///   - minute: The new minute value
    /// - Returns: A new fixed value with the specified day, hour, and minute
    /// - Throws: Throws a ``TimeError`` if setting the day, hour, and minute would result in a non-existent date.
    public func setting(day: Int, hour: Int, minute: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute))
    }
    
    /// Create a new fixed value by setting its hour and minute
    /// - Parameters:
    ///   - hour: The new hour value
    ///   - minute: The new minute value
    /// - Returns: A new fixed value with the specified hour and minute
    /// - Throws: Throws a ``TimeError`` if setting the hour and minute would result in a non-existent date.
    public func setting(hour: Int, minute: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute))
    }
    
    /// Create a new fixed value by setting its minute
    /// - Parameters:
    ///   - minute: The new minute value
    /// - Returns: A new fixed value with the specified minute
    /// - Throws: Throws a ``TimeError`` if setting the minute would result in a non-existent date.
    public func setting(minute: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(minute: minute))
    }
    
}

extension Fixed where Granularity: LTOESecond {
    
    /// Create a new fixed value by setting its year, month, day, hour, minute, and second
    /// - Parameters:
    ///   - year: The new year value
    ///   - month: The new month value
    ///   - day: The new day value
    ///   - hour: The new hour value
    ///   - minute: The new minute value
    ///   - second: The new second value
    /// - Returns: A new fixed value with the specified year, month, day, hour, minute, and second
    /// - Throws: Throws a ``TimeError`` if setting the year, month, day, hour, minute, and second would result in a non-existent date.
    public func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month, day: day, hour: hour, minute: minute, second: second))
    }
    
    /// Create a new fixed value by setting its month, day, hour, minute, and second
    /// - Parameters:
    ///   - month: The new month value
    ///   - day: The new day value
    ///   - hour: The new hour value
    ///   - minute: The new minute value
    ///   - second: The new second value
    /// - Returns: A new fixed value with the specified month, day, hour, minute, and second
    /// - Throws: Throws a ``TimeError`` if setting the month, day, hour, minute, and second would result in a non-existent date.
    public func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second))
    }
    
    /// Create a new fixed value by setting its day, hour, minute, and second
    /// - Parameters:
    ///   - day: The new day value
    ///   - hour: The new hour value
    ///   - minute: The new minute value
    ///   - second: The new second value
    /// - Returns: A new fixed value with the specified day, hour, minute, and second
    /// - Throws: Throws a ``TimeError`` if setting the day, hour, minute, and second would result in a non-existent date.
    public func setting(day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute, second: second))
    }
    
    /// Create a new fixed value by setting its hour, minute, and second
    /// - Parameters:
    ///   - hour: The new hour value
    ///   - minute: The new minute value
    ///   - second: The new second value
    /// - Returns: A new fixed value with the specified hour, minute, and second
    /// - Throws: Throws a ``TimeError`` if setting the hour, minute, and second would result in a non-existent date.
    public func setting(hour: Int, minute: Int, second: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute, second: second))
    }
    
    /// Create a new fixed value by setting its minute and second
    /// - Parameters:
    ///   - minute: The new minute value
    ///   - second: The new second value
    /// - Returns: A new fixed value with the specified minute and second
    /// - Throws: Throws a ``TimeError`` if setting the minute and second would result in a non-existent date.
    public func setting(minute: Int, second: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(minute: minute, second: second))
    }
    
    /// Create a new fixed value by setting its second
    /// - Parameters:
    ///   - second: The new second value
    /// - Returns: A new fixed value with the specified second
    /// - Throws: Throws a ``TimeError`` if setting the second would result in a non-existent date.
    public func setting(second: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(second: second))
    }
    
}

extension Fixed where Granularity: LTOENanosecond {
    
    /// Create a new fixed value by setting its year, month, day, hour, minute, second, and nanosecond
    /// - Parameters:
    ///   - year: The new year value
    ///   - month: The new month value
    ///   - day: The new day value
    ///   - hour: The new hour value
    ///   - minute: The new minute value
    ///   - second: The new second value
    ///   - nanosecond: The new nanosecond value
    /// - Returns: A new fixed value with the specified year, month, day, hour, minute, second, and nanosecond
    /// - Throws: Throws a ``TimeError`` if setting the year, month, day, hour, minute, second, and nanosecond would result in a non-existent date.
    public func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
    
    /// Create a new fixed value by setting its month, day, hour, minute, second, and nanosecond
    /// - Parameters:
    ///   - month: The new month value
    ///   - day: The new day value
    ///   - hour: The new hour value
    ///   - minute: The new minute value
    ///   - second: The new second value
    ///   - nanosecond: The new nanosecond value
    /// - Returns: A new fixed value with the specified month, day, hour, minute, second, and nanosecond
    /// - Throws: Throws a ``TimeError`` if setting the month, day, hour, minute, second, and nanosecond would result in a non-existent date.
    public func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
    
    /// Create a new fixed value by setting its day, hour, minute, second, and nanosecond
    /// - Parameters:
    ///   - day: The new day value
    ///   - hour: The new hour value
    ///   - minute: The new minute value
    ///   - second: The new second value
    ///   - nanosecond: The new nanosecond value
    /// - Returns: A new fixed value with the specified day, hour, minute, second, and nanosecond
    /// - Throws: Throws a ``TimeError`` if setting the day, hour, minute, second, and nanosecond would result in a non-existent date.
    public func setting(day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
    
    /// Create a new fixed value by setting its hour, minute, second, and nanosecond
    /// - Parameters:
    ///   - hour: The new hour value
    ///   - minute: The new minute value
    ///   - second: The new second value
    ///   - nanosecond: The new nanosecond value
    /// - Returns: A new fixed value with the specified hour, minute, second, and nanosecond
    /// - Throws: Throws a ``TimeError`` if setting the hour, minute, second, and nanosecond would result in a non-existent date.
    public func setting(hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
    
    /// Create a new fixed value by setting its minute, second, and nanosecond
    /// - Parameters:
    ///   - minute: The new minute value
    ///   - second: The new second value
    ///   - nanosecond: The new nanosecond value
    /// - Returns: A new fixed value with the specified minute, second, and nanosecond
    /// - Throws: Throws a ``TimeError`` if setting the minute, second, and nanosecond would result in a non-existent date.
    public func setting(minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(minute: minute, second: second, nanosecond: nanosecond))
    }
    
    /// Create a new fixed value by setting its second and nanosecond
    /// - Parameters:
    ///   - second: The new second value
    ///   - nanosecond: The new nanosecond value
    /// - Returns: A new fixed value with the specified second and nanosecond
    /// - Throws: Throws a ``TimeError`` if setting the second and nanosecond would result in a non-existent date.
    public func setting(second: Int, nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(second: second, nanosecond: nanosecond))
    }
    
    /// Create a new fixed value by setting its nanosecond
    /// - Parameters:
    ///   - nanosecond: The new nanosecond value
    /// - Returns: A new fixed value with the specified nanosecond
    /// - Throws: Throws a ``TimeError`` if setting the nanosecond would result in a non-existent date.
    public func setting(nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(nanosecond: nanosecond))
    }
}

extension Fixed where Granularity == Year {
    
    /// Create a `Fixed<Month>` from a `Fixed<Year>` by specifying the month
    /// - Parameter month: The new month value
    /// - Returns: A new `Fixed<Month>` with the specified month value
    /// - Throws: Throws a ``TimeError`` if the specified month value would result in a non-existent date.
    public func setting(month: Int) throws -> Fixed<Month> {
        return try Fixed<Month>(region: region, strictDateComponents: dateComponents.setting(month: month))
    }
    
    /// Create a `Fixed<Day>` from a `Fixed<Year>` by specifying the month and day
    /// - Parameter month: The new month value
    /// - Parameter day: The new day value
    /// - Returns: A new `Fixed<Day>` with the specified month and day values
    /// - Throws: Throws a ``TimeError`` if the specified month and day values would result in a non-existent date.
    public func setting(month: Int, day: Int) throws -> Fixed<Day> {
        return try Fixed<Day>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day))
    }
    
    /// Create a `Fixed<Hour>` from a `Fixed<Year>` by specifying the month, day, and hour
    /// - Parameter month: The new month value
    /// - Parameter day: The new day value
    /// - Parameter hour: The new hour value
    /// - Returns: A new `Fixed<Hour>` with the specified month, day, and hour values
    /// - Throws: Throws a ``TimeError`` if the specified month, day, and hour values would result in a non-existent date.
    public func setting(month: Int, day: Int, hour: Int) throws -> Fixed<Hour> {
        return try Fixed<Hour>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour))
    }
    
    /// Create a `Fixed<Minute>` from a `Fixed<Year>` by specifying the month, day, hour, and minute
    /// - Parameter month: The new month value
    /// - Parameter day: The new day value
    /// - Parameter hour: The new hour value
    /// - Parameter minute: The new minute value
    /// - Returns: A new `Fixed<Minute>` with the specified month, day, hour, and minute values
    /// - Throws: Throws a ``TimeError`` if the specified month, day, hour, and minute values would result in a non-existent date.
    public func setting(month: Int, day: Int, hour: Int, minute: Int) throws -> Fixed<Minute> {
        return try Fixed<Minute>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute))
    }
    
    /// Create a `Fixed<Second>` from a `Fixed<Year>` by specifying the month, day, hour, minute, and second
    /// - Parameter month: The new month value
    /// - Parameter day: The new day value
    /// - Parameter hour: The new hour value
    /// - Parameter minute: The new minute value
    /// - Parameter second: The new second value
    /// - Returns: A new `Fixed<Second>` with the specified month, day, hour, minute, and second values
    /// - Throws: Throws a ``TimeError`` if the specified month, day, hour, minute, and second values would result in a non-existent date.
    public func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Fixed<Second> {
        return try Fixed<Second>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second))
    }
    
    /// Create a `Fixed<Nanosecond>` from a `Fixed<Year>` by specifying the month, day, hour, minute, second, and nanosecond
    /// - Parameter month: The new month value
    /// - Parameter day: The new day value
    /// - Parameter hour: The new hour value
    /// - Parameter minute: The new minute value
    /// - Parameter second: The new second value
    /// - Parameter nanosecond: The new nanosecond value
    /// - Returns: A new `Fixed<Nanosecond>` with the specified month, day, hour, minute, second, and nanosecond values
    /// - Throws: Throws a ``TimeError`` if the specified month, day, hour, minute, second, and nanosecond values would result in a non-existent date.
    public func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Fixed<Nanosecond> {
        return try Fixed<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
}

extension Fixed where Granularity == Month {
    
    /// Create a `Fixed<Day>` from a `Fixed<Month>` by specifying the day
    /// - Parameter day: The new day value
    /// - Returns: A new `Fixed<Day>` with the specified day value
    /// - Throws: Throws a ``TimeError`` if the specified day value would result in a non-existent date.
    public func setting(day: Int) throws -> Fixed<Day> {
        return try Fixed<Day>(region: region, strictDateComponents: dateComponents.setting(day: day))
    }
    
    /// Create a `Fixed<Hour>` from a `Fixed<Month>` by specifying the day and hour
    /// - Parameter day: The new day value
    /// - Parameter hour: The new hour value
    /// - Returns: A new `Fixed<Hour>` with the specified day and hour values
    /// - Throws: Throws a ``TimeError`` if the specified day and hour values would result in a non-existent date.
    public func setting(day: Int, hour: Int) throws -> Fixed<Hour> {
        return try Fixed<Hour>(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour))
    }
    
    /// Create a `Fixed<Minute>` from a `Fixed<Month>` by specifying the day, hour, and minute
    /// - Parameter day: The new day value
    /// - Parameter hour: The new hour value
    /// - Parameter minute: The new minute value
    /// - Returns: A new `Fixed<Minute>` with the specified day, hour, and minute values
    /// - Throws: Throws a ``TimeError`` if the specified day, hour, and minute values would result in a non-existent date.
    public func setting(day: Int, hour: Int, minute: Int) throws -> Fixed<Minute> {
        return try Fixed<Minute>(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute))
    }
    
    /// Create a `Fixed<Second>` from a `Fixed<Month>` by specifying the day, hour, minute, and second
    /// - Parameter day: The new day value
    /// - Parameter hour: The new hour value
    /// - Parameter minute: The new minute value
    /// - Parameter second: The new second value
    /// - Returns: A new `Fixed<Second>` with the specified day, hour, minute, and second values
    /// - Throws: Throws a ``TimeError`` if the specified day, hour, minute, and second values would result in a non-existent date.
    public func setting(day: Int, hour: Int, minute: Int, second: Int) throws -> Fixed<Second> {
        return try Fixed<Second>(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute, second: second))
    }
    
    /// Create a `Fixed<Nanosecond>` from a `Fixed<Month>` by specifying the day, hour, minute, second, and nanosecond
    /// - Parameter day: The new day value
    /// - Parameter hour: The new hour value
    /// - Parameter minute: The new minute value
    /// - Parameter second: The new second value
    /// - Parameter nanosecond: The new nanosecond value
    /// - Returns: A new `Fixed<Nanosecond>` with the specified day, hour, minute, second, and nanosecond values
    /// - Throws: Throws a ``TimeError`` if the specified day, hour, minute, second, and nanosecond values would result in a non-existent date.
    public func setting(day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Fixed<Nanosecond> {
        return try Fixed<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
}

extension Fixed where Granularity == Day {
    
    /// Create a `Fixed<Hour>` from a `Fixed<Day>` by specifying the hour
    /// - Parameter hour: The new hour value
    /// - Returns: A new `Fixed<Hour>` with the specified hour value
    /// - Throws: Throws a ``TimeError`` if the specified hour value would result in a non-existent date.
    public func setting(hour: Int) throws -> Fixed<Hour> {
        return try Fixed<Hour>(region: region, strictDateComponents: dateComponents.setting(hour: hour))
    }
    
    /// Create a `Fixed<Minute>` from a `Fixed<Day>` by specifying the hour and minute
    /// - Parameter hour: The new hour value
    /// - Parameter minute: The new minute value
    /// - Returns: A new `Fixed<Minute>` with the specified hour and minute values
    /// - Throws: Throws a ``TimeError`` if the specified hour and minute values would result in a non-existent date.
    public func setting(hour: Int, minute: Int) throws -> Fixed<Minute> {
        return try Fixed<Minute>(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute))
    }
    
    /// Create a `Fixed<Second>` from a `Fixed<Day>` by specifying the hour, minute, and second
    /// - Parameter hour: The new hour value
    /// - Parameter minute: The new minute value
    /// - Parameter second: The new second value
    /// - Returns: A new `Fixed<Second>` with the specified hour, minute, and second values
    /// - Throws: Throws a ``TimeError`` if the specified hour, minute, and second values would result in a non-existent date.
    public func setting(hour: Int, minute: Int, second: Int) throws -> Fixed<Second> {
        return try Fixed<Second>(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute, second: second))
    }
    
    /// Create a `Fixed<Nanosecond>` from a `Fixed<Day>` by specifying the hour, minute, second, and nanosecond
    /// - Parameter hour: The new hour value
    /// - Parameter minute: The new minute value
    /// - Parameter second: The new second value
    /// - Parameter nanosecond: The new nanosecond value
    /// - Returns: A new `Fixed<Nanosecond>` with the specified hour, minute, second, and nanosecond values
    /// - Throws: Throws a ``TimeError`` if the specified hour, minute, second, and nanosecond values would result in a non-existent date.
    public func setting(hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Fixed<Nanosecond> {
        return try Fixed<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
}

extension Fixed where Granularity == Hour {
    
    /// Create a `Fixed<Minute>` from a `Fixed<Hour>` by specifying the minute
    /// - Parameter minute: The new minute value
    /// - Returns: A new `Fixed<Nanosecond>` with the specified minute value
    /// - Throws: Throws a ``TimeError`` if the specified minute value would result in a non-existent date.
    public func setting(minute: Int) throws -> Fixed<Minute> {
        return try Fixed<Minute>(region: region, strictDateComponents: dateComponents.setting(minute: minute))
    }
    
    /// Create a `Fixed<Second>` from a `Fixed<Hour>` by specifying the minute and second
    /// - Parameter minute: The new minute value
    /// - Parameter second: The new second value
    /// - Returns: A new `Fixed<Second>` with the specified minute and second values
    /// - Throws: Throws a ``TimeError`` if the specified minute and second values would result in a non-existent date.
    public func setting(minute: Int, second: Int) throws -> Fixed<Second> {
        return try Fixed<Second>(region: region, strictDateComponents: dateComponents.setting(minute: minute, second: second))
    }
    
    /// Create a `Fixed<Nanosecond>` from a `Fixed<Hour>` by specifying the minute, second, and nanosecond
    /// - Parameter minute: The new minute value
    /// - Parameter second: The new second value
    /// - Parameter nanosecond: The new nanosecond value
    /// - Returns: A new `Fixed<Nanosecond>` with the specified minute, second, and nanosecond values
    /// - Throws: Throws a ``TimeError`` if the specified minute, second, and nanosecond values would result in a non-existent date.
    public func setting(minute: Int, second: Int, nanosecond: Int) throws -> Fixed<Nanosecond> {
        return try Fixed<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(minute: minute, second: second, nanosecond: nanosecond))
    }
}

extension Fixed where Granularity == Minute {
    
    /// Create a `Fixed<Second>` from a `Fixed<Minute>` by specifying the second
    /// - Parameter second: The new second value
    /// - Returns: A new `Fixed<Second>` with the specified second value
    /// - Throws: Throws a ``TimeError`` if the specified second value would result in a non-existent date.
    public func setting(second: Int) throws -> Fixed<Second> {
        return try Fixed<Second>(region: region, strictDateComponents: dateComponents.setting(second: second))
    }
    
    /// Create a `Fixed<Nanosecond>` from a `Fixed<Minute>` by specifying the second and nanosecond
    /// - Parameter second: The new second value
    /// - Parameter nanosecond: The new nanosecond value
    /// - Returns: A new `Fixed<Nanosecond>` with the specified second and nanosecond values
    /// - Throws: Throws a ``TimeError`` if the specified second and nanosecond values would result in a non-existent date.
    public func setting(second: Int, nanosecond: Int) throws -> Fixed<Nanosecond> {
        return try Fixed<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(second: second, nanosecond: nanosecond))
    }
}

extension Fixed where Granularity == Second {
    
    /// Create a `Fixed<Nanosecond>` from a `Fixed<Second>` by specifying the nanosecond
    /// - Parameter nanosecond: The new nanosecond value
    /// - Returns: A new `Fixed<Nanosecond>` with the specified nanosecond value
    /// - Throws: Throws a ``TimeError`` if the specified nanosecond value would result in a non-existent date.
    public func setting(nanosecond: Int) throws -> Fixed<Nanosecond> {
        return try Fixed<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(nanosecond: nanosecond))
    }
}
