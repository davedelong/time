import Foundation

/// An `Epoch` defines a point in time from which relative calendrical values are calculated, like a temporal Prime Meridian.
///
/// In Swift, there are two well-known epochs: the Unix epoch (1 Jan 1970), and the "Reference" epoch (1 Jan 2001).
/// All `Instant` values are defined as a number of seconds before or after their `Epoch`.
public struct Epoch: Hashable, Sendable, CustomStringConvertible {

    /// Determine if two Epochs are equivalent.
    public static func ==(lhs: Epoch, rhs: Epoch) -> Bool {
        return lhs.offsetFromReferenceDate == rhs.offsetFromReferenceDate
    }

    /// The Reference epoch (fixed at 1 Jan 2001 00:00:00 UTC).
    public static let reference = Epoch(0)

    /// The Unix epoch (fixed at 1 Jan 1970 00:00:00 UTC).
    public static let unix = Epoch(-SISeconds.secondsBetweenUnixAndReferenceEpochs)
    
    internal let offsetFromReferenceDate: SISeconds
    
    internal init(_ offsetFromReferenceDate: SISeconds) {
        self.offsetFromReferenceDate = offsetFromReferenceDate
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(offsetFromReferenceDate)
    }
    
    public var description: String {
        if self == .unix { return "unix" }
        if self == .reference { return "reference" }
        return "custom(\(offsetFromReferenceDate))"
    }
    
}

extension Epoch: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(try container.decode(SISeconds.self))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(offsetFromReferenceDate)
    }
    
}
