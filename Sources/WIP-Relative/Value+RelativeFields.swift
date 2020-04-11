//
//  TimePeriod+RelativeFields.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension TimePeriod where Smallest: LTOEMonth, Largest: GTOEMonth {
    var relativeMonth: TimePeriod<Month, Month> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOEDay, Largest: GTOEMonth {
    var relativeMonthDay: TimePeriod<Day, Month> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOEHour, Largest: GTOEMonth {
    var relativeMonthDayHour: TimePeriod<Hour, Month> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOEMinute, Largest: GTOEMonth {
    var relativeMonthDayHourMinute: TimePeriod<Minute, Month> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOESecond, Largest: GTOEMonth {
    var relativeMonthDayHourMinuteSecond: TimePeriod<Second, Month> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOENanosecond, Largest: GTOEMonth {
    var relativeMonthDayHourMinuteSecondNanosecond: TimePeriod<Nanosecond, Month> { return subComponents() }
}


public extension TimePeriod where Smallest: LTOEDay, Largest: GTOEDay {
    var relativeDay: TimePeriod<Day, Day> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOEHour, Largest: GTOEDay {
    var relativeDayHour: TimePeriod<Hour, Day> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOEMinute, Largest: GTOEDay {
    var relativeDayHourMinute: TimePeriod<Minute, Day> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOESecond, Largest: GTOEDay {
    var relativeDayHourMinuteSecond: TimePeriod<Second, Day> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOENanosecond, Largest: GTOEDay {
    var relativeDayHourMinuteSecondNanosecond: TimePeriod<Nanosecond, Day> { return subComponents() }
}


public extension TimePeriod where Smallest: LTOEHour, Largest: GTOEHour {
    var relativeHour: TimePeriod<Hour, Hour> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOEMinute, Largest: GTOEHour {
    var relativeHourMinute: TimePeriod<Minute, Hour> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOESecond, Largest: GTOEHour {
    var relativeHourMinuteSecond: TimePeriod<Second, Hour> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOENanosecond, Largest: GTOEHour {
    var relativeHourMinuteSecondNanosecond: TimePeriod<Nanosecond, Hour> { return subComponents() }
}


public extension TimePeriod where Smallest: LTOEMinute, Largest: GTOEMinute {
    var relativeMinute: TimePeriod<Minute, Minute> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOESecond, Largest: GTOEMinute {
    var relativeMinuteSecond: TimePeriod<Second, Minute> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOENanosecond, Largest: GTOEMinute {
    var relativeMinuteSecondNanosecond: TimePeriod<Nanosecond, Minute> { return subComponents() }
}


public extension TimePeriod where Smallest: LTOESecond, Largest: GTOESecond {
    var relativeSecond: TimePeriod<Second, Second> { return subComponents() }
}

public extension TimePeriod where Smallest: LTOENanosecond, Largest: GTOESecond {
    var relativeSecondNanosecond: TimePeriod<Nanosecond, Second> { return subComponents() }
}


public extension TimePeriod where Smallest: LTOENanosecond, Largest: GTOENanosecond {
    var relativeNanosecond: TimePeriod<Nanosecond, Nanosecond> { return subComponents() }
}
