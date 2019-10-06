//
//  Formatting.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

internal protocol Format {
    var template: String { get }
}

extension Value {
    
    static func fullFormats() -> Array<Format?> {
        var f = Array<Format?>()
        
        let order = Calendar.Component.descendingOrder
        let represented = Self.representedComponents
        
        let isAbsolute = represented.contains(.era)
        
        for unit in order {
            guard represented.contains(unit) else { continue }
            switch unit {
                case .era: f.append(Template<Era>.abbreviated)
                case .year: f.append(Template<Year>.full)
                case .month: f.append(Template<Month>.fullName)
                case .day:
                    if isAbsolute { f.append(Template<Weekday>.fullName) }
                    f.append(Template<Day>.full)
                case .hour: f.append(Template<Hour>.full())
                case .minute: f.append(Template<Minute>.full)
                case .second: f.append(Template<Second>.full)
                case .nanosecond: f.append(Template<Nanosecond>.digits(4))
                default: continue
            }
        }
        f.append(Template<TimeZone>.shortSpecific)
        
        return f
    }
    
    internal func formatFull() -> String {
        return format(relative: Value.fullFormats())
    }
    
    internal func format(date: Date, using: Array<Format?>) -> String {
        let template = using.compactMap { $0?.template }.joined()
        let localizedFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.timeZone = timeZone
        formatter.locale = locale
        formatter.dateFormat = localizedFormat
        
        return formatter.string(from: date)
    }
    
    internal func format(relative: Array<Format?>) -> String {
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
        
        return format(date: date, using: relative)
    }
    
}

extension Value where Largest: GTOEEra {
    
    internal func format(absolute: Array<Format?>) -> String {
        return format(date: approximateMidPoint.date, using: absolute)
    }
    
}
