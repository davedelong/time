//
//  Relations+Fixed.swift
//
//
//  Created by Dave DeLong on 3/7/20.
//

extension Fixed {
    
    /// Find the relationship between any two `Fixed` values.
    ///
    /// - Parameter other: Any other `Fixed` value
    public func relation<OS>(to other: Fixed<OS>) -> Relation {
        let thisRange = self.range
        let thatRange = other.range
        
        return thisRange.determineRelationship(to: thatRange)
    }
    
    /// Determine if this fixed value occurs entirely before or meets another fixed value
    /// - Parameter other: A fixed value
    /// - Returns: `true` if the relation to `other` is `.before` or `.meets`
    public func isBefore<OS>(_ other: Fixed<OS>) -> Bool {
        let r = relation(to: other)
        return r == .before || r == .meets
    }
    
    /// Determine if this fixed value occurs entirely after or meets another fixed value
    /// - Parameter other: A fixed value
    /// - Returns: `true` if the relation to `other` is `.after` or `.isMetBy`
    public func isAfter<OS>(_ other: Fixed<OS>) -> Bool {
        let r = relation(to: other)
        return r == .after || r == .isMetBy
    }
    
    /// Determine if this fixed value contains another fixed value
    /// - Parameter other: A fixed value
    /// - Returns: `true` if the relation to `other` is `.contains`, `.isStartedBy`, or `.isFinishedBy`
    public func contains<OS>(_ other: Fixed<OS>) -> Bool {
        let r = relation(to: other)
        return r == .contains || r == .isStartedBy || r == .isFinishedBy
    }
    
    /// Determine if this fixed value is contained by another fixed value
    /// - Parameter other: A fixed value
    /// - Returns: `true` if the relation to `other` is `.during`, `.starts`, or `.finishes`
    public func isDuring<OS>(_ other: Fixed<OS>) -> Bool {
        let r = relation(to: other)
        return r == .during || r == .starts || r == .finishes
    }
    
    /// Determine if this fixed overlaps another fixed value
    /// - Parameter other: A fixed value
    /// - Returns: `true` if the relation to `other` is `.overlaps`, `.isOverlappedBy`, `.during`, or `.contains`
    public func overlaps<OS>(_ other: Fixed<OS>) -> Bool {
        return relation(to: other).isOverlapping
    }
    
}
