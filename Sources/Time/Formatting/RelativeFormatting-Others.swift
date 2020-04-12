//
//  RelativeFormatting-Others.swift
//  Time
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension TimePeriod where Smallest: LTOEDay, Largest: GTOEYear {
    func format(dateStyle: DateFormatter.Style) -> String {
        return formatUsing(dateStyle: dateStyle, timeStyle: .none)
    }
}

public extension TimePeriod where Smallest: LTOESecond, Largest: GTOEHour {
    func format(timeStyle: DateFormatter.Style) -> String {
        return formatUsing(dateStyle: .none, timeStyle: timeStyle)
    }
}

public extension TimePeriod where Smallest: LTOESecond, Largest: GTOEYear {
    func format(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        return formatUsing(dateStyle: dateStyle, timeStyle: timeStyle)
    }
}

public extension TimePeriod where Smallest: LTOEMinute, Largest: GTOEYear {
    func format(year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, day, hour, minute, timeZone])
    }
}

public extension TimePeriod where Smallest: LTOESecond, Largest: GTOEMonth {
    func format(month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, day, hour, minute, second, timeZone])
    }
}

public extension TimePeriod where Smallest: LTOENanosecond, Largest: GTOEDay {
    func format(day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([day, hour, minute, second, nanosecond, timeZone])
    }
}


public extension TimePeriod where Smallest: LTOESecond, Largest: GTOEYear {
    func format(year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, day, hour, minute, second, timeZone])
    }
}

public extension TimePeriod where Smallest: LTOENanosecond, Largest: GTOEMonth {
    func format(month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([month, day, hour, minute, second, nanosecond, timeZone])
    }
}


public extension TimePeriod where Smallest: LTOENanosecond, Largest: GTOEYear {
    func format(year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format([year, month, day, hour, minute, second, nanosecond, timeZone])
    }
}
