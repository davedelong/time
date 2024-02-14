//
//  Fixed+Parsing.swift
//
//
//  Created by Dave DeLong on 2/4/20.
//

import Foundation

extension Fixed {
    
    public init(stringValue: String, rawFormat: String, region: Region) throws {
        let df = DateFormatter.formatter(for: rawFormat, region: region)
        if let date = df.date(from: stringValue) {
            self.init(region: region, date: date)
        } else {
            throw TimeError.cannotParseString(stringValue, in: region)
        }
    }
    
}

extension Fixed where Granularity == Era {
    public init(stringValue: String, region: Region,
                era: Template<Era>) throws {
        
        try self.init(stringValue: stringValue, region: region, formats: [era])
    }
}

extension Fixed where Granularity == Year {
    public init(stringValue: String, region: Region,
                era: Template<Era>? = nil,
                year: Template<Year>,
                timeZone: Template<TimeZone>? = nil) throws {
        
        try self.init(stringValue: stringValue, region: region, formats: [era, year, timeZone])
    }
}

extension Fixed where Granularity == Month {
    public init(stringValue: String, region: Region,
                era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                timeZone: Template<TimeZone>? = nil) throws {
        
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, timeZone])
    }
}

extension Fixed where Granularity == Day {
    public init(stringValue: String, region: Region,
                era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                timeZone: Template<TimeZone>? = nil) throws {
        
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, day, weekday, timeZone])
    }
}

extension Fixed where Granularity == Hour {
    public init(stringValue: String, region: Region,
                era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) throws {
        
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, day, weekday, hour, timeZone])
    }
}

extension Fixed where Granularity == Minute {
    public init(stringValue: String, region: Region,
                era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) throws {
        
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, day, weekday, hour, minute, timeZone])
    }
}

extension Fixed where Granularity == Second {
    public init(stringValue: String, region: Region,
                era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) throws {
        
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, day, weekday, hour, minute, second, timeZone])
    }
}

extension Fixed where Granularity == Nanosecond {
    public init(stringValue: String, region: Region,
                era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) throws {
        
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, day, weekday, hour, minute, second, nanosecond, timeZone])
    }
}
