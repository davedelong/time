//
//  Adjustment+AnchoredConvenience.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension CalendarValue where Self: Anchored & YearFields {
    
    public func nextYear() -> Self { return self + .years(1) }
    public func previousYear() -> Self { return self - .years(1) }
    
}

public extension CalendarValue where Self: Anchored & YearMonthFields {
    
    public func nextMonth() -> Self { return self + .months(1) }
    public func previousMonth() -> Self { return self - .months(1) }
    
}

public extension CalendarValue where Self: Anchored & YearMonthDayFields {
    
    public func nextDay() -> Self { return self + .days(1) }
    public func previousDay() -> Self { return self - .days(1) }
    
}

public extension CalendarValue where Self: Anchored & YearMonthDayHourFields {
    
    public func nextHour() -> Self { return self + .hours(1) }
    public func previousHour() -> Self { return self - .hours(1) }
    
}

public extension CalendarValue where Self: Anchored & YearMonthDayHourMinuteFields {
    
    public func nextMinute() -> Self { return self + .minutes(1) }
    public func previousMinute() -> Self { return self - .minutes(1) }
    
}

public extension CalendarValue where Self: Anchored & YearMonthDayHourMinuteSecondFields {
    
    public func nextSecond() -> Self { return self + .seconds(1) }
    public func previousSecond() -> Self { return self - .seconds(1) }
    
}

public extension CalendarValue where Self: Anchored & YearMonthDayHourMinuteSecondNanosecondFields {
    
    public func nextNanosecond() -> Self { return self + .nanoseconds(1) }
    public func previousNanosecond() -> Self { return self - .nanoseconds(1) }
    
}
