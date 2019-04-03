//
//  CalendarFields.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

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
public typealias MonthDayHourFields = MonthDayFields & HourField
public typealias MonthDayHourMinuteFields = MonthDayHourFields & MinuteField
public typealias MonthDayHourMinuteSecondFields = MonthDayHourMinuteFields & SecondField
public typealias MonthDayHourMinuteSecondNanosecondFields = MonthDayHourMinuteSecondFields & NanosecondField

public typealias DayHourFields = DayField & HourField
public typealias DayHourMinuteFields = DayHourFields & MinuteField
public typealias DayHourMinuteSecondFields = DayHourMinuteFields & SecondField
public typealias DayHourMinuteSecondNanosecondFields = DayHourMinuteSecondFields & NanosecondField

public typealias HourMinuteFields = HourField & MinuteField
public typealias HourMinuteSecondFields = HourMinuteFields & SecondField
public typealias HourMinuteSecondNanosecondFields = HourMinuteSecondFields & NanosecondField

public typealias MinuteSecondFields = MinuteField & SecondField
public typealias MinuteSecondNanosecondFields = MinuteSecondFields & NanosecondField

public typealias SecondNanosecondFields = SecondField & NanosecondField
