//
//  DateComponentsField.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol CalendarValue {
    associatedtype Smallest: Unit
    associatedtype Largest: Unit
        
    var region: Region { get }
    var dateComponents: DateComponents { get }
    
    init(region: Region, dateComponents: DateComponents)
}

internal extension CalendarValue {
    
    static func restrict(dateComponents: DateComponents, file: StaticString = #file, line: UInt = #line, function: StaticString = #function) -> DateComponents {
        return dateComponents.requireAndRestrict(to: representedComponents,
                                                 file: file, line: line, function: function)
    }
    
}

extension CalendarValue {
    
    public static var representedComponents: Set<Calendar.Component> {
        return componentsFrom(lower: Smallest.self, to: Largest.self)
    }
    
    public var calendar: Calendar { return region.calendar }
    public var timeZone: TimeZone { return region.timeZone }
    public var locale: Locale { return region.locale }
    
    public func convert(to region: Region) -> Self {
        return Self.init(region: region, dateComponents: dateComponents)
    }
}

extension CalendarValue {
    
    public func convert(to calendar: Calendar) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.convert(to: newRegion)
    }
    
    public func convert(to timeZone: TimeZone) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.convert(to: newRegion)
    }
    
    public func convert(to locale: Locale) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.convert(to: newRegion)
    }
    
}
