//
//  TimePeriod.swift
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
/// By contrast, a non-absolute `TimePeriod` (eg: "October") can represent *many*
/// possible values on a physical calendar (October 2019, October 2020, etc).
///
/// The defining characteristic of `Absolute<U>` values is that they contain
/// all calendar components starting from their lower unit up-to-and-including
/// the `Era` unit.
public typealias Absolute<U: Unit> = TimePeriod<U, Era>

/// `TimePeriod` is the fundamental type used to represent a calendrical value.
///
/// `TimePeriod` has two generic parameters, called `Smallest` and `Largest`. These
/// generic types are used to define the upper and lower bounds of the units
/// represented by the value.
///
/// For example, a `TimePeriod<Second, Hour>` contains components for seconds, minutes,
/// and hours. A `TimePeriod<Minute, Minute>` contains only a minute components. While it
/// is technically possible to define a `TimePeriod<Hour, Second>`, it is impossible
/// to actually construct one, as it would contain no underlying component values.
///
/// All `TimePeriods` have a `Region`, which defines the calendar, timezone, and
/// locale used in computing the underlying component values.
public struct TimePeriod<Smallest: Unit, Largest: Unit> {
    
    internal static func restrict(dateComponents: DateComponents, lenient: Set<Calendar.Component>) throws -> DateComponents {
        return try dateComponents.requireAndRestrict(to: representedComponents, lenient: lenient)
    }
    
    /// The set of `Calendar.Components` represented by this particular `TimePeriod`
    public static var representedComponents: Set<Calendar.Component> {
        return componentsFrom(lower: Smallest.self, to: Largest.self)
    }
        
    /// The `Region` value used in computing this `TimePeriod`'s components.
    public let region: Region
    
    /// The set of calendar components represented by this `TimePeriod`.
    public var representedComponents: Set<Calendar.Component> {
        return TimePeriod<Smallest, Largest>.representedComponents
    }
    
    internal let storage: TimePeriodStorage
    
    internal var dateComponents: DateComponents {
        switch storage {
            case .absolute(let date):
                return region.calendar.dateComponents(self.representedComponents, from: date)
            case .relative(let dateComponents):
                return dateComponents
        }
    }
    
    /// The `Calendar` used in computing this `TimePeriod`'s components, as defined by its `Region`.
    public var calendar: Calendar { return region.calendar }
    
    /// The `TimeZone` used in computing this `TimePeriod`'s components, as defined by its `Region`.
    public var timeZone: TimeZone { return region.timeZone }
    
    /// The `Locale` used in computing this `TimePeriod`'s components, as defined by its `Region`.
    public var locale: Locale { return region.locale }
    
    internal init(region: Region, absolute: Foundation.Date) {
        self.region = region
        self.storage = .absolute(absolute)
    }
    
    internal init(region: Region, relative: DateComponents) throws {
        self.region = region
        let lenient = region.calendar.lenientUnitsForAbsoluteTimePeriods
        let restricted = try TimePeriod.restrict(dateComponents: relative, lenient: lenient)
        self.storage = .relative(restricted)
    }
    
    private init(region: Region, dateComponents: DateComponents) throws {
        self.region = region
        
        if Largest.self == Era.self {
            // turn the date components into a date
            guard let date = region.calendar.date(from: dateComponents) else {
                throw TimeError.invalidDateComponents(dateComponents, in: region)
            }
            
            self.storage = .absolute(date)
        } else {
            // TODO: does this need more?
            let restricted = dateComponents.restrict(to: Self.representedComponents)
            self.storage = .relative(restricted)
        }
    }
    
    internal func subComponents<S: Unit, L: Unit>() -> TimePeriod<S, L> {
        return try! TimePeriod<S, L>(region: region, dateComponents: dateComponents)
    }
}

extension TimePeriod: Equatable {
    
    /// Determine if two `TimePeriods` are equal.
    ///
    /// Two `TimePeriods` are equal if they have the same `Region` and represent the same calendrical components.
    /// - Parameter lhs: a `TimePeriod`
    /// - Parameter rhs: a `TimePeriod`
    public static func ==(lhs: TimePeriod, rhs: TimePeriod) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents == rhs.dateComponents
    }
    
}

extension TimePeriod: Hashable {
    
    /// Compute the hash of a `TimePeriod`
    ///
    /// - Parameter hasher: a `Hasher`
    public func hash(into hasher: inout Hasher) {
        hasher.combine(region)
        hasher.combine(dateComponents)
    }
    
}

extension TimePeriod: Comparable {
    
    /// Determine if one `TimePeriod` is greater than another `TimePeriod`.
    ///
    /// A `TimePeriod` is greater than another if they have the same `Region`, and the first's
    /// calendrical components come *after* the other's components.
    /// - Parameter lhs: a `TimePeriod`
    /// - Parameter rhs: a `TimePeriod`
    public static func > (lhs: TimePeriod, rhs: TimePeriod) -> Bool {
        guard lhs.region == rhs.region else { return false }
        
        switch (lhs.storage, rhs.storage) {
            case (.absolute(let l), .absolute(let r)):
                let leftRange = lhs.calendar.range(containing: l, in: lhs.representedComponents)
                let rightRange = rhs.calendar.range(containing: r, in: rhs.representedComponents)
                
                return leftRange.lowerBound > rightRange.lowerBound
            case (.relative(let l), .relative(let r)):
                return l.isGreaterThan(other: r)
                
            default:
                return false
        }
    }
    
    /// Determine if one `TimePeriod` is less than another `TimePeriod`.
    ///
    /// A `TimePeriod` is less than another if they have the same `Region`, and the first's
    /// calendrical components come *before* the other's components.
    /// - Parameter lhs: a `TimePeriod`
    /// - Parameter rhs: a `TimePeriod`
    public static func < (lhs: TimePeriod, rhs: TimePeriod) -> Bool {
        guard lhs.region == rhs.region else { return false }
        
        switch (lhs.storage, rhs.storage) {
            case (.absolute(let l), .absolute(let r)):
                let leftRange = lhs.calendar.range(containing: l, in: lhs.representedComponents)
                let rightRange = rhs.calendar.range(containing: r, in: rhs.representedComponents)
                
                return leftRange.lowerBound < rightRange.lowerBound
            case (.relative(let l), .relative(let r)):
                return l.isLessThan(other: r)
                
            default:
                return false
        }
    }
    
}

extension TimePeriod: CustomStringConvertible {
    
    /// Provide a description of the `TimePeriod`.
    ///
    /// The description is a localized "natural" formatting of the calendar value.
    public var description: String {
        return formatNatural()
    }
    
}

internal enum TimePeriodStorage: Codable {
    case absolute(Foundation.Date)
    case relative(Foundation.DateComponents)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let date = try container.decode(Date.self)
            self = .absolute(date)
        } catch let absoluteError {
            do {
                let components = try container.decode(DateComponents.self)
                self = .relative(components)
            } catch let relativeError {
                throw TimeError.cannotDecodeTimePeriod(absoluteError, relativeError)
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .absolute(let date):
                try container.encode(date)
            case .relative(let dc):
                try container.encode(dc)
        }
    }
}
