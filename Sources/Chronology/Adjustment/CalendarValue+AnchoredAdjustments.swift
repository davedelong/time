//
//  Adjustment+AnchoredConvenience.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension CalendarValue where Self: Anchored & YearFields {
    
    func nextYear() -> Self { return self + .years(1) }
    func previousYear() -> Self { return self - .years(1) }
    
}

public extension CalendarValue where Self: Anchored & YearMonthFields {
    
    func nextMonth() -> Self { return self + .months(1) }
    func previousMonth() -> Self { return self - .months(1) }
    
}

public extension CalendarValue where Self: Anchored & YearMonthDayFields {
    
    func nextDay() -> Self { return self + .days(1) }
    func previousDay() -> Self { return self - .days(1) }
    
}

public extension CalendarValue where Self: Anchored & YearMonthDayHourFields {
    
    func nextHour() -> Self { return self + .hours(1) }
    func previousHour() -> Self { return self - .hours(1) }
    
}

public extension CalendarValue where Self: Anchored & YearMonthDayHourMinuteFields {
    
    func nextMinute() -> Self { return self + .minutes(1) }
    func previousMinute() -> Self { return self - .minutes(1) }
    
}

public extension CalendarValue where Self: Anchored & YearMonthDayHourMinuteSecondFields {
    
    func nextSecond() -> Self { return self + .seconds(1) }
    func previousSecond() -> Self { return self - .seconds(1) }
    
}

public extension CalendarValue where Self: Anchored & YearMonthDayHourMinuteSecondNanosecondFields {
    
    func nextNanosecond() -> Self { return self + .nanoseconds(1) }
    func previousNanosecond() -> Self { return self - .nanoseconds(1) }
    
}
