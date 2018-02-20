//
//  Adjustment+AnchoredConvenience.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension CalendarValue where Self: Anchored & YearField {
    
    public func nextYear() -> Self { return self + .years(1) }
    public func previousYear() -> Self { return self - .years(1) }
    
}

public extension CalendarValue where Self: Anchored & YearField & MonthField {
    
    public func nextMonth() -> Self { return self + .months(1) }
    public func previousMonth() -> Self { return self - .months(1) }
    
}

public extension CalendarValue where Self: Anchored & YearField & MonthField & DayField {
    
    public func nextDay() -> Self { return self + .days(1) }
    public func previousDay() -> Self { return self - .days(1) }
    
}

public extension CalendarValue where Self: Anchored & YearField & MonthField & DayField & HourField {
    
    public func nextHour() -> Self { return self + .hours(1) }
    public func previousHour() -> Self { return self - .hours(1) }
    
}

public extension CalendarValue where Self: Anchored & YearField & MonthField & DayField & HourField & MinuteField {
    
    public func nextMinute() -> Self { return self + .minutes(1) }
    public func previousMinute() -> Self { return self - .minutes(1) }
    
}

public extension CalendarValue where Self: Anchored & YearField & MonthField & DayField & HourField & MinuteField & SecondField {
    
    public func nextSecond() -> Self { return self + .seconds(1) }
    public func previousSecond() -> Self { return self - .seconds(1) }
    
}

public extension CalendarValue where Self: Anchored & YearField & MonthField & DayField & HourField & MinuteField & SecondField & NanosecondField {
    
    public func nextNanosecond() -> Self { return self + .nanoseconds(1) }
    public func previousNanosecond() -> Self { return self - .nanoseconds(1) }
    
}
