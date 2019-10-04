//
//  DateComponentsField.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol CalendarValue: Field {
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
