//
//  Epoch.swift
//  Time
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

/// An `Epoch` defines a "fixed" point in time, from which relative calendrical values are calculated.
///
/// In Swift, there are two well-known epochs: the Unix epoch (1 Jan 1970), and the "Reference" epoch (1 Jan 2001).
/// All `Instant` values are defined as a number of seconds before or after their `Epoch`.
public struct Epoch: Hashable {

    /// Determine if two Epochs are equivalent.
    public static func ==(lhs: Epoch, rhs: Epoch) -> Bool {
        return lhs.offsetFromReferenceDate == rhs.offsetFromReferenceDate
    }

    /// The Reference epoch (rooted at 1 Jan 2001 00:00:00 UTC).
    public static let reference = Epoch(0)

    /// The Unix epoch (rooted at 1 Jan 1970 00:00:00 UTC).
    public static let unix = Epoch(-SISeconds.secondsBetweenUnixAndReferenceEpochs)
    
    internal let offsetFromReferenceDate: SISeconds
    
    internal init(_ offsetFromReferenceDate: SISeconds) {
        self.offsetFromReferenceDate = offsetFromReferenceDate
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(offsetFromReferenceDate)
    }
    
}
