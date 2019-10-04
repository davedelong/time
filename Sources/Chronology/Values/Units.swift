//
//  Units.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public protocol Unit {
    static var component: Calendar.Component { get }
}

internal protocol LessThanEternity: Unit { }
internal protocol LessThanEra: LessThanEternity { }
internal protocol LessThanYear: LessThanEra { }
internal protocol LessThanMonth: LessThanYear { }
internal protocol LessThanDay: LessThanMonth { }
internal protocol LessThanHour: LessThanDay { }
internal protocol LessThanMinute: LessThanHour { }
internal protocol LessThanSecond: LessThanMinute { }
internal protocol LessThanNanosecond: LessThanSecond { }

internal protocol GreaterThanNanosecond: Unit { }
internal protocol GreaterThanSecond: GreaterThanNanosecond { }
internal protocol GreaterThanMinute: GreaterThanSecond { }
internal protocol GreaterThanHour: GreaterThanMinute { }
internal protocol GreaterThanDay: GreaterThanHour { }
internal protocol GreaterThanMonth: GreaterThanDay { }
internal protocol GreaterThanYear: GreaterThanMonth { }

public struct Nanosecond: Unit, LessThanSecond {
    public static let component: Calendar.Component = .nanosecond
    private init() { }
}

public struct Second: Unit, LessThanMinute, GreaterThanNanosecond {
    public static let component: Calendar.Component = .second
    private init() { }
}

public struct Minute: Unit, LessThanHour, GreaterThanSecond {
    public static let component: Calendar.Component = .minute
    private init() { }
}

public struct Hour: Unit, LessThanDay, GreaterThanMinute {
    public static let component: Calendar.Component = .hour
    private init() { }
}

public struct Day: Unit, LessThanMonth, GreaterThanHour {
    public static let component: Calendar.Component = .day
    private init() { }
}

public struct Month: Unit, LessThanYear, GreaterThanDay {
    public static let component: Calendar.Component = .month
    private init() { }
}

public struct Year: Unit, LessThanEra, GreaterThanMonth {
    public static let component: Calendar.Component = .year
    private init() { }
}

public struct Era: Unit, LessThanEternity, GreaterThanYear {
    public static let component: Calendar.Component = .era
    private init() { }
}

internal func componentsFrom<L: Unit, U: Unit>(lower: L.Type, to upper: U.Type) -> Set<Calendar.Component> {
    let order = Calendar.Component.order
    guard let lowerIndex = order.firstIndex(of: L.component) else { return [] }
    guard let upperIndex = order.firstIndex(of: U.component) else { return [] }
    guard lowerIndex <= upperIndex else { return [] }
    
    let components = order[lowerIndex ... upperIndex]
    return Set(components)
}

