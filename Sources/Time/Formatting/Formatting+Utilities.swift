//
//  Formatting+Utilities.swift
//  
//
//  Created by Dave DeLong on 4/11/20.
//

import Foundation

private let minimumRequiredComponent: Dictionary<Character, Calendar.Component> = [
    "G": .era,
    "y": .year,
    "Y": .year,
    "u": .year,
    "U": .year,
    "r": .year,
    "Q": .month,
    "q": .month,
    "M": .month,
    "L": .month,
    "w": .day,
    "W": .day,
    "d": .day,
    "D": .day,
    "F": .day,
    "g": .day,
    "E": .day,
    "e": .day,
    "c": .day,
    "a": .hour,
    "b": .hour,
    "B": .hour,
    "h": .hour,
    "H": .hour,
    "k": .hour,
    "K": .hour,
    "m": .minute,
    "s": .second,
    "S": .nanosecond,
// these are ignored because we can always format a timezone, because all TimePeriods have a timezone
//    "z": .timeZone,
//    "Z": .timeZone,
//    "O": .timeZone,
//    "v": .timeZone,
//    "V": .timeZone,
//    "X": .timeZone,
//    "x": .timeZone
]

internal func calendarComponents(in rawFormatString: String) -> Set<Calendar.Component> {
    var components = Set<Calendar.Component>()
    var insideQuote = false
    for char in rawFormatString {
        if char == "'" {
            insideQuote = !insideQuote
        } else if insideQuote == false {
            if let unit = minimumRequiredComponent[char] {
                components.insert(unit)
            }
        }
    }
    return components
}
