//
//  ValueFields.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

/// Access the one-unit absolute values

public extension Value where Largest == Era {
    var era: Int { return dateComponents.era.unwrap("An EraField must have an era value") }
}

public extension Value where Smallest: LTOEYear, Largest: GTOEEra {
    var year: Int { return dateComponents.year.unwrap("A YearField must have a year value") }
}

/// Access the one-unit relative values

public extension Value where Smallest: LTOEMonth, Largest: GTOEMonth {
    var relativeMonth: Value<Month, Month> { return Value<Month, Month>(region: region, dateComponents: dateComponents) }
    var month: Int { return dateComponents.month.unwrap("A MonthField must have a month value") }
}

public extension Value where Smallest: LTOEDay, Largest: GTOEDay {
    var relativeDay: Value<Day, Day> { return Value<Day, Day>(region: region, dateComponents: dateComponents) }
    var day: Int { return dateComponents.day.unwrap("A DayField must have a day value") }
}

public extension Value where Smallest: LTOEHour, Largest: GTOEHour {
    var relativeHour: Value<Hour, Hour> { return Value<Hour, Hour>(region: region, dateComponents: dateComponents) }
    var hour: Int { return dateComponents.hour.unwrap("An HourField must have an hour value") }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEMinute {
    var relativeMinute: Value<Minute, Minute> { return Value<Minute, Minute>(region: region, dateComponents: dateComponents) }
    var minute: Int { return dateComponents.minute.unwrap("A MinuteField must have a minute value") }
}

public extension Value where Smallest: LTOESecond, Largest: GTOESecond {
    var relativeSecond: Value<Second, Second> { return Value<Second, Second>(region: region, dateComponents: dateComponents) }
    var second: Int { return dateComponents.second.unwrap("A SecondField must have a second value") }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOENanosecond {
    var relativeNanosecond: Value<Nanosecond, Nanosecond> { return Value<Nanosecond, Nanosecond>(region: region, dateComponents: dateComponents) }
    var nanosecond: Int { return dateComponents.nanosecond.unwrap("A NanosecondField must have a nanosecond value") }
}



public extension Value where Smallest: LTOEDay, Largest: GTOEMonth {
    var relativeMonthDay: Value<Day, Month> { return Value<Day, Month>(region: region, dateComponents: dateComponents) }
}

public extension Value where Smallest: LTOEHour, Largest: GTOEMonth {
    var relativeMonthDayHour: Value<Hour, Month> { return Value<Hour, Month>(region: region, dateComponents: dateComponents) }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEMonth {
    var relativeMonthDayHourMinute: Value<Minute, Month> { return Value<Minute, Month>(region: region, dateComponents: dateComponents) }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEMonth {
    var relativeMonthDayHourMinuteSecond: Value<Second, Month> { return Value<Second, Month>(region: region, dateComponents: dateComponents) }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEMonth {
    var relativeMonthDayHourMinuteSecondNanosecond: Value<Nanosecond, Month> { return Value<Nanosecond, Month>(region: region, dateComponents: dateComponents) }
}


public extension Value where Smallest: LTOEHour, Largest: GTOEDay {
    var relativeDayHour: Value<Hour, Day> { return Value<Hour, Day>(region: region, dateComponents: dateComponents) }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEDay {
    var relativeDayHourMinute: Value<Minute, Day> { return Value<Minute, Day>(region: region, dateComponents: dateComponents) }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEDay {
    var relativeDayHourMinuteSecond: Value<Second, Day> { return Value<Second, Day>(region: region, dateComponents: dateComponents) }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEDay {
    var relativeDayHourMinuteSecondNanosecond: Value<Nanosecond, Day> { return Value<Nanosecond, Day>(region: region, dateComponents: dateComponents) }
}


public extension Value where Smallest: LTOEMinute, Largest: GTOEHour {
    var relativeHourMinute: Value<Minute, Hour> { return Value<Minute, Hour>(region: region, dateComponents: dateComponents) }
}

public extension Value where Smallest: LTOESecond, Largest: GTOEHour {
    var relativeHourMinuteSecond: Value<Second, Hour> { return Value<Second, Hour>(region: region, dateComponents: dateComponents) }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEHour {
    var relativeHourMinuteSecondNanosecond: Value<Nanosecond, Hour> { return Value<Nanosecond, Hour>(region: region, dateComponents: dateComponents) }
}


public extension Value where Smallest: LTOESecond, Largest: GTOEMinute {
    var relativeMinuteSecond: Value<Second, Minute> { return Value<Second, Minute>(region: region, dateComponents: dateComponents) }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEMinute {
    var relativeMinuteSecondNanosecond: Value<Nanosecond, Minute> { return Value<Nanosecond, Minute>(region: region, dateComponents: dateComponents) }
}


public extension Value where Smallest: LTOENanosecond, Largest: GTOESecond {
    var relativeSecondNanosecond: Value<Nanosecond, Second> { return Value<Nanosecond, Second>(region: region, dateComponents: dateComponents) }
}

