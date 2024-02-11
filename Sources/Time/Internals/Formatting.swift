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

extension Fixed {
    
    static func naturalFormats(in calendar: Calendar) -> Array<Format?> {
        var f = Array<Format?>()
        
        let order = Calendar.Component.descendingOrder
        let represented = Self.representedComponents
        
        for unit in order {
            guard represented.contains(unit) else { continue }
            switch unit {
                case .era:
                    if calendar.isEraRelevant { f.append(Template<Era>.abbreviated) }
                case .year: f.append(Template<Year>.naturalDigits)
                case .month: f.append(Template<Month>.naturalName)
                case .day:
                    f.append(Template<Weekday>.naturalName)
                    f.append(Template<Day>.naturalDigits)
                case .hour: f.append(Template<Hour>.naturalDigits)
                case .minute: f.append(Template<Minute>.naturalDigits)
                case .second: f.append(Template<Second>.naturalDigits)
                case .nanosecond: f.append(Template<Nanosecond>.digits(4))
                default: continue
            }
        }
        f.append(Template<TimeZone>.shortSpecific)
        
        return f
    }
    
    internal func dateForFormatting() -> Date {
        return firstInstant.date
    }
    
}
