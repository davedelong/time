//
//  RelativeFormatting.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension CalendarValue where Smallest: LTOEYear, Largest: GTOEYear {
    func format(year: Template<Year>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [year, timeZone])
    }
}

public extension CalendarValue where Smallest: LTOEMonth, Largest: GTOEMonth {
    func format(month: Template<Standalone<Month>>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [month, timeZone])
    }
}

public extension CalendarValue where Smallest: LTOEDay, Largest: GTOEDay {
    func format(day: Template<Day>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [day, timeZone])
    }
    func format(weekday: Template<Standalone<Weekday>>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [weekday, timeZone])
    }
}

public extension CalendarValue where Smallest: LTOEHour, Largest: GTOEHour {
    func format(hour: Template<Hour>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [hour, timeZone])
    }
}

public extension CalendarValue where Smallest: LTOEMinute, Largest: GTOEMinute {
    func format(minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [minute, timeZone])
    }
}

public extension CalendarValue where Smallest: LTOESecond, Largest: GTOESecond {
    func format(second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [second, timeZone])
    }
}

public extension CalendarValue where Smallest: LTOENanosecond, Largest: GTOENanosecond {
    func format(nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [nanosecond, timeZone])
    }
}
