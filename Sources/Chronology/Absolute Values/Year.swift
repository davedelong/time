//
//  Year.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Year: Absolute, YearFields {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
    
    public func firstMonth() -> YearMonth {
        return YearMonth(instant: range.lowerBound, region: region)
    }
    
    public func lastMonth() -> YearMonth {
        return YearMonth(instant: range.upperBound, region: region)
    }
    
    public func nthMonth(_ ordinal: Int) throws -> YearMonth {
        guard ordinal >= 1 else { throw AdjustmentError() }
        let offsetMonth = firstMonth() + .months(ordinal - 1)
        
        let yearRange = self.range
        let monthRange = offsetMonth.range
        
        guard yearRange.lowerBound <= monthRange.lowerBound else { throw AdjustmentError() }
        guard monthRange.upperBound <= yearRange.upperBound else { throw AdjustmentError() }
        return offsetMonth
    }
    
    public func months() -> ValueSequence<YearMonth> {
        return ValueSequence(parent: self)
    }
    
    public func days() -> ValueSequence<YearMonthDay> {
        return ValueSequence(parent: self)
    }
    
    public func hours() -> ValueSequence<YearMonthDayHour> {
        return ValueSequence(parent: self)
    }
    
    public func minutes() -> ValueSequence<YearMonthDayHourMinute> {
        return ValueSequence(parent: self)
    }
    
    public func seconds() -> ValueSequence<YearMonthDayHourMinuteSecond> {
        return ValueSequence(parent: self)
    }
    
}
