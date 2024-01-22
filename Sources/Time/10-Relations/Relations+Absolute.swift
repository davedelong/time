//
//  Relations+Absolue.swift
//  
//
//  Created by Dave DeLong on 3/7/20.
//

extension Absolute {
    
    /// Find the relationship between any two `Absolute` values.
    ///
    /// - Parameter other: Any other `Absolute` value
    public func relation<OS>(to other: Absolute<OS>) -> Relation {
        let thisRange = self.range
        let thatRange = other.range
        
        return thisRange.determineRelationship(to: thatRange)
    }
    
    public func isBefore<OS>(_ other: Absolute<OS>) -> Bool {
        let r = relation(to: other)
        return r == .before || r == .meets
    }
    
    public func isAfter<OS>(_ other: Absolute<OS>) -> Bool {
        return other.isBefore(self)
    }
    
    public func contains<OS>(_ other: Absolute<OS>) -> Bool {
        let r = relation(to: other)
        return r == .contains || r == .isStartedBy || r == .isFinishedBy
    }
    
    public func isDuring<OS>(_ other: Absolute<OS>) -> Bool {
        let r = relation(to: other)
        return r == .during || r == .starts || r == .finishes
    }
    
    public func overlaps<OS>(_ other: Absolute<OS>) -> Bool {
        return relation(to: other).isOverlapping
    }
    
}
