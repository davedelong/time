//
//  Units.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

/**
 
 These types form the basis of how the library defines calendrical values.
 
 For the most part, you should never need to interact with anything in this file.
 
 */

public protocol Unit {
    static var closer: ProtocolCloser<Self> { get }
    static var component: Calendar.Component { get }
}

public struct Nanosecond: Unit, _LTOENanosecond, _GTOENanosecond {
    public static let closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .nanosecond
    private init() { }
}

public struct Second: Unit, _LTOESecond, _GTOESecond {
    public static let closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .second
    private init() { }
}

public struct Minute: Unit, _LTOEMinute, _GTOEMinute {
    public static let closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .minute
    private init() { }
}

public struct Hour: Unit, _LTOEHour, _GTOEHour {
    public static let closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .hour
    private init() { }
}

public struct Day: Unit, _LTOEDay, _GTOEDay {
    public static let closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .day
    private init() { }
}

public struct Month: Unit, _LTOEMonth, _GTOEMonth {
    public static let closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .month
    private init() { }
}

public struct Year: Unit, _LTOEYear, _GTOEYear {
    public static let closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .year
    private init() { }
}

public struct Era: Unit, _LTOEEra, _GTOEEra {
    public static let closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .era
    private init() { }
}

// protocols used to define relative unit durations
public protocol _LTOEEra: Unit { }
public protocol _LTOEYear: _LTOEEra { }
public protocol _LTOEMonth: _LTOEYear { }
public protocol _LTOEDay: _LTOEMonth { }
public protocol _LTOEHour: _LTOEDay { }
public protocol _LTOEMinute: _LTOEHour { }
public protocol _LTOESecond: _LTOEMinute { }
public protocol _LTOENanosecond: _LTOESecond { }

public protocol _GTOENanosecond: Unit { }
public protocol _GTOESecond: _GTOENanosecond { }
public protocol _GTOEMinute: _GTOESecond { }
public protocol _GTOEHour: _GTOEMinute { }
public protocol _GTOEDay: _GTOEHour { }
public protocol _GTOEMonth: _GTOEDay { }
public protocol _GTOEYear: _GTOEMonth { }
public protocol _GTOEEra: _GTOEYear { }

public struct ProtocolCloser<U: Unit> {
    fileprivate init() { }
}

internal func componentsFrom<L: Unit, U: Unit>(lower: L.Type, to upper: U.Type) -> Set<Calendar.Component> {
    let order = Calendar.Component.ascendingOrder
    guard let lowerIndex = order.firstIndex(of: L.component) else { return [] }
    guard let upperIndex = order.firstIndex(of: U.component) else { return [] }
    guard lowerIndex <= upperIndex else { return [] }
    
    let components = order[lowerIndex ... upperIndex]
    return Set(components)
}

