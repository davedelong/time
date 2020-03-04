//
//  RelativeFormatting-3Units.swift
//  Time
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension Value where Smallest: LTOEDay, Largest: GTOEYear {
    func format(year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, day, timeZone])
    }
}

public extension Value where Smallest: LTOEHour, Largest: GTOEMonth {
    func format(month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, day, hour, timeZone])
    }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEDay {
    func format(day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([day, hour, minute, timeZone])
    }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEHour {
    func format(hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([hour, minute, second, timeZone])
    }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEMinute {
    func format(minute:Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([minute, second, nanosecond, timeZone])
    }
}
