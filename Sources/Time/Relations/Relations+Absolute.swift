//
//  Relations+Absolue.swift
//  
//
//  Created by Dave DeLong on 3/7/20.
//

public extension Absolute {
    
    /// Find the relationship between any two `Absolute` values.
    ///
    /// - Parameter other: Any other `Absolute` value
    func relation<OS>(to other: Absolute<OS>) -> Relation {
        let thisRange = self.range
        let thatRange = other.range
        
        return thisRange.determineRelationship(to: thatRange)
    }
    
}
