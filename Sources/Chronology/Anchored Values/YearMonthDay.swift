//
//  YearMonthDay.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct YearMonthDay: Anchored, YearMonthDayFields {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month, .day]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
    
    public var isWeekend: Bool { return calendar.isDateInWeekend(approximateMidPoint.date) }
    
    public var isWeekday: Bool { return !isWeekend }
    
    public var dayOfWeek: Int { return calendar.component(.weekday, from: approximateMidPoint.date) }
    
    public func firstHour() -> YearMonthDayHour {
        return YearMonthDayHour(instant: range.lowerBound, region: region)
    }
    
    public func lastHour() -> YearMonthDayHour {
        return YearMonthDayHour(instant: range.upperBound, region: region)
    }
    
    public func nthHour(_ ordinal: Int) throws -> YearMonthDayHour {
        let offsetHour = firstHour() + .hours(ordinal - 1)
        
        let dayRange = self.range
        let hourRange = offsetHour.range
        
        guard dayRange.lowerBound <= hourRange.lowerBound else { throw AdjustmentError() }
        guard hourRange.upperBound <= dayRange.upperBound else { throw AdjustmentError() }
        return offsetHour
    }
}
