//
//  File.swift
//  
//
//  Created by Dave DeLong on 2/4/20.
//

import Foundation

public enum FormatError: Error {
    
    case cannotParseString(String)
    case cannotLocateUnit(Calendar.Component)
    
}

public extension Value where Largest: GTOEEra {
    
    init(stringValue: String, format: String, region: Region) throws {
        let df = DateFormatterCache.shared.formatter(for: format, region: region)
        if let date = df.date(from: stringValue) {
            self.init(region: region, date: date)
        } else {
            throw FormatError.cannotParseString(stringValue)
        }
    }
    
}

public extension Value where Smallest: LTOEEra, Largest: GTOEEra {
    init(stringValue: String, region: Region,
         era: Template<Era>) -> String {
    
        try self.init(stringValue: stringValue, region: region, formats: [era])
    }
}

public extension Value where Smallest: LTOEYear, Largest: GTOEEra {
    init(stringValue: String, region: Region,
         era: Template<Era>? = nil,
         year: Template<Year>,
         timeZone: Template<TimeZone>? = nil) -> String {
    
        try self.init(stringValue: stringValue, region: region, formats: [era, year, timeZone])
    }
}

public extension Value where Smallest: LTOEMonth, Largest: GTOEEra {
    init(stringValue: String, region: Region,
         era: Template<Era>? = nil,
         year: Template<Year>,
         month: Template<Month>,
         timeZone: Template<TimeZone>? = nil) -> String {
    
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, timeZone])
    }
}

public extension Value where Smallest: LTOEDay, Largest: GTOEEra {
    init(stringValue: String, region: Region,
         era: Template<Era>? = nil,
         year: Template<Year>,
         month: Template<Month>,
         day: Template<Day>,
         weekday: Template<Weekday>? = nil,
         timeZone: Template<TimeZone>? = nil) -> String {
    
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, day, weekday, timeZone])
    }
}

public extension Value where Smallest: LTOEHour, Largest: GTOEEra {
    init(stringValue: String, region: Region,
         era: Template<Era>? = nil,
         year: Template<Year>,
         month: Template<Month>,
         day: Template<Day>,
         weekday: Template<Weekday>? = nil,
         hour: Template<Hour>,
         timeZone: Template<TimeZone>? = nil) -> String {
    
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, day, weekday, hour, timeZone])
    }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEEra {
    init(stringValue: String, region: Region,
         era: Template<Era>? = nil,
         year: Template<Year>,
         month: Template<Month>,
         day: Template<Day>,
         weekday: Template<Weekday>? = nil,
         hour: Template<Hour>,
         minute: Template<Minute>,
         timeZone: Template<TimeZone>? = nil) -> String {
    
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, day, weekday, hour, minute, timeZone])
    }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEEra {
    init(stringValue: String, region: Region,
         era: Template<Era>? = nil,
         year: Template<Year>,
         month: Template<Month>,
         day: Template<Day>,
         weekday: Template<Weekday>? = nil,
         hour: Template<Hour>,
         minute: Template<Minute>,
         second: Template<Second>,
         timeZone: Template<TimeZone>? = nil) -> String {
    
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, day, weekday, hour, minute, second, timeZone])
    }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEEra {
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
         timeZone: Template<TimeZone>? = nil) -> String {
    
        try self.init(stringValue: stringValue, region: region, formats: [era, year, month, day, weekday, hour, minute, second, nanosecond, timeZone])
    }
}
