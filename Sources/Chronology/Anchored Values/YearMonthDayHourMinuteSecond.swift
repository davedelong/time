//
//  YearMonthDayHourMinuteSecond.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct YearMonthDayHourMinuteSecond: CalendarValue, EraField, YearField, MonthField, DayField, HourField, MinuteField, SecondField, Anchored, DateComponentsInitializable {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second]
    
    public let region: Region
    public let dateComponents: DateComponents
    
}
