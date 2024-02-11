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

// the @_documentation attribute is from https://github.com/apple/swift/pull/60242

public protocol Unit {
    @_documentation(visibility: internal)
    static var _closer: ProtocolCloser<Self> { get }
    static var component: Calendar.Component { get }
}

public enum Nanosecond: Unit, LTOENanosecond, GTOENanosecond {
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .nanosecond
}

public enum Second: Unit, LTOESecond, GTOESecond {
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .second
}

public enum Minute: Unit, LTOEMinute, GTOEMinute {
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .minute
}

public enum Hour: Unit, LTOEHour, GTOEHour {
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .hour
}

public enum Day: Unit, LTOEDay, GTOEDay {
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .day
}

public enum Month: Unit, LTOEMonth, GTOEMonth {
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .month
}

public enum Year: Unit, LTOEYear, GTOEYear {
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .year
}

public enum Era: Unit, LTOEEra, GTOEEra {
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    public static let component: Calendar.Component = .era
}

// protocols used to define relative unit durations

@_documentation(visibility: internal)
public protocol LTOEEra: Unit { }

@_documentation(visibility: internal)
public protocol LTOEYear: LTOEEra { }

@_documentation(visibility: internal)
public protocol LTOEMonth: LTOEYear { }

@_documentation(visibility: internal)
public protocol LTOEDay: LTOEMonth { }

@_documentation(visibility: internal)
public protocol LTOEHour: LTOEDay { }

@_documentation(visibility: internal)
public protocol LTOEMinute: LTOEHour { }

@_documentation(visibility: internal)
public protocol LTOESecond: LTOEMinute { }

@_documentation(visibility: internal)
public protocol LTOENanosecond: LTOESecond { }


@_documentation(visibility: internal)
public protocol GTOENanosecond: Unit { }

@_documentation(visibility: internal)
public protocol GTOESecond: GTOENanosecond { }

@_documentation(visibility: internal)
public protocol GTOEMinute: GTOESecond { }

@_documentation(visibility: internal)
public protocol GTOEHour: GTOEMinute { }

@_documentation(visibility: internal)
public protocol GTOEDay: GTOEHour { }

@_documentation(visibility: internal)
public protocol GTOEMonth: GTOEDay { }

@_documentation(visibility: internal)
public protocol GTOEYear: GTOEMonth { }

@_documentation(visibility: internal)
public protocol GTOEEra: GTOEYear { }

// A type used to prevent types outside of this package from adopting the Unit protocol

@_documentation(visibility: internal)
public struct ProtocolCloser<U: Unit> {
    fileprivate init() { }
}

