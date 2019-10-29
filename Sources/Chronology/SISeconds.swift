//
//  SISeconds.swift
//  Chronology
//
//  Created by Dave DeLong on 2/17/18.
//

import Foundation

public struct SISeconds: RawRepresentable, Hashable, Comparable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    
    internal static let secondsBetweenUnixAndReferenceEpochs = SISeconds(Date.timeIntervalBetween1970AndReferenceDate)
    
    public static func ==(lhs: SISeconds, rhs: SISeconds) -> Bool { return lhs.rawValue == rhs.rawValue }
    public static func <(lhs: SISeconds, rhs: SISeconds) -> Bool { return lhs.rawValue < rhs.rawValue }
    public static func +(lhs: SISeconds, rhs: SISeconds) -> SISeconds {
        return SISeconds(lhs.rawValue + rhs.rawValue)
    }
    public static func -(lhs: SISeconds, rhs: SISeconds) -> SISeconds {
        return SISeconds(lhs.rawValue - rhs.rawValue)
    }
    public static func *(lhs: SISeconds, rhs: Double) -> SISeconds {
        return SISeconds(lhs.rawValue * rhs)
    }
    public static func /(lhs: SISeconds, rhs: Double) -> SISeconds {
        return SISeconds(lhs.rawValue / rhs)
    }
    public static prefix func -(rhs: SISeconds) -> SISeconds { return SISeconds(-rhs.rawValue) }
    
    public let rawValue: Double
    
    public init(rawValue: Double) {
        self.rawValue = rawValue
    }
    
    public init(_ value: Double) {
        self.rawValue = value
    }
    
    public init(floatLiteral value: Double) {
        self.init(value)
    }
    
    public init(integerLiteral value: Double) {
        self.init(value)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
