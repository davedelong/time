//
//  Value.swift
//  
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

/// A typealias representing a single calendrical value.
///
/// An `Absolute<U>` is a type that corresponds to one (and only one) value
/// on a physical calendar. For example, there is only one "October 2019 CE"
/// on the Gregorian calendar.
///
/// By contrast, a non-absolute `Value` (eg: "October") can represent *many*
/// possible values on a physical calendar (October 2019, October 2020, etc).
///
/// The defining characteristic of `Absolute<U>` values is that they contain
/// all calendar components starting from their lower unit up-to-and-including
/// the `Era` unit.
public typealias Absolute<U: Unit> = Value<U, Era>


/// `Value` is the fundamental type used to represent a calendrical value.
///
/// `Value` has two generic parameters, called `Smallest` and `Largest`. These
/// generic types are used to define the upper and lower bounds of the units
/// represented by the value.
///
/// For example, a `Value<Second, Hour>` contains components for seconds, minutes,
/// and hours. A `Value<Minute, Minute>` contains only a minute components. While it
/// is technically possible to define a `Value<Hour, Second>`, it is impossible
/// to actually construct one, as it would contain no underlying component values.
///
/// All `Values` have a `Region`, which defines the calendar, timezone, and
/// locale used in computing the underlying component values.
public struct Value<Smallest: Unit, Largest: Unit> {
    
    internal static func restrict(dateComponents: DateComponents) throws -> DateComponents {
        return try dateComponents.requireAndRestrict(to: representedComponents)
    }
    
    public static var representedComponents: Set<Calendar.Component> {
        return componentsFrom(lower: Smallest.self, to: Largest.self)
    }
        
    /// The `Region` value used in computing this `Value`'s components.
    public let region: Region
    
    /// The set of calendar components represented by this `Value`.
    public var representedComponents: Set<Calendar.Component> {
        return Value<Smallest, Largest>.representedComponents
    }
    
    internal let dateComponents: DateComponents
    
    /// The `Calendar` used in computing this `Value`'s components.
    public var calendar: Calendar { return region.calendar }
    
    /// The `TimeZone` used in computing this `Value`'s components.
    public var timeZone: TimeZone { return region.timeZone }
    
    /// The `Locale` used in computing this `Value`'s components.
    public var locale: Locale { return region.locale }
    
    internal init(region: Region, dateComponents: DateComponents) throws {
        self.region = region
        self.dateComponents = try Value.restrict(dateComponents: dateComponents)
    }
    
    internal func subComponents<S: Unit, L: Unit>() -> Value<S, L> {
        return try! Value<S, L>.init(region: region, dateComponents: dateComponents)
    }
}

// absolute conversion
extension Value where Largest: GTOEEra {
    
    /// Construct a new `Value` by converting the receiver to a new `Region`.
    public func converting(to newRegion: Region) -> Self {
        if newRegion == self.region { return self }
        
        if newRegion.calendar != region.calendar || newRegion.timeZone != region.timeZone {
            // changing calendar or timezone means generating new date components
            return Self.init(region: newRegion, instant: approximateMidPoint)
        } else {
            // changing locale does not affect the underlying date components
            return try! Self.init(region: newRegion, dateComponents: dateComponents)
        }
    }
    
    /// Construct a new `Value` by converting the receiver to a new `Calendar`.
    public func converting(to calendar: Calendar) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.converting(to: newRegion)
    }
    
    /// Construct a new `Value` by converting the receiver to a new `TimeZone`.
    public func converting(to timeZone: TimeZone) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.converting(to: newRegion)
    }
    
    /// Construct a new `Value` by converting the receiver to a new `Locale`.
    public func converting(to locale: Locale) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.converting(to: newRegion)
    }
    
}
