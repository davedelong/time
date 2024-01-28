//
//  Fixed.swift
//
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

/// An `Fixed<U>` is a type that corresponds to one (and only one) value
/// on a physical calendar. For example, there is only one "October 2019 CE"
/// on the Gregorian calendar.
///
/// The defining characteristic of `Fixed<U>` values is that they contain
/// all calendar components starting from their lower unit up-to-and-including
/// the `Era` unit.
///
/// All `Fixed` values have a `Region`, which defines the calendar, timezone, and
/// locale used in computing the underlying component values.
public struct Fixed<Smallest: Unit & LTOEEra> {
    
    internal static func restrict(dateComponents: DateComponents, lenient: Set<Calendar.Component>) throws -> DateComponents {
        return try dateComponents.requireAndRestrict(to: representedComponents, lenient: lenient)
    }
    
    /// The set of `Calendar.Components` represented by this particular `Fixed` value
    public static var representedComponents: Set<Calendar.Component> {
        return Calendar.Component.from(lower: Smallest.self, to: Era.self)
    }
        
    /// The `Region` value used in computing this `Fixed` value's components.
    public let region: Region
    
    internal let date: Foundation.Date
    internal let dateComponents: Foundation.DateComponents
    
    /// The set of calendar components represented by this `Fixed` value.
    public var representedComponents: Set<Calendar.Component> {
        return Self.representedComponents
    }
    
    /// The `Calendar` used in computing this `Fixed` value's components, as defined by its `Region`.
    public var calendar: Calendar { return region.calendar }
    
    /// The `TimeZone` used in computing this `Fixed` value's components, as defined by its `Region`.
    public var timeZone: TimeZone { return region.timeZone }
    
    /// The `Locale` used in computing this `Fixed` value's components, as defined by its `Region`.
    public var locale: Locale { return region.locale }
    
    /// Construct a `Fixed` value from an instantaneous point in time.
    /// - Parameter region: The `Region` in which to interpret the point in time
    /// - Parameter instant: The `Instant` that is contained by the constructed `Fixed` value
    public init(region: Region, instant: Instant) {
        self.init(region: region, date: instant.date)
    }
    
    /// Construct a `Fixed` value from an instantaneous point in time.
    /// - Parameter region: The `Region` in which to interpret the point in time
    /// - Parameter instant: The `Date` that is contained by the constructed `Fixed` value
    public init(region: Region, date: Foundation.Date) {
        self.region = region
        self.date = date
        self.dateComponents = region.calendar.dateComponents(Self.representedComponents, from: date)
    }
    
    /// Construct an absolute `Fixed` value from a set of `DateComponents`.
    ///
    /// This method is "strict" because it is fairly easy for it to produce an error.
    /// For example, if you are attempting to construct an `Fixed<Month>` but only provide
    /// a `year` value in the `DateComponents`, then this will throw a `TimeError`.
    ///
    /// If you are attempting to construct a calendrically impossible date, such as "February 30th",
    /// then this will throw a `TimeError`.
    ///
    /// The matching done on the `DateComponents` is a *strict* match; the returned `Fixed` value will
    /// either exactly match the provided components, or this will throw a `TimeError`.
    ///
    /// - Parameter region: The `Region` in which to interpret the date components
    /// - Parameter strictDateComponents: The `DateComponents` describing the desired calendrical date
    public init(region: Region, strictDateComponents: DateComponents) throws {
        let next = try region.calendar.exactDate(from: strictDateComponents, matching: Self.representedComponents)
        self.init(region: region, date: next)
    }
    
    private init(region: Region, dateComponents: DateComponents) throws {
        let refined = try dateComponents.requireAndRestrict(to: Self.representedComponents,
                                                            lenient: region.calendar.lenientUnitsForAbsoluteTimePeriods)
        
        // turn the date components into a date
        guard let date = region.calendar.date(from: refined) else {
            throw TimeError.invalidDateComponents(refined, in: region)
        }
        
        self.init(region: region, date: date)
    }
    
    internal func subComponents<S: Unit>() -> Fixed<S> {
        return try! Fixed<S>(region: region, dateComponents: dateComponents)
    }
    
    /// Construct a new `Fixed` value by converting the receiver to a new `Region`.
    public func setting(region: Region) -> Self {
        if region == self.region { return self }
        return Self.init(region: region, date: self.date)
    }
    
    /// Construct a new `Fixed` value by converting the receiver to a new `Calendar`.
    public func setting(calendar: Calendar) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.setting(region: newRegion)
    }
    
    /// Construct a new `Fixed` value by converting the receiver to a new `TimeZone`.
    public func converting(to timeZone: TimeZone) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.setting(region: newRegion)
    }
    
    /// Construct a new `Fixed` value by converting the receiver to a new `Locale`.
    public func converting(to locale: Locale) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.setting(region: newRegion)
    }
    
}

extension Fixed: Equatable {
    
    /// Determine if two `Fixed` values are equal.
    ///
    /// Two `Fixed` values are equal if they have the same `Region` and represent the same calendrical components.
    /// - Parameter lhs: a `Fixed` value
    /// - Parameter rhs: a `Fixed` value
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents == rhs.dateComponents
    }
    
}

extension Fixed: Hashable {
    
    /// Compute the hash of an`Fixed` value
    ///
    /// - Parameter hasher: a `Hasher`
    public func hash(into hasher: inout Hasher) {
        hasher.combine(region)
        hasher.combine(dateComponents)
    }
    
}

extension Fixed: Comparable {
    
    /// Determine if one `Fixed` value is greater than another `Fixed` value.
    ///
    /// A `Fixed` value is greater than another if they have the same `Region`, and the first's
    /// calendrical components come *after* the other's components.
    /// - Parameter lhs: a `Fixed` value
    /// - Parameter rhs: a `Fixed` value
    public static func > (lhs: Self, rhs: Self) -> Bool {
        guard lhs.region == rhs.region else { return false }
        let leftRange = lhs.calendar.range(containing: lhs.date, in: lhs.representedComponents)
        let rightRange = rhs.calendar.range(containing: rhs.date, in: rhs.representedComponents)
        
        return leftRange.lowerBound > rightRange.lowerBound
    }
    
    /// Determine if one `Fixed` value is less than another `Fixed` value.
    ///
    /// A `Fixed` value is less than another if they have the same `Region`, and the first's
    /// calendrical components come *before* the other's components.
    /// - Parameter lhs: a `Fixed` value
    /// - Parameter rhs: a `Fixed` value
    public static func < (lhs: Self, rhs: Self) -> Bool {
        guard lhs.region == rhs.region else { return false }
        let leftRange = lhs.calendar.range(containing: lhs.date, in: lhs.representedComponents)
        let rightRange = rhs.calendar.range(containing: rhs.date, in: rhs.representedComponents)
        
        return leftRange.lowerBound < rightRange.lowerBound
    }
    
}

extension Fixed: CustomStringConvertible {
    
    /// Provide a description of the `Fixed` value.
    ///
    /// The description is a localized "natural" formatting of the calendar value.
    public var description: String {
        let style = AbsoluteFormatStyle<Smallest>(naturalFormats: calendar)
        return format(using: style)
    }
    
}
