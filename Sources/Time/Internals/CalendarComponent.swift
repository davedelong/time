//
//  File.swift
//

import Foundation

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
    
    internal var minimumRequiredComponent: Self {
        switch self {
            // all fixed values have a timezone,
            // so as long as it's a fixed value, the timezone requirement is satisfied
            case .era: return .era
            case .timeZone: return .era
                
            case .year: return .year
                
            case .month: return .month
            case .quarter: return .month
            case .isLeapMonth: return .month
            
            case .day: return .day
            case .weekday: return .day
            case .weekdayOrdinal: return .day
            case .weekOfMonth: return .day
            case .weekOfYear: return .day
            case .yearForWeekOfYear: return .day
                
            case .hour: return .hour
            case .minute: return .minute
            case .second: return .second
            case .nanosecond: return .nanosecond
                
            case .calendar:
                fatalError("Invalid calendar component: .calendar")
                
            @unknown default:
                return self
        }
    }
    
    init?(formatCharacter: Character) {
        switch formatCharacter {
            case "j": self = .day
            case "J": self = .day
            case "C": self = .hour
            case "G": self = .era
            case "y": self = .year
            case "Y": self = .yearForWeekOfYear
            case "u": self = .year
            case "U": self = .year
            case "r": self = .year
            case "Q": self = .quarter
            case "q": self = .quarter
            case "M": self = .month
            case "L": self = .month
            case "w": self = .weekOfYear
            case "W": self = .weekOfMonth
            case "d": self = .day
                
            // TODO: dayOfYear: https://github.com/apple/swift-foundation/blob/main/Proposals/0001-calendar-improvements.md
            case "D": self = .day
            case "F": self = .weekdayOrdinal
            case "g": self = .day // Julian day, technically
            case "E": self = .weekday
            case "e": self = .weekday
            case "c": self = .weekday
            case "a": self = .hour
            case "b": self = .hour
            case "B": self = .hour
            case "h": self = .hour
            case "H": self = .hour
            case "k": self = .hour
            case "K": self = .hour
            case "m": self = .minute
            case "s": self = .second
            case "S": self = .nanosecond
            case "A": self = .nanosecond
            case "z": self = .timeZone
            case "Z": self = .timeZone
            case "O": self = .timeZone
            case "v": self = .timeZone
            case "V": self = .timeZone
            case "X": self = .timeZone
            case "x": self = .timeZone
            default: return nil
        }
    }
}
