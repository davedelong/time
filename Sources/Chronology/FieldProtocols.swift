//
//  FieldProtocols.swift
//  Chronology
//
//  Created by Dave DeLong on 2/18/18.
//

import Foundation

public protocol DateFields: RegionField, EraField, YearField, MonthField, DayField { }
public protocol TimeFields: HourField, MinuteField, SecondField, NanosecondField { }
public protocol DateTimeFields: DateFields, TimeFields { }

// These structs are "floating" (not anchored)
// They do not have enough information to identify their range

/***
 
public typealias Date = YearMonthDay
public typealias Time = HourMinuteSecondSubsecond
public typealias DateTime = YearMonthDayHourMinuteSecondSubsecond

public struct Month: RegionField, MonthField { }
public struct Day: RegionField, DayField { }
public struct Hour: RegionField, HourField { }
public struct Minute: RegionField, MinuteField { }
public struct Second: RegionField, SecondField { }
public struct Subsecond: RegionField, SubsecondField { }

public struct MonthDay: RegionField, MonthField, DayField { }
public struct DayHour: RegionField, DayField, HourField { }
public struct HourMinute: RegionField, HourField, MinuteField { }
public struct MinuteSecond: RegionField, MinuteField, SecondField { }
public struct SecondSubsecond: RegionField, SecondField, SubsecondField { }

public struct MonthDayHour: RegionField, MonthField, DayField, HourField { }
public struct DayHourMinute: RegionField, DayField, HourField, MinuteField { }
public struct HourMinuteSecond: RegionField, HourField, MinuteField, SecondField { }
public struct MinuteSecondSubsecond: RegionField, MinuteField, SecondField, SubsecondField { }

public struct MonthDayHourMinute: RegionField, MonthField, DayField, HourField, MinuteField { }
public struct DayHourMinuteSecond: RegionField, DayField, HourField, MinuteField, SecondField { }
public struct HourMinuteSecondSubsecond: RegionField, TimeFields { }

public struct MonthDayHourMinuteSecond: RegionField, MonthField, DayField, HourField, MinuteField, SecondField { }
public struct DayHourMinuteSecondSubsecond: RegionField, DayField, TimeFields { }

public struct MonthDayHourMinuteSecondSubsecond: RegionField, MonthField, DayField, TimeFields { }

***/
 
