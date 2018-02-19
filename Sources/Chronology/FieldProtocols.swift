//
//  FieldProtocols.swift
//  Chronology
//
//  Created by Dave DeLong on 2/18/18.
//

import Foundation

public protocol RegionField { }
public protocol EraField { }
public protocol YearField { }
public protocol MonthField { }
public protocol DayField { }
public protocol HourField { }
public protocol MinuteField { }
public protocol SecondField { }
public protocol SubsecondField { }

public protocol DateFields: RegionField, EraField, YearField, MonthField, DayField { }
public protocol TimeFields: HourField, MinuteField, SecondField, SubsecondField { }
public protocol DateTimeFields: DateFields, TimeFields { }

public protocol Anchored {
    var range: Range<Instant> { get }
}

// These structs are "anchored"
// This means that the values have all the necessary components to identify their range
// TODO: conform these to "Anchored"; this isn't in yet because doing so would add compiler errors
public struct Era: RegionField, EraField { }
public struct Year: RegionField, EraField, YearField { }
public struct YearMonth: RegionField, EraField, YearField, MonthField { }
public struct YearMonthDay: DateFields { }
public struct YearMonthDayHour: DateFields, HourField { }
public struct YearMonthDayHourMinute: DateFields, HourField, MinuteField { }
public struct YearMonthDayHourMinuteSecond: DateFields, HourField, MinuteField, SecondField { }
public struct YearMonthDayHourMinuteSecondSubsecond: DateFields, TimeFields { }

// These structs are "floating" (not anchored)
// They do not have enough information to identify their range
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
