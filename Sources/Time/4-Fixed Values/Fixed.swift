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
    
    internal let instant: Time.Instant
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
    
    /// The designated initializer for all Fixed values
    ///
    /// All initializers must funnel through this one. By the time this is called, the components should already be extracted
    internal init(region: Region, instant: Instant, components: Foundation.DateComponents) {
        self.region = region.snapshot()
        self.instant = instant
        self.dateComponents = components
    }
    
    /// Construct a `Fixed` value from an instantaneous point in time.
    /// - Parameter region: The `Region` in which to interpret the point in time
    /// - Parameter instant: The `Instant` that is contained by the constructed `Fixed` value
    public init(region: Region, instant: Instant) {
        let dateComponents = region.calendar.dateComponents(Self.representedComponents, from: instant.date)
        self.init(region: region, instant: instant, components: dateComponents)
    }
    
    /// Construct a `Fixed` value from an instantaneous point in time.
    /// - Parameter region: The `Region` in which to interpret the point in time
    /// - Parameter instant: The `Date` that is contained by the constructed `Fixed` value
    public init(region: Region, date: Foundation.Date) {
        let dateComponents = region.calendar.dateComponents(Self.representedComponents, from: date)
        self.init(region: region, instant: Instant(date: date), components: dateComponents)
    }
    
    /// Construct a `Fixed` value from a set of `DateComponents`.
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
        let date = try region.calendar.exactDate(from: strictDateComponents, 
                                                 matching: Self.representedComponents)
        self.init(region: region, instant: Instant(date: date), components: strictDateComponents)
    }
    
    private init(region: Region, dateComponents: DateComponents) throws {
        let refined = try dateComponents.requireAndRestrict(to: Self.representedComponents,
                                                            lenient: region.calendar.lenientUnitsForFixedTimePeriods)
        
        // turn the date components into a date
        guard let date = region.calendar.date(from: refined) else {
            throw TimeError.invalidDateComponents(refined, in: region)
        }
        
        self.init(region: region, date: date)
    }
    
    internal func truncated<U: Unit>() -> Fixed<U> {
        return Fixed<U>(region: region, instant: self.instant)
    }
    
    /// Construct a new `Fixed` value by converting the receiver to a new `Region`.
    public func setting(region: Region) -> Self {
        if region == self.region { return self }
        return Self.init(region: region, instant: self.instant)
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

extension Fixed: Comparable {
    
    /// Determine if one `Fixed` value is greater than another `Fixed` value.
    ///
    /// A `Fixed` value is greater than another if they have the same `Region`, and the first's
    /// calendrical components come *after* the other's components.
    /// - Parameter lhs: a `Fixed` value
    /// - Parameter rhs: a `Fixed` value
    public static func > (lhs: Self, rhs: Self) -> Bool {
        guard lhs.region == rhs.region else { return false }
        
        // since we're comparing two Fixed values of the same granularity,
        // we can confidently retrieve their respective `firstInstants` and compare those
        return lhs.firstInstant > rhs.firstInstant
    }
    
    /// Determine if one `Fixed` value is less than another `Fixed` value.
    ///
    /// A `Fixed` value is less than another if they have the same `Region`, and the first's
    /// calendrical components come *before* the other's components.
    /// - Parameter lhs: a `Fixed` value
    /// - Parameter rhs: a `Fixed` value
    public static func < (lhs: Self, rhs: Self) -> Bool {
        guard lhs.region == rhs.region else { return false }
        
        return lhs.firstInstant < rhs.firstInstant
    }
    
}

extension Fixed: CustomStringConvertible {
    
    /// Provide a description of the `Fixed` value.
    ///
    /// The description is a localized "natural" formatting of the calendar value.
    public var description: String {
        let style = FixedFormatStyle<Smallest>(naturalFormats: calendar)
        return format(using: style)
    }
    
}
