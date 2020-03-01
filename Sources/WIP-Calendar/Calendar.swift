//
//  Calendar.swift
//  
//
//  Created by Dave DeLong on 2/11/20.
//

import Foundation

public class CalendarType: Hashable {
    
    public static func ==(lhs: CalendarType, rhs: CalendarType) -> Bool { return lhs.native == rhs.native }
    public static let autoupdatingCurrent: CalendarType = .init(.autoupdatingCurrent)
    
    internal var native: Foundation.Calendar
    
    internal init(_ native: Foundation.Calendar) {
        self.native = native
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(native)
    }
    
    // These are the methods on Foundation.Calendar that are used by Time
    // If we ever decide to abstract out a calendar (to allow for easier creation of custom ones)
    // then this is the base functionality we'll need (as of 2/2020).
    // The BIG thing that's missing here is formatting.
    
    var timeZone: TimeZone {
        get { native.timeZone }
        set { native.timeZone = newValue }
    }
    
    var locale: Locale {
        get { native.locale! }
        set { native.locale = newValue }
    }
    
    var firstWeekday: Int {
        get { native.firstWeekday }
        set { native.firstWeekday = newValue }
    }
    
    var SISecondsPerSecond: Double { return 1.0 }
    var isAutoupdating: Bool { return native == .autoupdatingCurrent }
    var isEraRelevant: Bool { return native.identifier == .japanese }
    
    func date(from components: DateComponents) -> Date? {
        return native.date(from: components)
    }
    
    func dateComponents(in timeZone: TimeZone, from date: Date) -> DateComponents {
        return native.dateComponents(in: timeZone, from: date)
    }
    
    func dateComponents(_ components: Set<Calendar.Component>, from date: Date) -> DateComponents {
        return native.dateComponents(components, from: date)
    }
    
    func nextDate(after date: Date, matching components: DateComponents, matchingPolicy: Calendar.MatchingPolicy, repeatedTimePolicy: Calendar.RepeatedTimePolicy = .first, direction: Calendar.SearchDirection = .forward) -> Date? {
        return native.nextDate(after: date, matching: components, matchingPolicy: matchingPolicy, repeatedTimePolicy: repeatedTimePolicy, direction: direction)
    }
    
    func dateComponents(_ components: Set<Calendar.Component>, from start: Date, to end: Date) -> DateComponents {
        return native.dateComponents(components, from: start, to: end)
    }
    
    func date(byAdding dateComponents: DateComponents, to date: Date) -> Date? {
        return native.date(byAdding: dateComponents, to: date)
    }
    
    func dateInterval(of unit: Calendar.Component, start: inout Date, interval: inout TimeInterval, for date: Date) -> Bool {
        return native.dateInterval(of: unit, start: &start, interval: &interval, for: date)
    }
    
    func component(_ component: Calendar.Component, from date: Date) -> Int {
        return native.component(component, from: date)
    }
    
    func isDateInWeekend(_ date: Date) -> Bool {
        return native.isDateInWeekend(date)
    }
    
    func ordinality(of unit: Calendar.Component, in larger: Calendar.Component, for date: Date) -> Int? {
        return native.ordinality(of: unit, in: larger, for: date)
    }
}
