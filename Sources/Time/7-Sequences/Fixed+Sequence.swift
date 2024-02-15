//
//  FixedSequence.swift
//
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

/// A `Sequence` of fixed values.
public struct FixedSequence<U: Unit & LTOEEra>: Sequence {
    
    private let constructor: () -> FixedIterator<U>
    
    /// Construct an infinite sequence of fixed values starting from a specific value.
    /// - Parameters:
    ///   - start: The starting fixed value.
    ///   - stride: The difference between subsequent calendar values.
    public init(start: Fixed<U>, stride: TimeDifference<U, Era>) {
        constructor = { FixedIterator(start: start, stride: stride, keepGoing: { _ in return true })}
    }
    
    /// Construct a sequence of fixed values starting from a specific value.
    /// - Parameters:
    ///   - start: The starting fixed value.
    ///   - stride: The difference between subsequent fixed values.
    ///   - keepGoing: A closure that is invoked to indicate whether the sequence should continue. This closure is invoked *before* the next value is generated.
    public init(start: Fixed<U>, stride: TimeDifference<U, Era>, while keepGoing: @escaping (Fixed<U>) -> Bool) {
        constructor = { FixedIterator(start: start, stride: stride, keepGoing: keepGoing)}
    }
    
    /// Construct a sequence of fixed values that iterates through a definite range of values.
    ///
    /// - Note: This sequence iterates through values *up to but not including* the upper bound of the range.
    /// - Parameters:
    ///   - range: The `Range` of fixed values to iterate through.
    ///   - stride: The difference between subsequent fixed values.
    public init<S>(range: Range<Fixed<S>>, stride: TimeDifference<U, Era>) {
        let lower = range.lowerBound
        let upper = range.upperBound.setting(region: lower.region)
        constructor = { FixedIterator(region: lower.region, range: lower.firstInstant ..< upper.firstInstant, stride: stride) }
    }
    
    /// Construct a sequence of fixed values that iterates through a closed range of values.
    ///
    /// - Note: This sequence iterates through values *up to and including* the upper bound of the range.
    /// - Parameters:
    ///   - range: The `ClosedRange` of fixed values to iterate through.
    ///   - stride: The difference between subsequent fixed values.
    public init<S>(range: ClosedRange<Fixed<S>>, stride: TimeDifference<U, Era>) {
        let lower = range.lowerBound
        let upper = range.upperBound.setting(region: lower.region)
        constructor = { FixedIterator(region: lower.region, range: lower.firstInstant ... upper.firstInstant, stride: stride) }
    }
    
    internal init<S>(parent: Fixed<S>, stride: TimeDifference<U, Era> = TimeDifference(value: 1, unit: U.component)) {
        constructor = { FixedIterator(region: parent.region, range: parent.range, stride: stride) }
    }
    
    public __consuming func makeIterator() -> FixedIterator<U> {
        return constructor()
    }
    
}

/// An iterator of fixed values.
public struct FixedIterator<U: Unit & LTOEEra>: IteratorProtocol {
    private let region: Region
    
    private let keepGoing: (Fixed<U>) -> Bool
    private let start: Fixed<U>
    
    private var scale = 0
    private let stride: DateComponents
    
    /// Construct an iterator of fixed values starting from a specific value.
    /// - Parameters:
    ///   - start: The starting fixed value.
    ///   - stride: The difference between subsequent fixed values.
    ///   - keepGoing: A closure that is invoked to indicate whether the sequence should continue. This closure is invoked *before* the next value is generated.
    public init(start: Fixed<U>, stride: TimeDifference<U, Era>, keepGoing: @escaping (Fixed<U>) -> Bool) {
        self.region = start.region
        self.start = start
        self.stride = stride.dateComponents
        self.keepGoing = keepGoing
    }
    
    /// Construct an iterator of fixed values that are within a specific range
    /// - Parameters:
    ///   - region: The ``Region`` of the fixed values
    ///   - range: The ``Instant`` range through which to iterate
    ///   - stride: The difference between subsequent fixed values
    public init(region: Region, range: Range<Instant>, stride: TimeDifference<U, Era>) {
        self.region = region
        self.keepGoing = {
            let thisRange = $0.range
            return range.lowerBound <= thisRange.lowerBound && thisRange.upperBound <= range.upperBound
        }
        self.start = Fixed<U>(region: region, instant: range.lowerBound)
        self.stride = stride.dateComponents
    }
    
    /// Construct an iterator of fixed values that are within a specific closed range
    ///
    /// - Note: This sequence iterates through values *up to and including* the upper bound of the range.
    /// - Parameters:
    ///   - region: The ``Region`` of the fixed values
    ///   - range: The `ClosedRange` of ``Instants`` to iterate through.
    ///   - stride: The difference between subsequent fixed values.
    public init(region: Region, range: ClosedRange<Instant>, stride: TimeDifference<U, Era>) {
        self.region = region
        self.keepGoing = { range.overlaps($0.range) }
        self.start = Fixed<U>(region: region, instant: range.lowerBound)
        self.stride = stride.dateComponents
    }
    
    /// Produce the next fixed value
    /// - Returns: The next fixed value, or `nil` if there are no more values to produce.
    public mutating func next() -> Fixed<U>? {
        let next = stride.scale(by: scale)
        scale += 1
        
        let delta = TimeDifference<U, Era>(next)
        let n = start + delta
        guard keepGoing(n) else { return nil }
        
        return n
    }
}
