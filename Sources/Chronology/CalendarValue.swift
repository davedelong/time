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
    init(region: Region, dateComponents: DateComponents)
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
    
    internal init(date: Date, region: Region) {
        let dc = region.calendar.dateComponents(in: region.timeZone, from: date)
        self.init(region: region, dateComponents: dc.requireAndRestrict(to: Self.representedComponents))
    }
    
    internal init(instant: Instant, region: Region) {
        self.init(date: instant.date, region: region)
    }
    
}

/// Access individual field values

public extension CalendarValue where Self: EraField {
    var eraValue: Int { return dateComponents.era.unwrap("An EraField must have an era value") }
}

public extension CalendarValue where Self: YearField {
    var year: Year { return Year(region: region, dateComponents: dateComponents) }
    var yearValue: Int { return dateComponents.year.unwrap("A YearField must have a year value") }
}

public extension CalendarValue where Self: MonthField {
    var month: Month { return Month(region: region, dateComponents: dateComponents) }
    var monthValue: Int { return dateComponents.month.unwrap("A MonthField must have a month value") }
}

public extension CalendarValue where Self: DayField {
    var day: Day { return Day(region: region, dateComponents: dateComponents) }
    var dayValue: Int { return dateComponents.day.unwrap("A DayField must have a day value") }
}

public extension CalendarValue where Self: HourField {
    var hour: Hour { return Hour(region: region, dateComponents: dateComponents) }
    var hourValue: Int { return dateComponents.hour.unwrap("An HourField must have an hour value") }
}

public extension CalendarValue where Self: MinuteField {
    var minute: Minute { return Minute(region: region, dateComponents: dateComponents) }
    var minuteValue: Int { return dateComponents.minute.unwrap("A MinuteField must have a minute value") }
}

public extension CalendarValue where Self: SecondField {
    var second: Second { return Second(region: region, dateComponents: dateComponents) }
    var secondValue: Int { return dateComponents.second.unwrap("A SecondField must have a second value") }
}

public extension CalendarValue where Self: NanosecondField {
    var nanosecond: Nanosecond { return Nanosecond(region: region, dateComponents: dateComponents) }
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
    var era: Era { return Era(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: MonthField, Self: Anchored {
    var year: Year { return Year(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayField, Self: Anchored {
    var yearMonth: YearMonth { return YearMonth(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: HourField, Self: Anchored {
    var yearMonthDay: YearMonthDay { return YearMonthDay(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: MinuteField, Self: Anchored {
    var yearMonthDayHour: YearMonthDayHour { return YearMonthDayHour(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: SecondField, Self: Anchored {
    var yearMonthDayHourMinute: YearMonthDayHourMinute { return YearMonthDayHourMinute(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: NanosecondField, Self: Anchored {
    var yearMonthDayHourMinuteSecond: YearMonthDayHourMinuteSecond { return YearMonthDayHourMinuteSecond(region: region, dateComponents: dateComponents)}
}

/// Access the two-unit floating values

public extension CalendarValue where Self: MonthField, Self: DayField {
    var monthDay: MonthDay { return MonthDay(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayField, Self: HourField {
    var dayHour: DayHour { return DayHour(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: HourField, Self: MinuteField {
    var hourMinute: HourMinute { return HourMinute(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: MinuteField, Self: SecondField {
    var minuteSecond: MinuteSecond { return MinuteSecond(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: SecondField, Self: NanosecondField {
    var secondNanosecond: SecondNanosecond { return SecondNanosecond(region: region, dateComponents: dateComponents) }
}

/// Access the three-unit floating values

public extension CalendarValue where Self: MonthField, Self: DayField, Self: HourField {
    var monthDayHour: MonthDayHour { return MonthDayHour(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayField, Self: HourField, Self: MinuteField {
    var dayHourMinute: DayHourMinute { return DayHourMinute(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: HourField, Self: MinuteField, Self: SecondField {
    var hourMinuteSecond: HourMinuteSecond { return HourMinuteSecond(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: MinuteField, Self: SecondField, Self: NanosecondField {
    var minuteSecondNanosecond: MinuteSecondNanosecond { return MinuteSecondNanosecond(region: region, dateComponents: dateComponents) }
}

/// Access the four-unit floating values

public extension CalendarValue where Self: MonthField, Self: DayField, Self: HourField, Self: MinuteField {
    var monthDayHourMinute: MonthDayHourMinute { return MonthDayHourMinute(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayField, Self: HourField, Self: MinuteField, Self: SecondField {
    var dayHourMinuteSecond: DayHourMinuteSecond { return DayHourMinuteSecond(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: HourField, Self: MinuteField, Self: SecondField, Self: NanosecondField {
    var hourMinuteSecondNanosecond: HourMinuteSecondNanosecond { return HourMinuteSecondNanosecond(region: region, dateComponents: dateComponents) }
}

/// Access the five- and six-unit floating values

public extension CalendarValue where Self: MonthField, Self: DayField, Self: HourField, Self: MinuteField, Self: SecondField {
    var monthDayHourMinuteSecond: MonthDayHourMinuteSecond { return MonthDayHourMinuteSecond(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayField, Self: HourField, Self: MinuteField, Self: SecondField, Self: NanosecondField {
    var dayHourMinuteSecondNanosecond: DayHourMinuteSecondNanosecond { return DayHourMinuteSecondNanosecond(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: MonthField, Self: DayField, Self: HourField, Self: MinuteField, Self: SecondField, Self: NanosecondField {
    var monthDayHourMinuteSecondNanosecond: MonthDayHourMinuteSecondNanosecond { return MonthDayHourMinuteSecondNanosecond(region: region, dateComponents: dateComponents) }
}

