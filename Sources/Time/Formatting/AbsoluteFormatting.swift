//
//  Absolute.swift
//  Time
//
//  Created by Dave DeLong on 5/17/18.
//

import Foundation

public extension Absolute where Smallest: LTOEEra {
    func format(era: Template<Era>) -> String {
        return format([era])
    }
}

public extension Absolute where Smallest: LTOEYear {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, timeZone])
    }
}

public extension Absolute where Smallest: LTOEMonth {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, timeZone])
    }
}

public extension Absolute where Smallest: LTOEDay {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, day, weekday, timeZone])
    }
}

public extension Absolute where Smallest: LTOEHour {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([era, year, month, day, weekday, hour, timeZone])
    }
}

public extension Absolute where Smallest: LTOEMinute {
    func format(era: Template<Era>? = nil,
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

public extension Absolute where Smallest: LTOESecond {
    func format(era: Template<Era>? = nil,
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

public extension Absolute where Smallest: LTOENanosecond {
    func format(era: Template<Era>? = nil,
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
