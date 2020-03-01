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
    
    /// The set of `Calendar.Components` represented by this particular `Value`
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
    
    /// The `Calendar` used in computing this `Value`'s components, as defined by its `Region`.
    public var calendar: Calendar { return region.calendar }
    
    /// The `TimeZone` used in computing this `Value`'s components, as defined by its `Region`.
    public var timeZone: TimeZone { return region.timeZone }
    
    /// The `Locale` used in computing this `Value`'s components, as defined by its `Region`.
    public var locale: Locale { return region.locale }
    
    internal init(region: Region, dateComponents: DateComponents) throws {
        self.region = region
        self.dateComponents = try Value.restrict(dateComponents: dateComponents)
    }
    
    internal func subComponents<S: Unit, L: Unit>() -> Value<S, L> {
        return try! Value<S, L>.init(region: region, dateComponents: dateComponents)
    }
}

extension Value: Equatable {
    
    /// Determine if two `Values` are equal.
    ///
    /// Two `Values` are equal if they have the same `Region` and represent the same calendrical components.
    /// - Parameter lhs: a `Value`
    /// - Parameter rhs: a `Value`
    public static func ==(lhs: Value, rhs: Value) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents == rhs.dateComponents
    }
    
}

extension Value: Hashable {
    
    /// Compute the hash of a `Value`
    ///
    /// - Parameter hasher: a `Hasher`
    public func hash(into hasher: inout Hasher) {
        hasher.combine(region)
        hasher.combine(dateComponents)
    }
    
}

extension Value: Comparable {
    
    /// Determine if one `Value` is greater than another `Value`.
    ///
    /// A `Value` is greater than another if they have the same `Region`, and the first's
    /// calendrical components come *after* the other's components.
    /// - Parameter lhs: a `Value`
    /// - Parameter rhs: a `Value`
    public static func > (lhs: Value, rhs: Value) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents.isGreaterThan(other: rhs.dateComponents)
    }
    
    /// Determine if one `Value` is less than another `Value`.
    ///
    /// A `Value` is less than another if they have the same `Region`, and the first's
    /// calendrical components come *before* the other's components.
    /// - Parameter lhs: a `Value`
    /// - Parameter rhs: a `Value`
    public static func < (lhs: Value, rhs: Value) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents.isLessThan(other: rhs.dateComponents)
    }
    
}

extension Value: CustomStringConvertible {
    
    /// Provide a description of the `Value`.
    ///
    /// The description is a localized "full" formatting of the calendar value.
    public var description: String {
        return formatFull()
    }
    
}
