//
//  Adjustment+AbsoluteConvenience.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension AbsoluteValue where Self: YearField {
    
    func nextYear() -> Self { return adding(years: 1) }
    func previousYear() -> Self { return subtracting(years: 1) }
    
    func adding(years: Int) -> Self { return self + .years(years) }
    func subtracting(years: Int) -> Self { return self + .years(-years) }
    
}

public extension AbsoluteValue where Self: MonthField {
    
    func nextMonth() -> Self { return adding(months: 1) }
    func previousMonth() -> Self { return subtracting(months: 1) }
    
    func adding(months: Int) -> Self { return self + .months(months) }
    func subtracting(months: Int) -> Self { return self + .months(-months) }
    
}

public extension AbsoluteValue where Self: DayField {
    
    func nextDay() -> Self { return adding(days: 1) }
    func previousDay() -> Self { return subtracting(days: 1) }
    
    func adding(days: Int) -> Self { return self + .days(days) }
    func subtracting(days: Int) -> Self { return self + .days(-days) }
    
}

public extension AbsoluteValue where Self: HourField {
    
    func nextHour() -> Self { return adding(hours: 1) }
    func previousHour() -> Self { return subtracting(hours: 1) }
    
    func adding(hours: Int) -> Self { return self + .hours(hours) }
    func subtracting(hours: Int) -> Self { return self + .hours(-hours) }
    
}

public extension AbsoluteValue where Self: MinuteField {
    
    func nextMinute() -> Self { return adding(minutes: 1) }
    func previousMinute() -> Self { return subtracting(minutes: 1) }
    
    func adding(minutes: Int) -> Self { return self + .minutes(minutes) }
    func subtracting(minutes: Int) -> Self { return self + .minutes(-minutes) }
    
}

public extension AbsoluteValue where Self: SecondField {
    
    func nextSecond() -> Self { return adding(seconds: 1) }
    func previousSecond() -> Self { return subtracting(seconds: 1) }
    
    func adding(seconds: Int) -> Self { return self + .seconds(seconds) }
    func subtracting(seconds: Int) -> Self { return self + .seconds(-seconds) }
    
}

public extension AbsoluteValue where Self: NanosecondField {
    
    func nextNanosecond() -> Self { return adding(nanoseconds: 1) }
    func previousNanosecond() -> Self { return subtracting(nanoseconds: 1) }
    
    func adding(nanoseconds: Int) -> Self { return self + .nanoseconds(nanoseconds) }
    func subtracting(nanoseconds: Int) -> Self { return self + .nanoseconds(-nanoseconds) }
    
}
