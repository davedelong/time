//
//  Formatting.swift
//  Time
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

internal protocol Format {
    var template: String { get }
}

extension Value {
    
    static func fullFormats(in calendar: Calendar) -> Array<Format?> {
        var f = Array<Format?>()
        
        let order = Calendar.Component.descendingOrder
        let represented = Self.representedComponents
        
        let isAbsolute = represented.contains(.era)
        
        for unit in order {
            guard represented.contains(unit) else { continue }
            switch unit {
                case .era:
                    if calendar.isEraRelevant { f.append(Template<Era>.abbreviated) }
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
        if isAbsolute { f.append(Template<TimeZone>.shortSpecific) }
        
        return f
    }
    
    internal func dateForFormatting() -> Date {
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
        return date
    }
    
    internal func formatFull() -> String {
        return format(Value.fullFormats(in: calendar))
    }
        
    internal func format(_ formats: Array<Format?>) -> String {
        let template = formats.compactMap { $0?.template }.joined()
        let df = DateFormatterCache.shared.formatter(for: template, region: region)
        return df.string(from: dateForFormatting())
    }
    
    internal func formatUsing(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let df = DateFormatterCache.shared.formatter(for: dateStyle, timeStyle: timeStyle, region: region)
        return df.string(from: dateForFormatting())
    }
    
}

extension Absolute where Largest == Era {
    
    internal func dateForFormatting() -> Date {
        return approximateMidPoint.date
    }
    
}
