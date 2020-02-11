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

public protocol LTOEEra: Unit { }
public protocol LTOEYear: LTOEEra { }
public protocol LTOEMonth: LTOEYear { }
public protocol LTOEDay: LTOEMonth { }
public protocol LTOEHour: LTOEDay { }
public protocol LTOEMinute: LTOEHour { }
public protocol LTOESecond: LTOEMinute { }
public protocol LTOENanosecond: LTOESecond { }

public protocol GTOENanosecond: Unit { }
public protocol GTOESecond: GTOENanosecond { }
public protocol GTOEMinute: GTOESecond { }
public protocol GTOEHour: GTOEMinute { }
public protocol GTOEDay: GTOEHour { }
public protocol GTOEMonth: GTOEDay { }
public protocol GTOEYear: GTOEMonth { }
public protocol GTOEEra: GTOEYear { }

public struct Nanosecond: Unit, LTOENanosecond, GTOENanosecond {
    public static let component: Calendar.Component = .nanosecond
    private init() { }
}

public struct Second: Unit, LTOESecond, GTOESecond {
    public static let component: Calendar.Component = .second
    private init() { }
}

public struct Minute: Unit, LTOEMinute, GTOEMinute {
    public static let component: Calendar.Component = .minute
    private init() { }
}

public struct Hour: Unit, LTOEHour, GTOEHour {
    public static let component: Calendar.Component = .hour
    private init() { }
}

public struct Day: Unit, LTOEDay, GTOEDay {
    public static let component: Calendar.Component = .day
    private init() { }
}

public struct Month: Unit, LTOEMonth, GTOEMonth {
    public static let component: Calendar.Component = .month
    private init() { }
}

public struct Year: Unit, LTOEYear, GTOEYear {
    public static let component: Calendar.Component = .year
    private init() { }
}

public struct Era: Unit, LTOEEra, GTOEEra {
    public static let component: Calendar.Component = .era
    private init() { }
}

internal func componentsFrom<L: Unit, U: Unit>(lower: L.Type, to upper: U.Type) -> Set<Calendar.Component> {
    let order = Calendar.Component.ascendingOrder
    guard let lowerIndex = order.firstIndex(of: L.component) else { return [] }
    guard let upperIndex = order.firstIndex(of: U.component) else { return [] }
    guard lowerIndex <= upperIndex else { return [] }
    
    let components = order[lowerIndex ... upperIndex]
    return Set(components)
}

