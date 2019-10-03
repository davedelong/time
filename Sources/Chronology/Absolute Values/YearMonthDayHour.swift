//
//  YearMonthDayHour.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct YearMonthDayHour: Absolute, YearMonthDayHourFields {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
    
    public func firstMinute() -> YearMonthDayHourMinute {
        return YearMonthDayHourMinute(instant: range.lowerBound, region: region)
    }
    
    public func lastMinute() -> YearMonthDayHourMinute {
        return YearMonthDayHourMinute(instant: range.upperBound, region: region)
    }
    
    public func nthMinute(_ ordinal: Int) throws -> YearMonthDayHourMinute {
        let offsetMinute = firstMinute() + .minutes(ordinal - 1)
        
        let hourRange = self.range
        let minuteRange = offsetMinute.range
        
        guard hourRange.lowerBound <= minuteRange.lowerBound else { throw AdjustmentError() }
        guard minuteRange.upperBound <= hourRange.upperBound else { throw AdjustmentError() }
        return offsetMinute
    }
    
    public func minutes() -> ValueSequence<YearMonthDayHourMinute> {
        return ValueSequence(parent: self)
    }
    
    public func seconds() -> ValueSequence<YearMonthDayHourMinuteSecond> {
        return ValueSequence(parent: self)
    }
    
}
