//
//  AbsoluteSequence.swift
//
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

/// A `Sequence` of `Absolute` calendar values.
public struct AbsoluteSequence<U: Unit & LTOEEra>: Sequence {
    
    private let constructor: () -> AbsoluteIterator<U>
    
    /// Construct an infinite sequence of `Absolute` calendar values starting from a specific value.
    /// - Parameters:
    ///   - start: The starting `Absolute` calendar value.
    ///   - stride: The difference between subsequent calendar values.
    public init(start: Absolute<U>, stride: TimeDifference<U, Era>) {
        constructor = { AbsoluteIterator(start: start, stride: stride, keepGoing: { _ in return true })}
    }
    
    /// Construct a sequence of `Absolute` calendar values starting from a specific value.
    /// - Parameters:
    ///   - start: The starting `Absolute` calendar value.
    ///   - stride: The difference between subsequent calendar values.
    ///   - keepGoing: A closure that is invoked to indicate whether the sequence should continue. This closure is invoked *before* the next value is generated.
    public init(start: Absolute<U>, stride: TimeDifference<U, Era>, while keepGoing: @escaping (Absolute<U>) -> Bool) {
        constructor = { AbsoluteIterator(start: start, stride: stride, keepGoing: keepGoing)}
    }
    
    /// Construct a sequence of `Absolute` calendar values that iterates through a definite range of values.
    ///
    /// - Note: This sequence iterates through values *up to but not including* the upper bound of the range.
    /// - Parameters:
    ///   - range: The `Range` of `Absolute` calendar values to iterate through.
    ///   - stride: The difference between subsequent calendar values.
    public init<S>(range: Range<Absolute<S>>, stride: TimeDifference<U, Era>) {
        let lower = range.lowerBound
        let upper = range.upperBound.setting(region: lower.region)
        constructor = { AbsoluteIterator(region: lower.region, range: lower.firstInstant ..< upper.firstInstant, stride: stride) }
    }
    
    /// Construct a sequence of `Absolute` calendar values that iterates through a closed range of values.
    ///
    /// - Note: This sequence iterates through values *up to and including* the upper bound of the range.
    /// - Parameters:
    ///   - range: The `ClosedRange` of `Absolute` calendar values to iterate through.
    ///   - stride: The difference between subsequent calendar values.
    public init<S>(range: ClosedRange<Absolute<S>>, stride: TimeDifference<U, Era>) {
        let lower = range.lowerBound
        let upper = range.upperBound.setting(region: lower.region)
        constructor = { AbsoluteIterator(region: lower.region, range: lower.firstInstant ... upper.firstInstant, stride: stride) }
    }
    
    internal init<S>(parent: Absolute<S>, stride: TimeDifference<U, Era> = TimeDifference(value: 1, unit: U.component)) {
        constructor = { AbsoluteIterator(region: parent.region, range: parent.range, stride: stride) }
    }
    
    public __consuming func makeIterator() -> AbsoluteIterator<U> {
        return constructor()
    }
    
}

/// An iterator of `Absolute` calendar values.
public struct AbsoluteIterator<U: Unit & LTOEEra>: IteratorProtocol {
    private let region: Region
    
    private let keepGoing: (Absolute<U>) -> Bool
    private let start: Absolute<U>
    
    private var scale = 0
    private let stride: DateComponents
    
    public init(start: Absolute<U>, stride: TimeDifference<U, Era>, keepGoing: @escaping (Absolute<U>) -> Bool) {
        self.region = start.region
        self.start = start
        self.stride = stride.dateComponents
        self.keepGoing = keepGoing
    }
    
    public init(region: Region, range: Range<Instant>, stride: TimeDifference<U, Era>) {
        self.region = region
        self.keepGoing = {
            let thisRange = $0.range
            return range.lowerBound <= thisRange.lowerBound && thisRange.upperBound <= range.upperBound
        }
        self.start = Absolute<U>(region: region, instant: range.lowerBound)
        self.stride = stride.dateComponents
    }
    
    public init(region: Region, range: ClosedRange<Instant>, stride: TimeDifference<U, Era>) {
        self.region = region
        self.keepGoing = { range.overlaps($0.range) }
        self.start = Absolute<U>(region: region, instant: range.lowerBound)
        self.stride = stride.dateComponents
    }
    
    public mutating func next() -> Absolute<U>? {
        let next = stride.scale(by: scale)
        scale += 1
        
        let delta = TimeDifference<U, Era>(next)
        let n = start + delta
        guard keepGoing(n) else { return nil }
        
        return n
    }
}
