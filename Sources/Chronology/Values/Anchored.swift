//
//  Anchored.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 10/4/18.
//

import Foundation

public protocol Anchored: CalendarValue {
    var range: ClosedRange<Instant> { get }
}

extension Anchored {
    
    public var range: ClosedRange<Instant> {
        let date = calendar.date(from: dateComponents).unwrap("Anchored values must always be convertible to a concrete NSDate")
        let unit = type(of: self).smallestRepresentedComponent
        
        var start = Date()
        var length: TimeInterval = 0
        let succeeded = calendar.dateInterval(of: unit, start: &start, interval: &length, for: date)
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
}

/// Access the less-precise fields on Anchored values

public extension Anchored where Self: YearField {
    var era: Era { return Era(region: region, dateComponents: dateComponents) }
}

public extension Anchored where Self: MonthField {
    var year: Year { return Year(region: region, dateComponents: dateComponents) }
}

public extension Anchored where Self: DayField {
    var yearMonth: YearMonth { return YearMonth(region: region, dateComponents: dateComponents) }
    
    var isWeekend: Bool { return calendar.isDateInWeekend(approximateMidPoint.date) }
    var isWeekday: Bool { return !isWeekend }
    var dayOfWeek: Int { return calendar.component(.weekday, from: approximateMidPoint.date) }
}

public extension Anchored where Self: HourField {
    var yearMonthDay: YearMonthDay { return YearMonthDay(region: region, dateComponents: dateComponents) }
}

public extension Anchored where Self: MinuteField {
    var yearMonthDayHour: YearMonthDayHour { return YearMonthDayHour(region: region, dateComponents: dateComponents) }
}

public extension Anchored where Self: SecondField {
    var yearMonthDayHourMinute: YearMonthDayHourMinute { return YearMonthDayHourMinute(region: region, dateComponents: dateComponents) }
}

public extension Anchored where Self: NanosecondField {
    var yearMonthDayHourMinuteSecond: YearMonthDayHourMinuteSecond { return YearMonthDayHourMinuteSecond(region: region, dateComponents: dateComponents)}
}
