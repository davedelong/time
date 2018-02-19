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

internal protocol DateComponentsInitializable: CalendarValue {
    init(region: Region, dateComponents: DateComponents)
}

extension DateComponentsInitializable {
    
    init(dateComponents: DateComponents, region: Region) {
        self.init(region: region, dateComponents: dateComponents.requireAndRestrict(to: Self.representedComponents))
    }
    
    init(instant: Instant, region: Region) {
        let components = Self.representedComponents
        let date = Date(timeIntervalSinceReferenceDate: instant.intervalSinceReferenceEpoch.value)
        let dateComponents = region.calendar.dateComponents(components, from: date)
        self.init(dateComponents: dateComponents, region: region)
    }
    
}
