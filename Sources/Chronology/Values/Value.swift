//
//  Value.swift
//  
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

public typealias Absolute<U: Unit> = Value<U, Era>

public struct Value<Smallest: Unit, Largest: Unit> {
    
    internal static func restrict(dateComponents: DateComponents, file: StaticString = #file, line: UInt = #line, function: StaticString = #function) -> DateComponents {
        return dateComponents.requireAndRestrict(to: representedComponents,
                                                 file: file, line: line, function: function)
    }
    
    public static var representedComponents: Set<Calendar.Component> {
        return componentsFrom(lower: Smallest.self, to: Largest.self)
    }
        
    public let region: Region
    
    public var representedComponents: Set<Calendar.Component> {
        return Value<Smallest, Largest>.representedComponents
    }
    
    internal let dateComponents: DateComponents
    
    public var calendar: Calendar { return region.calendar }
    public var timeZone: TimeZone { return region.timeZone }
    public var locale: Locale { return region.locale }
    
    internal init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = Value.restrict(dateComponents: dateComponents)
    }
    
    internal func subComponents<S: Unit, L: Unit>() -> Value<S, L> {
        return Value<S, L>.init(region: region, dateComponents: dateComponents)
    }
}

// absolute conversion
extension Value where Largest: GTOEEra {
    
    public func converting(to newRegion: Region) -> Self {
        if newRegion == self.region { return self }
        
        if newRegion.calendar != region.calendar || newRegion.timeZone != region.timeZone {
            // changing calendar or timezone means generating new date components
            return Self.init(region: newRegion, instant: approximateMidPoint)
        } else {
            // changing locale does not affect the underlying date components
            return Self.init(region: newRegion, dateComponents: dateComponents)
        }
    }
    
    public func converting(to calendar: Calendar) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.converting(to: newRegion)
    }
    
    public func converting(to timeZone: TimeZone) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.converting(to: newRegion)
    }
    
    public func converting(to locale: Locale) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.converting(to: newRegion)
    }
    
}
