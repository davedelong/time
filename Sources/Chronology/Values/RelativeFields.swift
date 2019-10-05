//
//  RelativeFields.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

/// Access the one-unit absolute values

public extension CalendarValue where Largest == Era {
    var era: Int { return dateComponents.era.unwrap("An EraField must have an era value") }
}

public extension CalendarValue where Smallest: LTOEYear, Largest: GTOEEra {
    var year: Int { return dateComponents.year.unwrap("A YearField must have a year value") }
}

/// Access the one-unit relative values

public extension CalendarValue where Smallest: LTOEMonth, Largest: GTOEMonth {
    var relativeMonth: Relative<Month, Month> { return Relative(region: region, dateComponents: dateComponents) }
    var month: Int { return dateComponents.month.unwrap("A MonthField must have a month value") }
}

public extension CalendarValue where Smallest: LTOEDay, Largest: GTOEDay {
    var relativeDay: Relative<Day, Day> { return Relative(region: region, dateComponents: dateComponents) }
    var day: Int { return dateComponents.day.unwrap("A DayField must have a day value") }
}

public extension CalendarValue where Smallest: LTOEHour, Largest: GTOEHour {
    var relativeHour: Relative<Hour, Hour> { return Relative(region: region, dateComponents: dateComponents) }
    var hour: Int { return dateComponents.hour.unwrap("An HourField must have an hour value") }
}

public extension CalendarValue where Smallest: LTOEMinute, Largest: GTOEMinute {
    var relativeMinute: Relative<Minute, Minute> { return Relative(region: region, dateComponents: dateComponents) }
    var minute: Int { return dateComponents.minute.unwrap("A MinuteField must have a minute value") }
}

public extension CalendarValue where Smallest: LTOESecond, Largest: GTOESecond {
    var relativeSecond: Relative<Second, Second> { return Relative(region: region, dateComponents: dateComponents) }
    var second: Int { return dateComponents.second.unwrap("A SecondField must have a second value") }
}

public extension CalendarValue where Smallest: LTOENanosecond, Largest: GTOENanosecond {
    var relativeNanosecond: Relative<Nanosecond, Nanosecond> { return Relative(region: region, dateComponents: dateComponents) }
    var nanosecond: Int { return dateComponents.nanosecond.unwrap("A NanosecondField must have a nanosecond value") }
}



public extension CalendarValue where Smallest: LTOEDay, Largest: GTOEMonth {
    var relativeMonthDay: Relative<Day, Month> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Smallest: LTOEHour, Largest: GTOEMonth {
    var relativeMonthDayHour: Relative<Hour, Month> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Smallest: LTOEMinute, Largest: GTOEMonth {
    var relativeMonthDayHourMinute: Relative<Minute, Month> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Smallest: LTOESecond, Largest: GTOEMonth {
    var relativeMonthDayHourMinuteSecond: Relative<Second, Month> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Smallest: LTOENanosecond, Largest: GTOEMonth {
    var relativeMonthDayHourMinuteSecondNanosecond: Relative<Nanosecond, Month> { return Relative(region: region, dateComponents: dateComponents) }
}


public extension CalendarValue where Smallest: LTOEHour, Largest: GTOEDay {
    var relativeDayHour: Relative<Hour, Day> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Smallest: LTOEMinute, Largest: GTOEDay {
    var relativeDayHourMinute: Relative<Minute, Day> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Smallest: LTOESecond, Largest: GTOEDay {
    var relativeDayHourMinuteSecond: Relative<Second, Day> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Smallest: LTOENanosecond, Largest: GTOEDay {
    var relativeDayHourMinuteSecondNanosecond: Relative<Nanosecond, Day> { return Relative(region: region, dateComponents: dateComponents) }
}


public extension CalendarValue where Smallest: LTOEMinute, Largest: GTOEHour {
    var relativeHourMinute: Relative<Minute, Hour> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Smallest: LTOESecond, Largest: GTOEHour {
    var relativeHourMinuteSecond: Relative<Second, Hour> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Smallest: LTOENanosecond, Largest: GTOEHour {
    var relativeHourMinuteSecondNanosecond: Relative<Nanosecond, Hour> { return Relative(region: region, dateComponents: dateComponents) }
}


public extension CalendarValue where Smallest: LTOESecond, Largest: GTOEMinute {
    var relativeMinuteSecond: Relative<Second, Minute> { return Relative(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Smallest: LTOENanosecond, Largest: GTOEMinute {
    var relativeMinuteSecondNanosecond: Relative<Nanosecond, Minute> { return Relative(region: region, dateComponents: dateComponents) }
}


public extension CalendarValue where Smallest: LTOENanosecond, Largest: GTOESecond {
    var relativeSecondNanosecond: Relative<Nanosecond, Second> { return Relative(region: region, dateComponents: dateComponents) }
}

