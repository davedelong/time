//
//  Absolute+Internal.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension AbsoluteValue {
    
    internal var approximateMidPoint: Instant {
        let r = self.range
        let lower = r.lowerBound
        let upper = r.upperBound.converting(to: lower.epoch)
        let duration = upper.intervalSinceEpoch - lower.intervalSinceEpoch
        let midPoint = lower + (duration / 2.0)
        return max(lower, midPoint)
    }
    
}

extension Absolute {
    
    internal func first<U: Unit>() -> Absolute<U> {
        return Absolute<U>(instant: range.lowerBound, region: region)
    }
    
    internal func last<U: Unit>() -> Absolute<U> {
        return Absolute<U>(instant: range.upperBound, region: region)
    }
    
    internal func nth<U: Unit>(_ ordinal: Int) throws -> Absolute<U> {
        guard ordinal >= 1 else { throw AdjustmentError() }
        let offset: Absolute<U> = first() + FieldAdjustment<Absolute<U>>(value: ordinal - 1, unit: U.component)
        
        let parentRange = self.range
        let childRange = offset.range
        
        guard parentRange.lowerBound <= childRange.lowerBound else { throw AdjustmentError() }
        guard childRange.upperBound <= parentRange.upperBound else { throw AdjustmentError() }
        return offset
    }
}
