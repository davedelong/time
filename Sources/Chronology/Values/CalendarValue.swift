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

internal extension Calendar.Component {
    static var order: Array<Calendar.Component> {
        return [.nanosecond, .second, .minute, .hour, .day, .month, .year, .era]
    }
}

public extension CalendarValue {
    
    static var smallestRepresentedComponent: Calendar.Component {
        let represented = self.representedComponents
        let component = Calendar.Component.order.first(where: { represented.contains($0) })
        return component.unwrap("\(Self.self) defines impossible represented units: \(represented)")
    }
    
    var calendar: Calendar { return region.calendar }
    var timeZone: TimeZone { return region.timeZone }
    var locale: Locale { return region.locale }
    
    internal init(date: Date, region: Region) {
        let dc = region.components(Self.representedComponents, from: date)
        self.init(region: region, dateComponents: dc)
    }
    
    internal init(instant: Instant, region: Region) {
        self.init(date: instant.date, region: region)
    }
    
    func convert(to region: Region) -> Self {
        return Self.init(region: region, dateComponents: dateComponents)
    }
}

public extension CalendarValue {
    
    func convert(to calendar: Calendar) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.convert(to: newRegion)
    }
    
    func convert(to timeZone: TimeZone) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.convert(to: newRegion)
    }
    
    func convert(to locale: Locale) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.convert(to: newRegion)
    }
    
}

/// Access individual field values

/*
public extension CalendarValue where Self: EraField {
    var era: Era { return Era(region: region, dateComponents: dateComponents) }
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

/// Access the two-unit relative values

public extension CalendarValue where Self: MonthField & DayField {
    var monthDay: MonthDay { return MonthDay(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: DayField & HourField {
    var dayHour: DayHour { return DayHour(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: HourField & MinuteField {
    var hourMinute: HourMinute { return HourMinute(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: MinuteField & SecondField {
    var minuteSecond: MinuteSecond { return MinuteSecond(region: region, dateComponents: dateComponents) }
}

public extension CalendarValue where Self: SecondField & NanosecondField {
    var secondNanosecond: SecondNanosecond { return SecondNanosecond(region: region, dateComponents: dateComponents) }
}
 */

