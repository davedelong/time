//
//  TimePeriod+RelativeFields.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public extension Value where Smallest: LTOEMonth, Largest: GTOEMonth {
    var relativeMonth: Value<Month, Month> { return subComponents() }
}

public extension Value where Smallest: LTOEDay, Largest: GTOEMonth {
    var relativeMonthDay: Value<Day, Month> { return subComponents() }
}

public extension Value where Smallest: LTOEHour, Largest: GTOEMonth {
    var relativeMonthDayHour: Value<Hour, Month> { return subComponents() }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEMonth {
    var relativeMonthDayHourMinute: Value<Minute, Month> { return subComponents() }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEMonth {
    var relativeMonthDayHourMinuteSecond: Value<Second, Month> { return subComponents() }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEMonth {
    var relativeMonthDayHourMinuteSecondNanosecond: Value<Nanosecond, Month> { return subComponents() }
}


public extension Value where Smallest: LTOEDay, Largest: GTOEDay {
    var relativeDay: Value<Day, Day> { return subComponents() }
}

public extension Value where Smallest: LTOEHour, Largest: GTOEDay {
    var relativeDayHour: Value<Hour, Day> { return subComponents() }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEDay {
    var relativeDayHourMinute: Value<Minute, Day> { return subComponents() }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEDay {
    var relativeDayHourMinuteSecond: Value<Second, Day> { return subComponents() }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEDay {
    var relativeDayHourMinuteSecondNanosecond: Value<Nanosecond, Day> { return subComponents() }
}


public extension Value where Smallest: LTOEHour, Largest: GTOEHour {
    var relativeHour: Value<Hour, Hour> { return subComponents() }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEHour {
    var relativeHourMinute: Value<Minute, Hour> { return subComponents() }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEHour {
    var relativeHourMinuteSecond: Value<Second, Hour> { return subComponents() }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEHour {
    var relativeHourMinuteSecondNanosecond: Value<Nanosecond, Hour> { return subComponents() }
}


public extension Value where Smallest: LTOEMinute, Largest: GTOEMinute {
    var relativeMinute: Value<Minute, Minute> { return subComponents() }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEMinute {
    var relativeMinuteSecond: Value<Second, Minute> { return subComponents() }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEMinute {
    var relativeMinuteSecondNanosecond: Value<Nanosecond, Minute> { return subComponents() }
}


public extension Value where Smallest: LTOESecond, Largest: GTOESecond {
    var relativeSecond: Value<Second, Second> { return subComponents() }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOESecond {
    var relativeSecondNanosecond: Value<Nanosecond, Second> { return subComponents() }
}


public extension Value where Smallest: LTOENanosecond, Largest: GTOENanosecond {
    var relativeNanosecond: Value<Nanosecond, Nanosecond> { return subComponents() }
}
