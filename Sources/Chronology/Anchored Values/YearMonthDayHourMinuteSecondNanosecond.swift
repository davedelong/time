//
//  YearMonthDayHourMinuteSecondNanosecond.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct YearMonthDayHourMinuteSecondNanosecond: CalendarValue, EraField, YearField, MonthField, DayField, HourField, MinuteField, SecondField, NanosecondField, Anchored, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second, .nanosecond]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
