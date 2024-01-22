//
//  RelativeFormatting-2Units.swift
//  Time
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

extension Absolute where Smallest: LTOEMonth {
    
    public func format(year: Template<Year>,
                       month: Template<Month>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, timeZone])
    }
    
}

extension Absolute where Smallest: LTOEDay {
    
    public func format(month: Template<Month>,
                       day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, day, weekday, timeZone])
    }
    
}

extension Absolute where Smallest: LTOEHour {
    
    public func format(day: Template<Day>,
                       weekday: Template<Weekday>? = nil,
                       hour: Template<Hour>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([day, weekday, hour, timeZone])
    }
    
}

extension Absolute where Smallest: LTOEMinute {
    
    public func format(hour: Template<Hour>,
                       minute: Template<Minute>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([hour, minute, timeZone])
    }
    
}

extension Absolute where Smallest: LTOESecond {
    
    public func format(minute: Template<Minute>,
                       second: Template<Second>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([minute, second, timeZone])
    }
    
}

extension Absolute where Smallest: LTOENanosecond {
    
    public func format(second: Template<Second>,
                       nanosecond: Template<Nanosecond>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([second, nanosecond, timeZone])
    }
    
}
