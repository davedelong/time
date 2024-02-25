import Foundation

/// An `Instant` is an instantaneous point in time, relative to an `Epoch`.
public struct Instant: Hashable, Comparable, InstantProtocol, Sendable {
    public typealias Duration = SISeconds

    /// Determine if two Instants are equivalent.
    public static func ==(lhs: Instant, rhs: Instant) -> Bool {
        return lhs.intervalSinceReferenceEpoch == rhs.intervalSinceReferenceEpoch
    }

    /// Determine if one Instant occurs before another Instant.
    public static func <(lhs: Instant, rhs: Instant) -> Bool {
        return lhs.intervalSinceReferenceEpoch < rhs.intervalSinceReferenceEpoch
    }

    /// Determine the number of seconds between two Instants.
    public static func -(lhs: Instant, rhs: Instant) -> SISeconds {
        return lhs.intervalSinceReferenceEpoch - rhs.intervalSinceReferenceEpoch
    }

    /// Apply an offset in seconds to an Instant.
    public static func +(lhs: Instant, rhs: SISeconds) -> Instant {
        return Instant(interval: lhs.intervalSinceEpoch + rhs, since: lhs.epoch)
    }

    /// The Instant's `Epoch` value.
    public let epoch: Epoch

    /// The number of seconds between the `Epoch` and the `Instant`.
    public let intervalSinceEpoch: SISeconds
    
    /// The number seconds between the reference epoch and the `Instant`
    public var intervalSinceReferenceEpoch: SISeconds { epoch.offsetFromReferenceDate + intervalSinceEpoch }

    /// Convert the `Instant` into its `Foundation.Date` representation.
    public var date: Foundation.Date {
        Date(timeIntervalSinceReferenceDate: intervalSinceReferenceEpoch.timeInterval)
    }

    /// Construct an `Instant` as the number of seconds since a particular `Epoch`.
    public init(interval: SISeconds, since epoch: Epoch) {
        self.epoch = epoch
        self.intervalSinceEpoch = interval
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
    public func converted(to epoch: Epoch) -> Instant {
        if epoch == self.epoch { return self }
        let epochOffset = epoch.offsetFromReferenceDate - self.epoch.offsetFromReferenceDate
        let epochInterval = intervalSinceEpoch - epochOffset
        return Instant(interval: epochInterval, since: epoch)
    }
    
    /// Advance an `Instant` by a number of ``SISeconds``
    ///
    /// Required by `InstantProtocol`.
    ///
    /// - Parameter duration: The number of seconds to advance the `Instant`
    /// - Returns: A new `Instant` value
    public func advanced(by duration: SISeconds) -> Self {
        return self + duration
    }
    
    /// Compute the duration in ``SISeconds`` between two `Instants`
    ///
    /// Required by `InstantProtocol`.
    ///
    /// - Parameter other: Another `Instant`
    /// - Returns: The duration in ``SISeconds`` between the two `Instants`
    public func duration(to other: Self) -> SISeconds {
        return self - other
    }
    
}

extension Instant: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case epoch = "epoch"
        case offset = "offset"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            // first, see if we can decode a Foundation.Date
            let container = try decoder.singleValueContainer()
            let date = try container.decode(Date.self)
            self.init(date: date)
        } catch {
            // can't decode a Foundation.Date. Try decoding a proper Instant
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let epoch = try container.decodeIfPresent(Epoch.self, forKey: .epoch) ?? .reference
            let seconds = try container.decode(SISeconds.self, forKey: .offset)
            
            self.init(interval: seconds, since: epoch)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(epoch, forKey: .epoch)
        try container.encode(intervalSinceEpoch, forKey: .offset)
    }
    
}

extension Instant: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        let direction = self.intervalSinceEpoch >= 0 ? "+" : ""
        return "\(epoch)\(direction)\(intervalSinceEpoch)"
    }
    
    public var debugDescription: String {
        let direction = self.intervalSinceEpoch >= 0 ? "+" : ""
        return "\(epoch)\(direction)\(intervalSinceEpoch.debugDescription)"
    }
    
}
