//
//  __Protocols2.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 11/30/17.
//

import Foundation

protocol Floating: CalendarField { }

// there is no "AnyYear", because all years have a default Era, which makes them anchored
protocol AnyMonth: MonthField, Floating { }
protocol AnyDay: DayField, Floating { }
protocol AnyHour: HourField, Floating { }
protocol AnyMinute: MinuteField, Floating { }
protocol AnySecond: SecondField, Floating { }
protocol AnyNanosecond: NanosecondField, Floating { }

protocol AnyMonthDay: AnyMonth, AnyDay { }
protocol AnyMonthDayHour: AnyMonthDay, AnyHour { }
protocol AnyMonthDayHourMinute: AnyMonthDayHour, AnyMinute { }
protocol AnyMonthDayHourMinuteSecond: AnyMonthDayHourMinute, AnySecond { }

protocol AnyDayHour: AnyDay, AnyHour { }
protocol AnyDayHourMinute: AnyDayHour, AnyMinute { }
protocol AnyDayHourMinuteSecond: AnyDayHourMinute, AnySecond { }

protocol AnyHourMinute: AnyHour, AnyMinute { }
protocol AnyHourMinuteSecond: AnyHourMinute, AnySecond { }










































