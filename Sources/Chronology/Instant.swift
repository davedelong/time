//
//  Instant.swift
//  Chronology
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

public typealias SISeconds = Double

public struct Instant: Hashable, Comparable {
    
    public static func ==(lhs: Instant, rhs: Instant) -> Bool {
        return lhs.intervalSinceReferenceEpoch == rhs.intervalSinceReferenceEpoch
    }
    
    public static func <(lhs: Instant, rhs: Instant) -> Bool {
        return lhs.intervalSinceReferenceEpoch < rhs.intervalSinceReferenceEpoch
    }
    
    public static func -(lhs: Instant, rhs: Instant) -> SISeconds {
        return lhs.intervalSinceReferenceEpoch - rhs.intervalSinceReferenceEpoch
    }
    
    public static func +(lhs: Instant, rhs: SISeconds) -> Instant {
        return Instant(interval: lhs.intervalSinceEpoch + rhs, since: lhs.epoch)
    }
    
    public let epoch: Epoch
    public let intervalSinceEpoch: SISeconds
    
    private let intervalSinceReferenceEpoch: SISeconds
    
    public var hashValue: Int { return Int(intervalSinceReferenceEpoch) }
    
    public init(interval: SISeconds, since epoch: Epoch) {
        self.epoch = epoch
        self.intervalSinceEpoch = interval
        self.intervalSinceReferenceEpoch = epoch.offsetFromReferenceDate + interval
    }
    
    public func converting(to epoch: Epoch) -> Instant {
        let epochOffset = epoch.offsetFromReferenceDate - self.epoch.offsetFromReferenceDate
        let epochInterval = intervalSinceEpoch - epochOffset
        return Instant(interval: epochInterval, since: epoch)
    }
}
