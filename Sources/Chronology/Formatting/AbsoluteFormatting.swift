//
//  Absolute.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 5/17/18.
//

import Foundation

public extension Value where Smallest: LTOEEra, Largest: GTOEEra {
    func format(era: Template<Era>) -> String {
        return format(absolute: [era])
    }
}

public extension Value where Smallest: LTOEYear, Largest: GTOEEra {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(absolute: [era, year, timeZone])
    }
}

public extension Value where Smallest: LTOEMonth, Largest: GTOEEra {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(absolute: [era, year, month, timeZone])
    }
}

public extension Value where Smallest: LTOEDay, Largest: GTOEEra {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(absolute: [era, year, month, day, weekday, timeZone])
    }
}

public extension Value where Smallest: LTOEHour, Largest: GTOEEra {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(absolute: [era, year, month, day, weekday, hour, timeZone])
    }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEEra {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(absolute: [era, year, month, day, weekday, hour, minute, timeZone])
    }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEEra {
    func format(era: Template<Era>? = nil,
                year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(absolute: [era, year, month, day, weekday, hour, minute, second, timeZone])
    }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEEra {
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
        return format(absolute: [era, year, month, day, weekday, hour, minute, second, nanosecond, timeZone])
    }
}
