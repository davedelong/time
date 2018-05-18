//
//  Anchored.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 5/17/18.
//

import Foundation

extension CalendarValue where Self: Anchored {
    
    internal func formatAnchored(using: Array<Format?>) -> String {
        let template = using.compactMap { $0?.template }.joined()
        let localizedFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.timeZone = timeZone
        formatter.locale = locale
        formatter.dateFormat = localizedFormat
        
        return formatter.string(from: approximateMidPoint.date)
    }
    
}

public extension Anchored where Self: EraField {
    func format(era: FormatTemplate<EraField>) -> String {
        return formatAnchored(using: [era])
    }
}

public extension Anchored where Self: YearField {
    func format(era: FormatTemplate<EraField>? = nil,
                year: FormatTemplate<YearField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return formatAnchored(using: [era, year, timeZone])
    }
}

public extension Anchored where Self: MonthField {
    func format(era: FormatTemplate<EraField>? = nil,
                year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return formatAnchored(using: [era, year, month, timeZone])
    }
}

public extension Anchored where Self: DayField {
    func format(era: FormatTemplate<EraField>? = nil,
                year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                weekday: FormatTemplate<Weekday>? = nil,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return formatAnchored(using: [era, year, month, day, weekday, timeZone])
    }
}

public extension Anchored where Self: HourField {
    func format(era: FormatTemplate<EraField>? = nil,
                year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                weekday: FormatTemplate<Weekday>? = nil,
                hour: FormatTemplate<HourField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return formatAnchored(using: [era, year, month, day, weekday, hour, timeZone])
    }
}

public extension Anchored where Self: MinuteField {
    func format(era: FormatTemplate<EraField>? = nil,
                year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                weekday: FormatTemplate<Weekday>? = nil,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return formatAnchored(using: [era, year, month, day, weekday, hour, minute, timeZone])
    }
}

public extension Anchored where Self: SecondField {
    func format(era: FormatTemplate<EraField>? = nil,
                year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                weekday: FormatTemplate<Weekday>? = nil,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return formatAnchored(using: [era, year, month, day, weekday, hour, minute, second, timeZone])
    }
}

public extension Anchored where Self: NanosecondField {
    func format(era: FormatTemplate<EraField>? = nil,
                year: FormatTemplate<YearField>,
                month: FormatTemplate<MonthField>,
                day: FormatTemplate<DayField>,
                weekday: FormatTemplate<Weekday>? = nil,
                hour: FormatTemplate<HourField>,
                minute: FormatTemplate<MinuteField>,
                second: FormatTemplate<SecondField>,
                nanosecond: FormatTemplate<NanosecondField>,
                timeZone: FormatTemplate<TimeZone>? = nil) -> String {
        return formatAnchored(using: [era, year, month, day, weekday, hour, minute, second, nanosecond, timeZone])
    }
}
