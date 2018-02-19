//
//  __Fields.swift
//  Chronology
//
//  Created by Dave DeLong on 11/30/17.
//

import Foundation

// field definitions
protocol CalendarField { var calendar: Calendar { get } }
protocol RegionField: CalendarField { var region: Locale { get } } // TODO: replace with "Region"

protocol ComponentField { }
protocol EraField: ComponentField { var era: Int { get } }
protocol YearField: ComponentField { var yearOfEra: Int { get } }
protocol MonthField: ComponentField { var monthOfYear: Int { get } }
protocol DayField: ComponentField { var dayOfMonth: Int { get } }
protocol HourField: ComponentField { var hourOfDay: Int { get } }
protocol MinuteField: ComponentField { var minuteOfHour: Int { get } }
protocol SecondField: ComponentField { var secondOfMinute: Int { get } }
protocol NanosecondField: ComponentField { var nanosecondOfSecond: Int { get } }
