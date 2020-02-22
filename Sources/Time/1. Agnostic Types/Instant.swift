//
//  Instant.swift
//  Time
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


/// An `Instant` is an instantaneous point in time, relative to an `Epoch`.
public struct Instant: Hashable, Comparable {

    /// Determine if two Instants are equivalent
    public static func ==(lhs: Instant, rhs: Instant) -> Bool {
        return lhs.intervalSinceReferenceEpoch == rhs.intervalSinceReferenceEpoch
    }

    /// Determine if one Instant occurs before another Instant
    public static func <(lhs: Instant, rhs: Instant) -> Bool {
        return lhs.intervalSinceReferenceEpoch < rhs.intervalSinceReferenceEpoch
    }

    /// Determine the number of seconds between two Instants
    public static func -(lhs: Instant, rhs: Instant) -> SISeconds {
        return lhs.intervalSinceReferenceEpoch - rhs.intervalSinceReferenceEpoch
    }

    /// Apply an offset in seconds to an Instant
    public static func +(lhs: Instant, rhs: SISeconds) -> Instant {
        return Instant(interval: lhs.intervalSinceEpoch + rhs, since: lhs.epoch)
    }

    /// The Instant's `Epoch` value.
    public let epoch: Epoch

    /// The number of seconds between the `Epoch` and the `Instant`.
    public let intervalSinceEpoch: SISeconds
    
    private let intervalSinceReferenceEpoch: SISeconds

    /// Convert the `Instant` into its `Foundation.Date` representation.
    public var date: Foundation.Date { return Date(timeIntervalSinceReferenceDate: intervalSinceReferenceEpoch.rawValue) }

    /// Construct an `Instant` as the number of seconds since a particular `Epoch`.
    public init(interval: SISeconds, since epoch: Epoch) {
        self.epoch = epoch
        self.intervalSinceEpoch = interval
        self.intervalSinceReferenceEpoch = epoch.offsetFromReferenceDate + interval
    }

    /// Construct an `Instant` based on a `Foundation.Date`. This uses the Reference `Epoch`.
    public init(date: Foundation.Date) {
        self.init(interval: SISeconds(date.timeIntervalSinceReferenceDate), since: .reference)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(intervalSinceReferenceEpoch)
    }

    /// Convert an `Instant` from one `Epoch` to another.
    ///
    /// The resulting `Instant` still refers to the *same* point in time as the original `Instant`.
    /// This method is used to retrieve an alternate *representation* of that instant.
    public func converting(to epoch: Epoch) -> Instant {
        if epoch == self.epoch { return self }
        let epochOffset = epoch.offsetFromReferenceDate - self.epoch.offsetFromReferenceDate
        let epochInterval = intervalSinceEpoch - epochOffset
        return Instant(interval: epochInterval, since: epoch)
    }
}
