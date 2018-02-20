//
//  CalendarFields.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol Anchored {
    var range: ClosedRange<Instant> { get }
}

public protocol CalendarValueField { }

public protocol EraField: CalendarValueField {
    var eraValue: Int { get }
}

public protocol YearField: CalendarValueField {
    var yearValue: Int { get }
}

public protocol MonthField: CalendarValueField {
    var monthValue: Int { get }
}

public protocol DayField: CalendarValueField {
    var dayValue: Int { get }
}

public protocol HourField: CalendarValueField {
    var hourValue: Int { get }
}

public protocol MinuteField: CalendarValueField {
    var minuteValue: Int { get }
}

public protocol SecondField: CalendarValueField {
    var secondValue: Int { get }
}

public protocol NanosecondField: CalendarValueField {
    var nanosecondValue: Int { get }
}
