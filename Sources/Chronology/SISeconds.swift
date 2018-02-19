//
//  SISeconds.swift
//  Chronology
//
//  Created by Dave DeLong on 2/17/18.
//

import Foundation

public struct SISeconds: Hashable, Comparable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    
    internal static let secondsBetweenUnixAndReferenceEpochs = SISeconds(Date.timeIntervalBetween1970AndReferenceDate)
    
    public static func ==(lhs: SISeconds, rhs: SISeconds) -> Bool { return lhs.value == rhs.value }
    public static func <(lhs: SISeconds, rhs: SISeconds) -> Bool { return lhs.value < rhs.value }
    public static func +(lhs: SISeconds, rhs: SISeconds) -> SISeconds {
        return SISeconds(lhs.value + rhs.value)
    }
    public static func -(lhs: SISeconds, rhs: SISeconds) -> SISeconds {
        return SISeconds(lhs.value - rhs.value)
    }
    public static func *(lhs: SISeconds, rhs: Double) -> SISeconds {
        return SISeconds(lhs.value * rhs)
    }
    public static func /(lhs: SISeconds, rhs: Double) -> SISeconds {
        return SISeconds(lhs.value / rhs)
    }
    public static prefix func -(rhs: SISeconds) -> SISeconds { return SISeconds(-rhs.value) }
    
    internal let value: Double
    
    public var hashValue: Int { return value.hashValue }
    
    public init(_ value: Double) {
        self.value = value
    }
    
    public init(floatLiteral value: Double) {
        self.init(value)
    }
    
    public init(integerLiteral value: Double) {
        self.init(value)
    }
}
