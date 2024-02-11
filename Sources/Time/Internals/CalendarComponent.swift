//
//  File.swift
//  
//
//  Created by Dave DeLong on 1/21/24.
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
// these are ignored because we can always format a timezone, because all Fixed<U> have a timezone
//    "z": .timeZone,
//    "Z": .timeZone,
//    "O": .timeZone,
//    "v": .timeZone,
//    "V": .timeZone,
//    "X": .timeZone,
//    "x": .timeZone
]

extension Calendar.Component {
    
    internal static let ascendingOrder: Array<Calendar.Component> = [.nanosecond, .second, .minute, .hour, .day, .month, .year, .era]
    internal static let descendingOrder: Array<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second, .nanosecond]
    
    internal static func smallest(from units: Set<Calendar.Component>) -> Calendar.Component {
        for unit in ascendingOrder {
            if units.contains(unit) { return unit }
        }
        fatalError("Cannot determine smallest unit in \(units)")
    }
    
    internal static func largest(from units: Set<Calendar.Component>) -> Calendar.Component {
        for unit in descendingOrder {
            if units.contains(unit) { return unit }
        }
        fatalError("Cannot determine largest unit in \(units)")
    }
    
    internal static func from<L: Unit, U: Unit>(lower: L.Type, to upper: U.Type) -> Set<Calendar.Component> {
        let order = Calendar.Component.ascendingOrder
        guard let lowerIndex = order.firstIndex(of: L.component) else { return [] }
        guard let upperIndex = order.firstIndex(of: U.component) else { return [] }
        guard lowerIndex <= upperIndex else { return [] }
        
        let components = order[lowerIndex ... upperIndex]
        return Set(components)
    }
    
    internal static func components(in rawFormatString: String) -> Set<Calendar.Component> {
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
    
    internal var nextLargest: Self? {
        guard let index = Self.ascendingOrder.firstIndex(of: self) else { return nil }
        let nextIndex = index + 1
        guard nextIndex < Self.ascendingOrder.endIndex else { return nil }
        return Self.ascendingOrder[nextIndex]
    }
    
    internal var nextSmallest: Self? {
        guard let index = Self.ascendingOrder.firstIndex(of: self) else { return nil }
        let nextIndex = index - 1
        guard nextIndex > 0 else { return nil }
        return Self.ascendingOrder[nextIndex]
    }
}
