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
        self.calendar = calendar
        self.timeZone = timeZone
        self.locale = locale
    }
    
}

public protocol RegionField {
    
    var region: Region { get }
    
}

public extension RegionField {
    
    var calendar: Calendar { return region.calendar }
    var timeZone: TimeZone { return region.timeZone }
    var locale: Locale { return region.locale }
    
}
