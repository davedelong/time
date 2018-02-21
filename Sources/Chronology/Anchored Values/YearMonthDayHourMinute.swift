//
//  YearMonthDayHourMinute.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct YearMonthDayHourMinute: Anchored, YearMonthDayHourMinuteFields {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
    
    public func firstSecond() -> YearMonthDayHourMinuteSecond {
        return YearMonthDayHourMinuteSecond(instant: range.lowerBound, region: region)
    }
    
    public func lastSecond() -> YearMonthDayHourMinuteSecond {
        return YearMonthDayHourMinuteSecond(instant: range.upperBound, region: region)
    }
    
    public func nthSecond(_ ordinal: Int) throws -> YearMonthDayHourMinuteSecond {
        let offsetSecond = firstSecond() + .seconds(ordinal - 1)
        
        let minuteRange = self.range
        let secondRange = offsetSecond.range
        
        guard minuteRange.lowerBound <= secondRange.lowerBound else { throw AdjustmentError() }
        guard secondRange.upperBound <= minuteRange.upperBound else { throw AdjustmentError() }
        return offsetSecond
    }
    
}
