//
//  RelativeFormatting-1Unit.swift
//  Time
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension TimePeriod {
    func format(timeZone: Template<TimeZone>) -> String {
        return format([timeZone])
    }
}

public extension TimePeriod where Smallest: LTOEYear, Largest: GTOEYear {
    func format(year: Template<Year>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, timeZone])
    }
}

public extension TimePeriod where Smallest: LTOEMonth, Largest: GTOEMonth {
    func format(month: Template<Standalone<Month>>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, timeZone])
    }
}

public extension TimePeriod where Smallest: LTOEDay, Largest: GTOEDay {
    func format(day: Template<Day>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([day, timeZone])
    }
    func format(weekday: Template<Standalone<Weekday>>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([weekday, timeZone])
    }
}

public extension TimePeriod where Smallest: LTOEHour, Largest: GTOEHour {
    func format(hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([hour, timeZone])
    }
}

public extension TimePeriod where Smallest: LTOEMinute, Largest: GTOEMinute {
    func format(minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([minute, timeZone])
    }
}

public extension TimePeriod where Smallest: LTOESecond, Largest: GTOESecond {
    func format(second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([second, timeZone])
    }
}

public extension TimePeriod where Smallest: LTOENanosecond, Largest: GTOENanosecond {
    func format(nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([nanosecond, timeZone])
    }
}
