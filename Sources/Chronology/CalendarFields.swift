//
//  CalendarFields.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol Anchored: CalendarValue {
    var range: ClosedRange<Instant> { get }
}

extension Anchored {
    
    public var range: ClosedRange<Instant> {
        let date = calendar.date(from: dateComponents).unwrap("Anchored values must always be convertible to a concrete NSDate")
        let unit = type(of: self).smalledRepresentedComponent
        
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

/// A marker protocol for generic constraints.
/// A value that is not Anchored is Floating.
public protocol Floating: CalendarValue { }

public protocol CalendarValueField { }

public protocol EraField: CalendarValueField { }

public protocol YearField: CalendarValueField { }

public protocol MonthField: CalendarValueField { }

public protocol DayField: CalendarValueField { }

public protocol HourField: CalendarValueField { }

public protocol MinuteField: CalendarValueField { }

public protocol SecondField: CalendarValueField { }

public protocol NanosecondField: CalendarValueField { }

public typealias YearFields = EraField & YearField
public typealias YearMonthFields = YearFields & MonthField
public typealias YearMonthDayFields = YearMonthFields & DayField
public typealias YearMonthDayHourFields = YearMonthDayFields & HourField
public typealias YearMonthDayHourMinuteFields = YearMonthDayHourFields & MinuteField
public typealias YearMonthDayHourMinuteSecondFields = YearMonthDayHourMinuteFields & SecondField
public typealias YearMonthDayHourMinuteSecondNanosecondFields = YearMonthDayHourMinuteSecondFields & NanosecondField

public typealias MonthDayFields = MonthField & DayField
public typealias DayHourFields = DayField & HourField
public typealias HourMinuteFields = HourField & MinuteField
public typealias MinuteSecondFields = MinuteField & SecondField
public typealias SecondNanosecondFields = SecondField & NanosecondField

public typealias MonthDayHourFields = MonthDayFields & HourField
public typealias DayHourMinuteFields = DayHourFields & MinuteField
public typealias HourMinuteSecondFields = HourMinuteFields & SecondField
public typealias MinuteSecondNanosecondFields = MinuteSecondFields & NanosecondField

public typealias MonthDayHourMinuteFields = MonthDayHourFields & MinuteField
public typealias DayHourMinuteSecondFields = DayHourMinuteFields & SecondField
public typealias HourMinuteSecondNanosecondFields = HourMinuteSecondFields & NanosecondField

public typealias MonthDayHourMinuteSecondFields = MonthDayHourMinuteFields & SecondField
public typealias DayHourMinuteSecondNanosecondFields = DayHourMinuteSecondFields & NanosecondField

public typealias MonthDayHourMinuteSecondNanosecondFields = MonthDayHourMinuteSecondFields & NanosecondField
