//
//  RelativeFormatting-4Units.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension Value where Smallest: LTOEHour, Largest: GTOEYear {
    func format(year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, day, hour, timeZone])
    }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEMonth {
    func format(month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, day, hour, minute, timeZone])
    }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEDay {
    func format(day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([day, hour, minute, second, timeZone])
    }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEHour {
    func format(hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([hour, minute, second, nanosecond, timeZone])
    }
}
