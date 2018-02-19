//
//  Instant.swift
//  Chronology
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

// TODO: make this more resilient against overflow
// It could be worthwhile having checks to see if it's better to convert from one epoch to another
// based on how close to a particular epoch an Instant is.
// For example, if we get a value in early 2038 based on the Unix epoch, we might want to consider
// recognizing this and instead basing it off the Reference epoch instead
// (note: the 2038 problem isn't an issue with Instant because it's based on Double and not Int32, but still)

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
    
    internal let intervalSinceReferenceEpoch: SISeconds
    
    public var hashValue: Int { return intervalSinceReferenceEpoch.hashValue }
    
    public init(interval: SISeconds, since epoch: Epoch) {
        self.epoch = epoch
        self.intervalSinceEpoch = interval
        self.intervalSinceReferenceEpoch = epoch.offsetFromReferenceDate + interval
    }
    
    internal init(date: Foundation.Date) {
        self.init(interval: SISeconds(date.timeIntervalSinceReferenceDate), since: .reference)
    }
    
    public func converting(to epoch: Epoch) -> Instant {
        let epochOffset = epoch.offsetFromReferenceDate - self.epoch.offsetFromReferenceDate
        let epochInterval = intervalSinceEpoch - epochOffset
        return Instant(interval: epochInterval, since: epoch)
    }
}
