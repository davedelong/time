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

public protocol EraField {
    var eraValue: Int { get }
}

public protocol YearField {
    var yearValue: Int { get }
}

public protocol MonthField {
    var monthValue: Int { get }
}

public protocol DayField {
    var dayValue: Int { get }
}

public protocol HourField {
    var hourValue: Int { get }
}

public protocol MinuteField {
    var minuteValue: Int { get }
}

public protocol SecondField {
    var secondValue: Int { get }
}

public protocol NanosecondField {
    var nanosecondValue: Int { get }
}
