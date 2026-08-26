//
//  CalendarProtocol.swift
//  Time
//
//  Created by Dave DeLong on 8/26/26.
//

import Foundation

internal protocol CalendarProtocol: Sendable, CustomStringConvertible, CustomDebugStringConvertible {
    var identifier: Calendar.Identifier { get }
    var timeZone: TimeZone { get set }
    var locale: Locale? { get set }
    
    func isEquivalent(to other: any CalendarProtocol) -> Bool
    
    func date(from dateComponents: DateComponents) -> Date?
    func dateComponents(in timeZone: TimeZone, from date: Date) -> DateComponents
    func range(of unit: Calendar.Component, containing date: Date) -> Range<Date>
    
    func snapshot(forcedCopy: Bool) -> Self
    
    func maximumRange(of unit: Calendar.Component) -> Range<Int>?
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
}
