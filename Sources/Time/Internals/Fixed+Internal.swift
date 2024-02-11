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
    
    internal func roundEra(direction: RoundingDirection) -> Self {
        // for gregorian calendars, this returns 0 ..< 2
        guard let maxRange = self.calendar.maximumRange(of: .era) else { return self }
        
        // working with a closed range (0 ... 1) is much nicer
        let closedMaxRange = maxRange.lowerBound ... (maxRange.upperBound - 1)
        
        let thisRangeStart = self.firstInstant
        
        if self.era == closedMaxRange.upperBound {
            // there's no way to round up, so we MUST round down
            return Self(region: self.region, instant: thisRangeStart)
        }
        
        return round(to: Era.self, direction: direction)
    }
    
    internal func round<U: LTOEEra>(to unit: U.Type = U.self, direction: RoundingDirection) -> Self {
        guard let maxRange = self.calendar.maximumRange(of: unit.component) else { return self }
        
        let roundedDown: Fixed<U> = self.truncated()
        let roundedDownStart = roundedDown.firstInstant
        
        if unit == Era.self {
            let closedMaxRange = maxRange.lowerBound ... (maxRange.upperBound - 1)
            
            if self.value(for: unit) == closedMaxRange.upperBound {
                return Self(region: self.region, instant: roundedDownStart)
            }
        }
        
        if direction == .backward {
            return Self(region: self.region, instant: roundedDownStart)
        }
        
        let roundedUp: Fixed<U> = roundedDown.next
        let roundedUpStart = roundedUp.firstInstant
        if direction == .forward {
            return Self(region: self.region, instant: roundedUpStart)
        }
        
        if roundedDownStart == roundedUpStart {
            return Self(region: self.region, instant: roundedDownStart)
        }
        
        let thisStart = self.approximateMidPoint
        
        let intervalToLowerDown = (thisStart - roundedDownStart).magnitude
        let intervalToUpStart = (roundedUpStart - thisStart).magnitude
        
        let nearestStart = (intervalToLowerDown <= intervalToUpStart) ? roundedDownStart : roundedUpStart
        return Self(region: self.region, instant: nearestStart)
    }
    
    internal func roundToMultiple(of match: TimeDifference<Smallest, Era>, direction: RoundingDirection) -> Self where Smallest: LTOEYear {
        /*
         PREMISE:
         - figure out the smallest represented unit in the matching components
         - that becomes the unit that we start iterating
         - iteration starts from the top of the (smallest unit)
         - we iterate until we find the value just before self and the value just after self
         
         NOTE:
         - this iteration is NOT typical iteration. For example if we're finding the nearest "13 minutes", then
         we'll iterate and check :00, :13, :26, :39, :52, :00, :13 ... etc
         */
        
        let represented = match.dateComponents.representedComponents
        guard let smallest = Calendar.Component.ascendingOrder.first(where: { represented.contains($0) }) else {
            // throw?
            return self
        }
        
        guard let nextLargest = smallest.nextLargest else {
            // this should always succeed, since this unit is LTOEYear; at least the ERA should always be larger
            fatalError("Unable to determine next unit larger from \(smallest)")
        }
        
        let baseIterationRange = self.calendar.range(of: nextLargest, containing: self.instant.date)
        
        let iterationStart = Self(region: self.region, date: baseIterationRange.lowerBound)
        
        let stride: TimeDifference<Smallest, Era>
        let boundaryStride = TimeDifference<Smallest, Era>(value: 1, unit: nextLargest)
        
        if represented.count == 1 {
            // this is the simplest case where we can do direct iteration by the specified stride
            stride = match
        } else {
            stride = TimeDifference(DateComponents(value: 1, component: smallest))
        }
        
        let sequence = BoundaryAlignedSequence(start: iterationStart, stride: stride, boundaryStride: boundaryStride)
        
        var smaller: Self?
        var larger: Self?
        
        for option in sequence {
            
            if option <= self { smaller = option }
            if option >= self { larger = option }
            
            if smaller != nil && larger != nil { break }
        }
        
        if direction == .backward {
            return smaller!
        } else if direction == .forward {
            return larger!
        } else {
            let differenceToSmaller = self.firstInstant - smaller!.firstInstant
            let differenceToLarger = larger!.firstInstant - self.firstInstant
            
            if differenceToSmaller < differenceToLarger {
                return smaller!
            } else {
                return larger!
            }
        }
    }
    
}
