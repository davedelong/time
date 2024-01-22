//
//  RelativeFormatting-Others.swift
//  Time
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

extension Absolute where Smallest: LTOEMinute {
    
    public func format(year: Template<Year>,
                       month: Template<Month>,
                       day: Template<Day>,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, day, hour, minute, timeZone])
    }
    
}

extension Absolute where Smallest: LTOESecond {
    
    public func format(month: Template<Month>,
                       day: Template<Day>,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, day, hour, minute, second, timeZone])
    }
    
}

extension Absolute where Smallest: LTOENanosecond {
    
    public func format(day: Template<Day>,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       nanosecond: Template<Nanosecond>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([day, hour, minute, second, nanosecond, timeZone])
    }
    
}


extension Absolute where Smallest: LTOESecond {
    
    public func format(year: Template<Year>,
                       month: Template<Month>,
                       day: Template<Day>,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, day, hour, minute, second, timeZone])
    }
    
}

extension Absolute where Smallest: LTOENanosecond {
    
    public func format(month: Template<Month>,
                       day: Template<Day>,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       nanosecond: Template<Nanosecond>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, day, hour, minute, second, nanosecond, timeZone])
    }
    
}


extension Absolute where Smallest: LTOENanosecond {
    
    public func format(year: Template<Year>,
                       month: Template<Month>,
                       day: Template<Day>,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       nanosecond: Template<Nanosecond>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, day, hour, minute, second, nanosecond, timeZone])
    }
    
}
