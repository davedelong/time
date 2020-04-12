//
//  Deprecations.swift
//  
//
//  Created by Dave DeLong on 4/11/20.
//

import Foundation

@available(*,
            deprecated,
            renamed: "TimePeriod",
            message: "Value has been renamed to 'TimePeriod'. This name will disappear in 1.0")
public typealias Value = TimePeriod

@available(*,
            deprecated,
            renamed: "AbsoluteTimePeriodSequence",
            message: "AbsoluteValueSequence has been renamed to 'AbsoluteTimePeriodSequence'. This name will disappear in 1.0")
public typealias AbsoluteValueSequence = AbsoluteTimePeriodSequence

@available(*,
            deprecated,
            renamed: "AbsoluteTimePeriodIterator",
            message: "AbsoluteValueIterator has been renamed to 'AbsoluteTimePeriodIterator'. This name will disappear in 1.0")
public typealias AbsoluteValueIterator = AbsoluteTimePeriodIterator

@available(*,
            deprecated,
            renamed: "TimeDifference",
            message: "Difference has been renamed to 'TimeDifference'. This name will disappear in 1.0")
public typealias Difference = TimeDifference


extension Absolute {
    @available(*, deprecated,
                renamed: "init(region:strictDateComponents:)",
                message: "Usages of 'Unsafe' have been renamed to 'Strict'. This method will disappear in 1.0")
    public init(region: Region, unsafeDateComponents: DateComponents) throws {
        try self.init(region: region, strictDateComponents: unsafeDateComponents)
    }
    
    
    @available(*, deprecated,
                renamed: "init(stringValue:rawFormat:region:)",
                message: "This method will disappear in 1.0")
    public init(stringValue: String, format: String, region: Region) throws {
        try self.init(stringValue: stringValue, rawFormat: format, region: region)
    }
}
