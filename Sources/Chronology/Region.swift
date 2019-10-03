//
//  Region.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Region {
    
    public static let current = Region(calendar: .current, timeZone: .current, locale: .current)
    public static let currentUTC = Region(calendar: .current, timeZone: TimeZone(secondsFromGMT: 0)!, locale: .current)
    public static let autoupdatingCurrent = Region(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, locale: .autoupdatingCurrent)
    
    public let calendar: Calendar
    public let timeZone: TimeZone
    public let locale: Locale
    
    public init(calendar: Calendar, timeZone: TimeZone, locale: Locale) {
        var actualCalendar = calendar
        actualCalendar.timeZone = timeZone
        actualCalendar.locale = locale
        
        self.calendar = actualCalendar
        self.timeZone = timeZone
        self.locale = locale
    }
    
    internal func components(_ components: Set<Calendar.Component>, from date: Date) -> DateComponents {
        let dc = calendar.dateComponents(in: timeZone, from: date)
        return dc.requireAndRestrict(to: components)
    }
    
}
