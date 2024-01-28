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
    
    public func isBefore<OS>(_ other: Fixed<OS>) -> Bool {
        let r = relation(to: other)
        return r == .before || r == .meets
    }
    
    public func isAfter<OS>(_ other: Fixed<OS>) -> Bool {
        return other.isBefore(self)
    }
    
    public func contains<OS>(_ other: Fixed<OS>) -> Bool {
        let r = relation(to: other)
        return r == .contains || r == .isStartedBy || r == .isFinishedBy
    }
    
    public func isDuring<OS>(_ other: Fixed<OS>) -> Bool {
        let r = relation(to: other)
        return r == .during || r == .starts || r == .finishes
    }
    
    public func overlaps<OS>(_ other: Fixed<OS>) -> Bool {
        return relation(to: other).isOverlapping
    }
    
}
