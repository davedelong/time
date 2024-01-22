//
//  Absolute.swift
//
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

/// An `Absolute<U>` is a type that corresponds to one (and only one) value
/// on a physical calendar. For example, there is only one "October 2019 CE"
/// on the Gregorian calendar.
///
/// The defining characteristic of `Absolute<U>` values is that they contain
/// all calendar components starting from their lower unit up-to-and-including
/// the `Era` unit.
///
/// All `Absolute` values have a `Region`, which defines the calendar, timezone, and
/// locale used in computing the underlying component values.
public struct Absolute<Smallest: Unit & LTOEEra> {
    
    internal static func restrict(dateComponents: DateComponents, lenient: Set<Calendar.Component>) throws -> DateComponents {
        return try dateComponents.requireAndRestrict(to: representedComponents, lenient: lenient)
    }
    
    /// The set of `Calendar.Components` represented by this particular `Absolute` value
    public static var representedComponents: Set<Calendar.Component> {
        return Calendar.Component.from(lower: Smallest.self, to: Era.self)
    }
        
    /// The `Region` value used in computing this `Absolute` value's components.
    public let region: Region
    
    internal let date: Foundation.Date
    internal let dateComponents: Foundation.DateComponents
    
    /// The set of calendar components represented by this `Absolute` value.
    public var representedComponents: Set<Calendar.Component> {
        return Self.representedComponents
    }
    
    /// The `Calendar` used in computing this `Absolute` value's components, as defined by its `Region`.
    public var calendar: Calendar { return region.calendar }
    
    /// The `TimeZone` used in computing this `Absolute` value's components, as defined by its `Region`.
    public var timeZone: TimeZone { return region.timeZone }
    
    /// The `Locale` used in computing this `Absolute` value's components, as defined by its `Region`.
    public var locale: Locale { return region.locale }
    
    /// Construct an `Absolute` value from an instantaneous point in time.
    /// - Parameter region: The `Region` in which to interpret the point in time
    /// - Parameter instant: The `Instant` that is contained by the constructed `Absolute` value
    public init(region: Region, instant: Instant) {
        self.init(region: region, date: instant.date)
    }
    
    /// Construct an `Absolute` value from an instantaneous point in time.
    /// - Parameter region: The `Region` in which to interpret the point in time
    /// - Parameter instant: The `Date` that is contained by the constructed `Absolute` value
    public init(region: Region, date: Foundation.Date) {
        self.region = region
        self.date = date
        self.dateComponents = region.calendar.dateComponents(Self.representedComponents, from: date)
    }
    
    /// Construct an absolute `Absolute` value from a set of `DateComponents`.
    ///
    /// This method is "strict" because it is fairly easy for it to produce an error.
    /// For example, if you are attempting to construct an `Absolute<Month>` but only provide
    /// a `year` value in the `DateComponents`, then this will throw a `TimeError`.
    ///
    /// If you are attempting to construct a calendrically impossible date, such as "February 30th",
    /// then this will throw a `TimeError`.
    ///
    /// The matching done on the `DateComponents` is a *strict* match; the returned `Absolute` value will
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
    
    internal func subComponents<S: Unit>() -> Absolute<S> {
        return try! Absolute<S>(region: region, dateComponents: dateComponents)
    }
    
    /// Construct a new `Absolute` value by converting the receiver to a new `Region`.
    public func setting(region: Region) -> Self {
        if region == self.region { return self }
        return Self.init(region: region, date: self.date)
    }
    
    /// Construct a new `Absolute` value by converting the receiver to a new `Calendar`.
    public func setting(calendar: Calendar) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.setting(region: newRegion)
    }
    
    /// Construct a new `Absolute` value by converting the receiver to a new `TimeZone`.
    public func converting(to timeZone: TimeZone) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.setting(region: newRegion)
    }
    
    /// Construct a new `Absolute` value by converting the receiver to a new `Locale`.
    public func converting(to locale: Locale) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.setting(region: newRegion)
    }
    
}

extension Absolute: Equatable {
    
    /// Determine if two `Absolute` values are equal.
    ///
    /// Two `Absolute` values are equal if they have the same `Region` and represent the same calendrical components.
    /// - Parameter lhs: an `Absolute` value
    /// - Parameter rhs: an `Absolute` value
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents == rhs.dateComponents
    }
    
}

extension Absolute: Hashable {
    
    /// Compute the hash of a n`Absolute` value
    ///
    /// - Parameter hasher: a `Hasher`
    public func hash(into hasher: inout Hasher) {
        hasher.combine(region)
        hasher.combine(dateComponents)
    }
    
}

extension Absolute: Comparable {
    
    /// Determine if one `Absolute` value is greater than another `Absolute` value.
    ///
    /// An `Absolute` value is greater than another if they have the same `Region`, and the first's
    /// calendrical components come *after* the other's components.
    /// - Parameter lhs: an `Absolute` value
    /// - Parameter rhs: an `Absolute` value
    public static func > (lhs: Self, rhs: Self) -> Bool {
        guard lhs.region == rhs.region else { return false }
        let leftRange = lhs.calendar.range(containing: lhs.date, in: lhs.representedComponents)
        let rightRange = rhs.calendar.range(containing: rhs.date, in: rhs.representedComponents)
        
        return leftRange.lowerBound > rightRange.lowerBound
    }
    
    /// Determine if one `Absolute` value is less than another `Absolute` value.
    ///
    /// An `Absolute` value is less than another if they have the same `Region`, and the first's
    /// calendrical components come *before* the other's components.
    /// - Parameter lhs: an `Absolute` value
    /// - Parameter rhs: an `Absolute` value
    public static func < (lhs: Self, rhs: Self) -> Bool {
        guard lhs.region == rhs.region else { return false }
        let leftRange = lhs.calendar.range(containing: lhs.date, in: lhs.representedComponents)
        let rightRange = rhs.calendar.range(containing: rhs.date, in: rhs.representedComponents)
        
        return leftRange.lowerBound < rightRange.lowerBound
    }
    
}

extension Absolute: CustomStringConvertible {
    
    /// Provide a description of the `Absolute` value.
    ///
    /// The description is a localized "natural" formatting of the calendar value.
    public var description: String {
        let style = AbsoluteFormatStyle<Smallest>(naturalFormats: calendar)
        return format(using: style)
    }
    
}
