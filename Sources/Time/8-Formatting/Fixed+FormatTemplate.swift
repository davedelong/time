//
//  Fixed+FormatTemplate.swift
//  Time
//
//  Created by Dave DeLong on 5/17/18.
//

import Foundation

extension Fixed {
    
    public func format(era: Template<Era>) -> String {
        return format([era])
    }
    
}

extension Fixed where Smallest: LTOEYear {
    
    public func format(era: Template<Era>? = nil,
                       year: Template<Year>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, timeZone])
    }
    
}

extension Fixed where Smallest: LTOEMonth {
    
    public func format(era: Template<Era>? = nil,
                       year: Template<Year>,
                       month: Template<Month>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, timeZone])
    }
    
}

extension Fixed where Smallest: LTOEDay {
    
    public func format(era: Template<Era>? = nil,
                       year: Template<Year>,
                       month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, day, weekday, timeZone])
    }
    
}

extension Fixed where Smallest: LTOEHour {
    
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

extension Fixed where Smallest: LTOEMinute {
    
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

extension Fixed where Smallest: LTOESecond {
    
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

extension Fixed where Smallest: LTOENanosecond {
    
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
