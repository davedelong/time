//
//  DateComponentsField.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol CalendarValue {
    static var representedComponents: Set<Calendar.Component> { get }
    var region: Region { get }
    var dateComponents: DateComponents { get }
}

public extension CalendarValue {
    
    public static var smalledRepresentedComponent: Calendar.Component {
        let order: Array<Calendar.Component> = [.nanosecond, .second, .minute, .hour, .day, .month, .year, .era]
        let represented = self.representedComponents
        for c in order {
            if represented.contains(c) { return c }
        }
        fatalError("\(Self.self) defines impossible represented units: \(represented)")
    }
    
    public var calendar: Calendar { return region.calendar }
    public var timeZone: TimeZone { return region.timeZone }
    public var locale: Locale { return region.locale }
    
}

/// Access individual field values

public extension CalendarValue where Self: EraField {
    var eraValue: Int { return dateComponents.era.unwrap("An EraField must have an era value") }
}

public extension CalendarValue where Self: YearField {
    var year: Year { return Year(dateComponents: dateComponents, region: region) }
    var yearValue: Int { return dateComponents.year.unwrap("A YearField must have a year value") }
}

public extension CalendarValue where Self: MonthField {
    var month: Month { return Month(dateComponents: dateComponents, region: region) }
    var monthValue: Int { return dateComponents.month.unwrap("A MonthField must have a month value") }
}

public extension CalendarValue where Self: DayField {
    var day: Day { return Day(dateComponents: dateComponents, region: region) }
    var dayValue: Int { return dateComponents.day.unwrap("A DayField must have a day value") }
}

public extension CalendarValue where Self: HourField {
    var hour: Hour { return Hour(dateComponents: dateComponents, region: region) }
    var hourValue: Int { return dateComponents.hour.unwrap("An HourField must have an hour value") }
}

public extension CalendarValue where Self: MinuteField {
    var minute: Minute { return Minute(dateComponents: dateComponents, region: region) }
    var minuteValue: Int { return dateComponents.minute.unwrap("A MinuteField must have a minute value") }
}

public extension CalendarValue where Self: SecondField {
    var second: Second { return Second(dateComponents: dateComponents, region: region) }
    var secondValue: Int { return dateComponents.second.unwrap("A SecondField must have a second value") }
}

public extension CalendarValue where Self: NanosecondField {
    var nanosecond: Nanosecond { return Nanosecond(dateComponents: dateComponents, region: region) }
    var nanosecondValue: Int { return dateComponents.nanosecond.unwrap("A NanosecondField must have a nanosecond value") }
}

/// Provide the range for Anchored values

public extension CalendarValue where Self: Anchored {
    var range: ClosedRange<Instant> {
        let date = calendar.date(from: dateComponents).unwrap("Anchored values must always be convertible to a concrete NSDate")
        let unit = type(of: self).smalledRepresentedComponent
        
        var start = Date()
        var length: TimeInterval = 0
        let succeeded = calendar.dateInterval(of: unit, start: &start, interval: &length, for: date)
        require(succeeded, "We should always be able to get the range of a calendar component")
        
        let startInsant = Instant(date: start)
        let endInstant = Instant(date: start.addingTimeInterval(length))
        return startInsant...endInstant
    }
}

/// Access the less-precise fields on Anchored values

public extension CalendarValue where Self: YearField, Self: Anchored {
    var era: Era { return Era(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: MonthField, Self: Anchored {
    var year: Year { return Year(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: DayField, Self: Anchored {
    var yearMonth: YearMonth { return YearMonth(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: HourField, Self: Anchored {
    var yearMonthDay: YearMonthDay { return YearMonthDay(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: MinuteField, Self: Anchored {
    var yearMonthDayHour: YearMonthDayHour { return YearMonthDayHour(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: SecondField, Self: Anchored {
    var yearMonthDayHourMinute: YearMonthDayHourMinute { return YearMonthDayHourMinute(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: NanosecondField, Self: Anchored {
    var yearMonthDayHourMinuteSecond: YearMonthDayHourMinuteSecond { return YearMonthDayHourMinuteSecond(dateComponents: dateComponents, region: region)}
}

/// Access the two-unit floating values

public extension CalendarValue where Self: MonthField, Self: DayField {
    var monthDay: MonthDay { return MonthDay(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: DayField, Self: HourField {
    var dayHour: DayHour { return DayHour(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: HourField, Self: MinuteField {
    var hourMinute: HourMinute { return HourMinute(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: MinuteField, Self: SecondField {
    var minuteSecond: MinuteSecond { return MinuteSecond(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: SecondField, Self: NanosecondField {
    var secondNanosecond: SecondNanosecond { return SecondNanosecond(dateComponents: dateComponents, region: region) }
}

/// Access the three-unit floating values

public extension CalendarValue where Self: MonthField, Self: DayField, Self: HourField {
    var monthDayHour: MonthDayHour { return MonthDayHour(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: DayField, Self: HourField, Self: MinuteField {
    var dayHourMinute: DayHourMinute { return DayHourMinute(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: HourField, Self: MinuteField, Self: SecondField {
    var hourMinuteSecond: HourMinuteSecond { return HourMinuteSecond(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: MinuteField, Self: SecondField, Self: NanosecondField {
    var minuteSecondNanosecond: MinuteSecondNanosecond { return MinuteSecondNanosecond(dateComponents: dateComponents, region: region) }
}

/// Access the four-unit floating values

public extension CalendarValue where Self: MonthField, Self: DayField, Self: HourField, Self: MinuteField {
    var monthDayHourMinute: MonthDayHourMinute { return MonthDayHourMinute(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: DayField, Self: HourField, Self: MinuteField, Self: SecondField {
    var dayHourMinuteSecond: DayHourMinuteSecond { return DayHourMinuteSecond(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: HourField, Self: MinuteField, Self: SecondField, Self: NanosecondField {
    var hourMinuteSecondNanosecond: HourMinuteSecondNanosecond { return HourMinuteSecondNanosecond(dateComponents: dateComponents, region: region) }
}

/// Access the five- and six-unit floating values

public extension CalendarValue where Self: MonthField, Self: DayField, Self: HourField, Self: MinuteField, Self: SecondField {
    var monthDayHourMinuteSecond: MonthDayHourMinuteSecond { return MonthDayHourMinuteSecond(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: DayField, Self: HourField, Self: MinuteField, Self: SecondField, Self: NanosecondField {
    var dayHourMinuteSecondNanosecond: DayHourMinuteSecondNanosecond { return DayHourMinuteSecondNanosecond(dateComponents: dateComponents, region: region) }
}

public extension CalendarValue where Self: MonthField, Self: DayField, Self: HourField, Self: MinuteField, Self: SecondField, Self: NanosecondField {
    var monthDayHourMinuteSecondNanosecond: MonthDayHourMinuteSecondNanosecond { return MonthDayHourMinuteSecondNanosecond(dateComponents: dateComponents, region: region) }
}

