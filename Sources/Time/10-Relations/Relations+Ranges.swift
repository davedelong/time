//
//  Relations+Ranges.swift
//  
//
//  Created by Dave DeLong on 3/7/20.
//

import Foundation

internal extension Range where Bound: Comparable {
    
    func determineRelationship(to other: Range<Bound>) -> Relation {
        if self.lowerBound < other.lowerBound {
            if self.upperBound < other.lowerBound { return .before }
            if self.upperBound == other.lowerBound { return .meets }
            if self.upperBound < other.upperBound { return .overlaps }
            if self.upperBound == other.upperBound { return .isFinishedBy }
            /* self.upperBound > other.upperBound */ return .contains
        } else if self.lowerBound == other.lowerBound {
            if self.upperBound < other.upperBound { return .starts }
            if self.upperBound == other.upperBound { return .equal }
            /* self.upperBound > other.upperBound */ return .isStartedBy
        } else /* self.lowerBound > other.lowerBound */ {
            if self.lowerBound > other.upperBound { return .after }
            if self.lowerBound == other.upperBound { return .isMetBy }
            if self.upperBound < other.upperBound { return .during }
            if self.upperBound == other.upperBound { return .finishes }
            /* self.upperBound > other.upperBound */ return .isOverlappedBy
        }
    }
    
}

extension Range {
    
    /// Determine the relation between two ranges of fixed values
    /// - Parameter other: A range of fixed values
    /// - Returns: A ``Relation`` describing the relation between the two ranges.
    public func relation<IL, OL>(to other: Range<Fixed<OL>>) -> Relation where Bound == Fixed<IL> {
        // Ranges do _not_ contain their upper bound, so when converting to ranges of Instant, we should
        // take the Range<Absolue>'s upper bound's lowest Instant.
        let thisRange = lowerBound.range.lowerBound ..< upperBound.range.lowerBound
        let thatRange = other.lowerBound.range.lowerBound ..< other.upperBound.range.lowerBound
        return thisRange.determineRelationship(to: thatRange)
    }
    
    /// Determine the relation between this range of fixed values and another fixed value
    /// - Parameter other: A fixed value
    /// - Returns: A ``Relation`` describing the relation between this range and the fixed value.
    public func relation<IL, OL>(to other: Fixed<OL>) -> Relation where Bound == Fixed<IL> {
        let thisRange = lowerBound.range.lowerBound ..< upperBound.range.lowerBound
        return thisRange.determineRelationship(to: other.range)
    }
    
}
