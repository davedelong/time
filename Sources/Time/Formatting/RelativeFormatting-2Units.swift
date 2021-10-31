//
//  RelativeFormatting-2Units.swift
//  Time
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension TimePeriod where Smallest: _LTOEMonth, Largest: _GTOEYear {
    func format(year: Template<Year>,
                month: Template<Month>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, timeZone])
    }
}

public extension TimePeriod where Smallest: _LTOEDay, Largest: _GTOEMonth {
    func format(month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, day, weekday, timeZone])
    }
}

public extension TimePeriod where Smallest: _LTOEHour, Largest: _GTOEDay {
    func format(day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([day, weekday, hour, timeZone])
    }
}

public extension TimePeriod where Smallest: _LTOEMinute, Largest: _GTOEHour {
    func format(hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([hour, minute, timeZone])
    }
}

public extension TimePeriod where Smallest: _LTOESecond, Largest: _GTOEMinute {
    func format(minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([minute, second, timeZone])
    }
}

public extension TimePeriod where Smallest: _LTOENanosecond, Largest: _GTOESecond {
    func format(second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([second, nanosecond, timeZone])
    }
}
