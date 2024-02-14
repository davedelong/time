//
//  PartialFormatting-4Units.swift
//  Time
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

extension Fixed where Granularity: LTOEHour {
    
    public func format(year: Template<Year>,
                       month: Template<Month>,
                       day: Template<Day>,
                       hour: Template<Hour>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, day, hour, timeZone])
    }
    
}

extension Fixed where Granularity: LTOEMinute {
    
    public func format(month: Template<Month>,
                       day: Template<Day>,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, day, hour, minute, timeZone])
    }
    
}

extension Fixed where Granularity: LTOESecond {
    
    public func format(day: Template<Day>,
                       hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([day, hour, minute, second, timeZone])
    }
    
}

extension Fixed where Granularity: LTOENanosecond {
    
    public func format(hour: Template<Hour>,
                       minute: Template<Minute>,
                       second: Template<Second>,
                       nanosecond: Template<Nanosecond>,
                       timeZone: Template<TimeZone>? = nil) -> String {
        return format([hour, minute, second, nanosecond, timeZone])
    }
    
}
