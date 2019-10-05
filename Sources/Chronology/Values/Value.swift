//
//  Value.swift
//  
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

public typealias Absolute<U: Unit> = Value<U, Era>
public typealias AbsoluteValueSequence<U: Unit> = ValueSequence<U, Era>
public typealias AbsoluteValueIterator<U: Unit> = ValueIterator<U, Era>

public struct Value<Smallest: Unit, Largest: Unit> {
    
    internal static func restrict(dateComponents: DateComponents, file: StaticString = #file, line: UInt = #line, function: StaticString = #function) -> DateComponents {
        return dateComponents.requireAndRestrict(to: representedComponents,
                                                 file: file, line: line, function: function)
    }
    
    public static var representedComponents: Set<Calendar.Component> {
        return componentsFrom(lower: Smallest.self, to: Largest.self)
    }
        
    public let region: Region
    public let dateComponents: DateComponents
    
    public var calendar: Calendar { return region.calendar }
    public var timeZone: TimeZone { return region.timeZone }
    public var locale: Locale { return region.locale }
    
    internal init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = type(of: self).restrict(dateComponents: dateComponents)
    }
    
    internal func subComponents<S: Unit, L: Unit>() -> Value<S, L> {
        return Value<S, L>.init(region: region, dateComponents: dateComponents)
    }
}

// absolute conversion
extension Value where Largest: GTOEEra {
    
    public func convert(to region: Region) -> Self {
        return Self.init(region: region, dateComponents: dateComponents)
    }
    
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
