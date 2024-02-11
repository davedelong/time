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
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
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

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOEEra: Unit { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOEYear: LTOEEra { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOEMonth: LTOEYear { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOEDay: LTOEMonth { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOEHour: LTOEDay { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOEMinute: LTOEHour { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOESecond: LTOEMinute { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOENanosecond: LTOESecond { }


#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOENanosecond: Unit { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOESecond: GTOENanosecond { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOEMinute: GTOESecond { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOEHour: GTOEMinute { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOEDay: GTOEHour { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOEMonth: GTOEDay { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOEYear: GTOEMonth { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOEEra: GTOEYear { }

// A type used to prevent types outside of this package from adopting the Unit protocol

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public struct ProtocolCloser<U: Unit> {
    fileprivate init() { }
}

