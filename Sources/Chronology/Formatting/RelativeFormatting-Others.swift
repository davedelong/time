//
//  RelativeFormatting-Others.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

public extension Value where Smallest: LTOEMinute, Largest: GTOEYear {
    func format(year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [year, month, day, hour, minute, timeZone])
    }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEMonth {
    func format(month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [month, day, hour, minute, second, timeZone])
    }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEDay {
    func format(day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [day, hour, minute, second, nanosecond, timeZone])
    }
}


public extension Value where Smallest: LTOESecond, Largest: GTOEYear {
    func format(year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [year, month, day, hour, minute, second, timeZone])
    }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEMonth {
    func format(month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [month, day, hour, minute, second, nanosecond, timeZone])
    }
}


public extension Value where Smallest: LTOENanosecond, Largest: GTOEYear {
    func format(year: Template<Year>,
                month: Template<Month>,
                day: Template<Day>,
                hour: Template<Hour>,
                minute: Template<Minute>,
                second: Template<Second>,
                nanosecond: Template<Nanosecond>,
                timeZone: Template<TimeZone>? = nil) -> String {
        return format(relative: [year, month, day, hour, minute, second, nanosecond, timeZone])
    }
}
