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

public extension Range {
    
    func relation<IL, OL>(to other: Range<Absolute<OL>>) -> Relation where Bound == Absolute<IL> {
        // Ranges do _not_ contain their upper bound, so when converting to ranges of Instant, we should
        // take the Range<Absolue>'s upper bound's lowest Instant.
        let thisRange = lowerBound.range.lowerBound ..< upperBound.range.lowerBound
        let thatRange = other.lowerBound.range.lowerBound ..< other.upperBound.range.lowerBound
        return thisRange.determineRelationship(to: thatRange)
    }
    
    func relation<IL, OL>(to other: Absolute<OL>) -> Relation where Bound == Absolute<IL> {
        let thisRange = lowerBound.range.lowerBound ..< upperBound.range.lowerBound
        return thisRange.determineRelationship(to: other.range)
    }
    
}
