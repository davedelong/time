//
//  Instant.swift
//  Chronology
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

public struct Instant: Hashable, Comparable {
    
    public static func ==(lhs: Instant, rhs: Instant) -> Bool {
        return lhs.intervalSinceReferenceEpoch == rhs.intervalSinceReferenceEpoch
    }
    
    public static func <(lhs: Instant, rhs: Instant) -> Bool {
        return lhs.intervalSinceReferenceEpoch < rhs.intervalSinceReferenceEpoch
    }
    
    public static func -(lhs: Instant, rhs: Instant) -> TimeInterval {
        return lhs.intervalSinceReferenceEpoch - rhs.intervalSinceReferenceEpoch
    }
    
    public static func +(lhs: Instant, rhs: TimeInterval) -> Instant {
        return Instant(interval: lhs.intervalSinceEpoch + rhs, since: lhs.epoch)
    }
    
    public let epoch: Epoch
    public let intervalSinceEpoch: TimeInterval
    
    private let intervalSinceReferenceEpoch: TimeInterval
    
    public var hashValue: Int { return Int(intervalSinceReferenceEpoch) }
    
    public init(interval: TimeInterval, since epoch: Epoch) {
        self.epoch = epoch
        self.intervalSinceEpoch = interval
        self.intervalSinceReferenceEpoch = epoch.offsetFromReferenceDate + interval
    }
    
    internal init(_ date: Date = Date()) {
        self.epoch = Epoch.reference
        self.intervalSinceEpoch = date.timeIntervalSinceReferenceDate
        self.intervalSinceReferenceEpoch = date.timeIntervalSinceReferenceDate
    }
    
}
