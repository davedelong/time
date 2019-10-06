//
//  Value+Components.swift
//  
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

public extension Value where Largest: GTOEEra {
    var era: Int { return dateComponents.era.unwrap("An EraField must have an era value") }
}

public extension Value where Smallest: LTOEYear, Largest: GTOEEra {
    var year: Int { return dateComponents.year.unwrap("A YearField must have a year value") }
}

public extension Value where Smallest: LTOEMonth, Largest: GTOEMonth {
    var month: Int { return dateComponents.month.unwrap("A MonthField must have a month value") }
}

public extension Value where Smallest: LTOEDay, Largest: GTOEDay {
    var day: Int { return dateComponents.day.unwrap("A DayField must have a day value") }
}

public extension Value where Smallest: LTOEHour, Largest: GTOEHour {
    var hour: Int { return dateComponents.hour.unwrap("An HourField must have an hour value") }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEMinute {
    var minute: Int { return dateComponents.minute.unwrap("A MinuteField must have a minute value") }
}

public extension Value where Smallest: LTOESecond, Largest: GTOESecond {
    var second: Int { return dateComponents.second.unwrap("A SecondField must have a second value") }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOENanosecond {
    var nanosecond: Int { return dateComponents.nanosecond.unwrap("A NanosecondField must have a nanosecond value") }
}
