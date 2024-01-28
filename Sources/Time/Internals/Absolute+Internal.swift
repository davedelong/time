//
//  Fixed+Internal.swift
//  Time
//
//  Created by Dave DeLong on 10/4/18.
//

import Foundation

extension Fixed {
    
    internal var approximateMidPoint: Instant {
        let r = self.range
        let lower = r.lowerBound
        let upper = r.upperBound.converting(to: lower.epoch)
        let duration = upper.intervalSinceEpoch - lower.intervalSinceEpoch
        let midPoint = lower + (duration / 2.0)
        return max(lower, midPoint)
    }
    
    internal func value<U: Unit>(for unit: U.Type) -> Int? {
        guard representedComponents.contains(U.component) else { return nil }
        return dateComponents.value(for: U.component)
    }
    
    internal func first<U: Unit>() -> Fixed<U> {
        return Fixed<U>(region: region, instant: range.lowerBound)
    }
    
    internal func last<U: Unit>() -> Fixed<U> {
        return Fixed<U>(region: region, instant: range.upperBound) - TimeDifference(value: 1, unit: U.component)
    }
    
    internal func nth<U: Unit>(_ ordinal: Int) throws -> Fixed<U> {
        let target = DateComponents(value: ordinal, component: U.component)
        guard ordinal >= 1 else { throw TimeError.invalidDateComponents(target, in: region) }
        let offset: Fixed<U> = first() + TimeDifference<U, Era>(value: ordinal - 1, unit: U.component)
        
        let parentRange = self.range
        let childRange = offset.range
        
        guard parentRange.lowerBound <= childRange.lowerBound else { throw TimeError.invalidDateComponents(target, in: region) }
        guard childRange.upperBound <= parentRange.upperBound else { throw TimeError.invalidDateComponents(target, in: region) }
        return offset
    }
    
    internal func numbered<U: Unit>(_ number: Int) -> Fixed<U>? {
        guard let potential: Fixed<U> = try? nth(number - 1) else { return nil }
        guard let value = potential.value(for: U.self) else { return nil }
        if value == number { return potential }
        
        let incrementing = (value < number)
        
        let delta = TimeDifference<U, Era>(value: incrementing ? 1 : -1, unit: U.component)
        let tooFar: (Fixed<U>) -> Bool = {
            let value = $0.value(for: U.self)!
            if incrementing { return value > number }
            return value < number
        }
        
        var current = potential
        while true {
            let next = current.applying(difference: delta)
            if next.value(for: U.self) == number { return next }
            if tooFar(next) { break }
            current = next
        }
        return nil
    }
    
}
