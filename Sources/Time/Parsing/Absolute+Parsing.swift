//
//  Absolute+Parsing.swift
//  
//
//  Created by Dave DeLong on 2/4/20.
//

import Foundation

public extension Absolute where Largest == Era {
    
    init(stringValue: String, rawFormat: String, region: Region) throws {
        let df = DateFormatterCache.shared.formatter(forFormat: rawFormat, region: region)
        if let date = df.date(from: stringValue) {
            self.init(region: region, date: date)
        } else {
            throw TimeError.cannotParseString(stringValue, in: region)
        }
    }
    
}

public extension TimePeriod where Smallest == Era, Largest: GTOEEra {
    init(stringValue: String, region: Region,
         era: Template<Era>) throws {
    
        try self.init(stringValue: stringValue, region: region, formats: [era])
    }
}

public extension TimePeriod where Smallest == Year, Largest: GTOEEra {
    init(stringValue: String, region: Region,
         era: Template<Era>? = nil,
         year: Template<Year>,
         timeZone: Template<TimeZone>? = nil) throws {
    
        try self.init(stringValue: stringValue, region: region, formats: [era, year, timeZone])
    }
}

public extension TimePeriod where Smallest == Month, Largest: GTOEEra {
    init(stringValue: String, region: Region,
         era: Template<Era>? = nil,
         year: Template<Year>,
         month: Template<Month>,
         timeZone: Template<TimeZone>? = nil) throws {
    
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, timeZone])
    }
}

public extension TimePeriod where Smallest == Day, Largest: GTOEEra {
    init(stringValue: String, region: Region,
         era: Template<Era>? = nil,
         year: Template<Year>,
         month: Template<Month>,
         day: Template<Day>,
         weekday: Template<Weekday>? = nil,
         timeZone: Template<TimeZone>? = nil) throws {
    
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, day, weekday, timeZone])
    }
}

public extension TimePeriod where Smallest == Hour, Largest: GTOEEra {
    init(stringValue: String, region: Region,
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

public extension TimePeriod where Smallest == Minute, Largest: GTOEEra {
    init(stringValue: String, region: Region,
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

public extension TimePeriod where Smallest == Second, Largest: GTOEEra {
    init(stringValue: String, region: Region,
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

public extension TimePeriod where Smallest == Nanosecond, Largest: GTOEEra {
    init(stringValue: String, region: Region,
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
