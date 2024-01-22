//
//  AbsoluteFormatting.swift
//  Time
//
//  Created by Dave DeLong on 5/17/18.
//

import Foundation

extension Absolute {
    
    public func format(era: Template<Era>) -> String {
        return format([era])
    }
    
}

extension Absolute where Smallest: LTOEYear {
    
    public func format(era: Template<Era>? = nil,
                       year: Template<Year>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, timeZone])
    }
    
}

extension Absolute where Smallest: LTOEMonth {
    
    public func format(era: Template<Era>? = nil,
                       year: Template<Year>,
                       month: Template<Month>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, timeZone])
    }
    
}

extension Absolute where Smallest: LTOEDay {
    
    public func format(era: Template<Era>? = nil,
                       year: Template<Year>,
                       month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, day, weekday, timeZone])
    }
    
}

extension Absolute where Smallest: LTOEHour {
    
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

extension Absolute where Smallest: LTOEMinute {
    
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

extension Absolute where Smallest: LTOESecond {
    
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

extension Absolute where Smallest: LTOENanosecond {
    
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
