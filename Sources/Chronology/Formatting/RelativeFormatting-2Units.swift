//
//  RelativeFormatting-2Units.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension Value where Smallest: LTOEMonth, Largest: GTOEYear {
    func format(year: Template<Year>,
                month: Template<Month>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, timeZone])
    }
}

public extension Value where Smallest: LTOEDay, Largest: GTOEMonth {
    func format(month: Template<Month>,
                day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, day, weekday, timeZone])
    }
}

public extension Value where Smallest: LTOEHour, Largest: GTOEDay {
    func format(day: Template<Day>,
                weekday: Template<Weekday>? = nil,
                hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([day, weekday, hour, timeZone])
    }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEHour {
    func format(hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([hour, minute, timeZone])
    }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEMinute {
    func format(minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([minute, second, timeZone])
    }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOESecond {
    func format(second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([second, nanosecond, timeZone])
    }
}
