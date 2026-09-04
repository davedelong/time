//
//  CalendarProtocol.swift
//  Time
//
//  Created by Dave DeLong on 8/26/26.
//

#if os(Linux)
@preconcurrency import Foundation
#else
import Foundation
#endif

internal protocol CalendarProtocol: _TimeSendable, CustomStringConvertible, CustomDebugStringConvertible, Hashable {
    var identifier: Calendar.Identifier { get }
    var timeZone: TimeZone { get set }
    var locale: Locale? { get set }
    
    func isEquivalent(to other: any CalendarProtocol) -> Bool
    
    func date(from dateComponents: DateComponents) -> Date?
    func dateComponents(in timeZone: TimeZone, from date: Date) -> DateComponents
    func dateComponents(_ unit: Set<Calendar.Component>, from start: Date, to end: Date) -> DateComponents
    func range(of unit: Calendar.Component, containing date: Date) -> Range<Date>
    
    func snapshot(forcedCopy: Bool) -> Self
    
    func maximumRange(of unit: Calendar.Component) -> Range<Int>?
    
    func isDateInWeekend(_ date: Date) -> Bool
    func component(_ unit: Calendar.Component, from date: Date) -> Int
    func ordinality(of unit: Calendar.Component, in larger: Calendar.Component, for date: Date) -> Int?
    func date(byAdding components: DateComponents, to date: Date, wrappingComponents: Bool) -> Date?
    
    func format(date: Date, using timeZone: TimeZone, locale: Locale, configuration: FormatConfiguration) -> String
    func format(range: Range<Date>, using timeZone: TimeZone, locale: Locale, configuration: FormatConfiguration) -> String
}

extension CalendarProtocol {
    func date(byAdding components: DateComponents, to date: Date) -> Date? {
        self.date(byAdding: components, to: date, wrappingComponents: false)
    }
}

extension Calendar: CalendarProtocol {
    func isEquivalent(to other: any CalendarProtocol) -> Bool {
        guard let otherCal = other as? Calendar else { return false }
        return self.isEquivalent(to: otherCal)
    }
    
    func range(of unit: Calendar.Component, containing date: Date) -> Range<Date> {
        var start = Date()
        var length: TimeInterval = 0
        let succeeded = self.dateInterval(of: unit, start: &start, interval: &length, for: date)
        require(succeeded, "We should always be able to get the range of a calendar component")
        
        return start ..< start.addingTimeInterval(length)
    }
    
    func isEquivalent(to other: Calendar) -> Bool {
        if self == other { return true }
        guard identifier == other.identifier else { return false }
        guard timeZone.isEquivalent(to: other.timeZone) else { return false }
        guard firstWeekday == other.firstWeekday else { return false }
        guard minimumDaysInFirstWeek == other.minimumDaysInFirstWeek else { return false }
        
        return true
    }
    
    func format(date: Date, using timeZone: TimeZone, locale: Locale, configuration: FormatConfiguration) -> String {
        
        let key = FormatterKey(configuration: configuration,
                               calendar: self,
                               locale: locale,
                               timeZone: timeZone)
        
        let df = DateFormatter.formatter(for: key)
        return df.string(from: date)
    }
    
    func format(range: Range<Date>, using timeZone: TimeZone, locale: Locale, configuration: FormatConfiguration) -> String {
        let key = FormatterKey(configuration: configuration,
                               calendar: self,
                               locale: locale,
                               timeZone: timeZone)
        
        let rf = DateIntervalFormatter.formatter(for: key)
        return rf.string(from: range.lowerBound, to: range.upperBound)
    }
}

extension Region {
    
    func format(date: Date, using configuration: FormatConfiguration) -> String {
        return self.anyCalendar.format(date: date,
                                       using: timeZone,
                                       locale: locale,
                                       configuration: configuration)
    }
    
    func format(range: Range<Date>, using configuration: FormatConfiguration) -> String {
        return self.anyCalendar.format(range: range,
                                       using: timeZone,
                                       locale: locale,
                                       configuration: configuration)
    }
    
}
