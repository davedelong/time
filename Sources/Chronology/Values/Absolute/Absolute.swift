//
//  Absolute.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 10/4/18.
//

import Foundation

public typealias Absolute<U: Unit> = Value<U, Era>

extension Value where Largest: GTOEEra {
    
    public var range: ClosedRange<Instant> {
        let date = calendar.date(from: dateComponents).unwrap("Absolute values must always be convertible to a concrete NSDate")
        
        var start = Date()
        var length: TimeInterval = 0
        let succeeded = calendar.dateInterval(of: Smallest.component, start: &start, interval: &length, for: date)
        require(succeeded, "We should always be able to get the range of a calendar component")
        
        let startInsant = Instant(date: start)
        let endInstant = Instant(date: start.addingTimeInterval(length))
        return startInsant...endInstant
    }
    
    internal var approximateMidPoint: Instant {
        let r = self.range
        let lower = r.lowerBound
        let upper = r.upperBound.converting(to: lower.epoch)
        let duration = upper.intervalSinceEpoch - lower.intervalSinceEpoch
        let midPoint = lower + (duration / 2.0)
        return max(lower, midPoint)
    }
    
    internal init(region: Region, instant: Instant) {
        self.init(region: region, date: instant.date)
    }
    
    internal init(region: Region, date: Date) {
        let dc = region.components(Self.representedComponents, from: date)
        self.init(region: region, dateComponents: dc)
    }
    
    internal func first<U: Unit>() -> Absolute<U> {
        return Absolute<U>(region: region, instant: range.lowerBound)
    }
    
    internal func last<U: Unit>() -> Absolute<U> {
        return Absolute<U>(region: region, instant: range.upperBound)
    }
    
    internal func nth<U: Unit>(_ ordinal: Int) throws -> Absolute<U> {
        guard ordinal >= 1 else { throw AdjustmentError() }
        let offset: Absolute<U> = first() + FieldAdjustment<U, Era>(value: ordinal - 1, unit: U.component)
        
        let parentRange = self.range
        let childRange = offset.range
        
        guard parentRange.lowerBound <= childRange.lowerBound else { throw AdjustmentError() }
        guard childRange.upperBound <= parentRange.upperBound else { throw AdjustmentError() }
        return offset
    }
    
}
