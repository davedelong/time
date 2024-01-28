//
//  SISeconds.swift
//  Time
//
//  Created by Dave DeLong on 2/17/18.
//

import Foundation

/// A representation of a temporal interval, as measured in seconds.
///
/// An `SISeconds` represents a temporal interval, independent of any calendaring system.
/// It supports fractional seconds, up to the precision allowed by `Double`.
///
/// This type exists to ensure a proper distinction between "seconds as used in physics calculations"
/// and "seconds as represented by a calendar". On Earth, there is typically a 1:1 correspondence between
/// SI seconds and calendrical seconds. However, this correspondence is not *required*, and so a separate
/// of representation is needed.
///
/// - SeeAlso: [https://en.wikipedia.org/wiki/SI_base_unit](https://en.wikipedia.org/wiki/SI_base_unit)
public struct SISeconds: RawRepresentable, Hashable, Comparable, DurationProtocol, Sendable {
    
    internal static let secondsBetweenUnixAndReferenceEpochs = SISeconds(Date.timeIntervalBetween1970AndReferenceDate)
    
    /// Determine if two `SISeconds` values are equivalent.
    public static func ==(lhs: SISeconds, rhs: SISeconds) -> Bool { return lhs.rawValue == rhs.rawValue }
    
    /// Determine if an `SISeconds` value is smaller than another.
    public static func <(lhs: SISeconds, rhs: SISeconds) -> Bool { return lhs.rawValue < rhs.rawValue }
    
    /// Add two `SISeconds` values.
    public static func +(lhs: SISeconds, rhs: SISeconds) -> SISeconds {
        return SISeconds(rawValue: lhs.rawValue + rhs.rawValue)
    }
    
    /// Add and assign two `SISeconds` values.
    public static func +=(lhs: inout SISeconds, rhs: SISeconds) {
        lhs = lhs + rhs
    }
    
    /// Determine the difference between two `SISeconds` values.
    public static func -(lhs: SISeconds, rhs: SISeconds) -> SISeconds {
        return SISeconds(lhs.rawValue - rhs.rawValue)
    }

    /// Assign the difference between two `SISeconds` values.
    public static func -=(lhs: inout SISeconds, rhs: SISeconds) {
        lhs = lhs - rhs
    }
    
    /// Scale up an `SISeconds` value.
    public static func *(lhs: SISeconds, rhs: Double) -> SISeconds {
        return SISeconds(lhs.rawValue * rhs)
    }
    
    /// Scale up and assign to an `SISeconds` value.
    public static func *=(lhs: inout SISeconds, rhs: Double) {
        lhs = lhs * rhs
    }
    
    /// Scale down an `SISeconds` value.
    public static func /(lhs: SISeconds, rhs: Double) -> SISeconds {
        return SISeconds(lhs.rawValue / rhs)
    }

    /// Scale down and assign to an `SISeconds` value.
    public static func /=(lhs: inout SISeconds, rhs: Double) {
        lhs = lhs / rhs
    }
    
    /// Scale down an `SISeconds` value.
    public static func / (lhs: SISeconds, rhs: Int) -> SISeconds {
        return SISeconds(lhs.rawValue / Double(rhs))
    }
    
    /// Scale up an `SISeconds` value.
    public static func * (lhs: SISeconds, rhs: Int) -> SISeconds {
        return SISeconds(lhs.rawValue * Double(rhs))
    }
    
    /// Find the ratio between two `SISeconds` values.
    public static func / (lhs: SISeconds, rhs: SISeconds) -> Double {
        return lhs.rawValue / rhs.rawValue
    }
    
    /// Negate an `SISeconds` value.
    public static prefix func -(rhs: SISeconds) -> SISeconds {
        SISeconds(-rhs.rawValue)
    }
    
    /// The underlying `Double` representation of an `SISeconds` value.
    ///
    /// This value is analogous to `Foundation.TimeInterval`.
    public let rawValue: Swift.Duration
    
    public var timeInterval: Foundation.TimeInterval {
        let (seconds, attoseconds) = rawValue.components
        return Double(seconds) + (Double(attoseconds) / Double(1e18))
    }
    
    public init(rawValue: Duration) {
        self.rawValue = rawValue
    }
    
    public init(_ value: Duration) {
        self.rawValue = value
    }
    
    public init(_ value: Double) {
        self.rawValue = .seconds(value)
    }
    
    public init(_ value: Int) {
        self.rawValue = .seconds(value)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
    
}

extension SISeconds {
    
}

extension SISeconds: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Double) {
        self.init(value)
    }
    
    public init(integerLiteral value: Double) {
        self.init(value)
    }
}