//
//  RelativeFormatting-3Units.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension CalendarValue where Smallest: LTOEDay, Largest: GTOEYear {
    func format(year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [year, month, day, timeZone])
    }
}

public extension CalendarValue where Smallest: LTOEHour, Largest: GTOEMonth {
    func format(month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [month, day, hour, timeZone])
    }
}

public extension CalendarValue where Smallest: LTOEMinute, Largest: GTOEDay {
    func format(day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [day, hour, minute, timeZone])
    }
}

public extension CalendarValue where Smallest: LTOESecond, Largest: GTOEHour {
    func format(hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [hour, minute, second, timeZone])
    }
}

public extension CalendarValue where Smallest: LTOENanosecond, Largest: GTOEMinute {
    func format(minute:Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [minute, second, nanosecond, timeZone])
    }
}
