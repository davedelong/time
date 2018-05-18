//
//  FloatingFormatting.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

extension CalendarValue {
    
    internal func formatFloating(using: Array<Format?>) -> String {
        let template = using.compactMap { $0?.template }.joined()
        let localizedFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.timeZone = timeZone
        formatter.locale = locale
        formatter.dateFormat = localizedFormat
        
        let date: Date
        if let potential = calendar.date(from: dateComponents) {
            date = potential
        } else if let future = calendar.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .strict) {
            date = future
        } else if let past = calendar.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .strict, direction: .backward) {
            date = past
        } else {
            fatalError("Unable to construct date matching \(dateComponents)")
        }
        
        return formatter.string(from: date)
    }
    
}

public extension CalendarValue where Self: YearField {
    func format(year: FormatTemplate<YearField>) -> String {
        return formatFloating(using: [year])
    }
}

public extension CalendarValue where Self: MonthField {
    func format(month: FormatTemplate<Standalone<MonthField>>) -> String {
        return formatFloating(using: [month])
    }
}

public extension CalendarValue where Self: DayField {
    func format(day: FormatTemplate<DayField>) -> String {
        return formatFloating(using: [day])
    }
    func format(weekday: FormatTemplate<Standalone<Weekday>>) -> String {
        return formatFloating(using: [weekday])
    }
}

public extension CalendarValue where Self: HourField {
    func format(hour: FormatTemplate<HourField>) -> String {
        return formatFloating(using: [hour])
    }
}

public extension CalendarValue where Self: MinuteField {
    func format(minute: FormatTemplate<MinuteField>) -> String {
        return formatFloating(using: [minute])
    }
}

public extension CalendarValue where Self: SecondField {
    func format(second: FormatTemplate<SecondField>) -> String {
        return formatFloating(using: [second])
    }
}

public extension CalendarValue where Self: NanosecondField {
    func format(nanosecond: FormatTemplate<NanosecondField>) -> String {
        return formatFloating(using: [nanosecond])
    }
}
