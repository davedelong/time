//
//  Units.swift
//

import Foundation

/**
 
 These types form the basis of how the library defines calendrical values.
 
 For the most part, you should never need to interact with anything in this file.
 
 */

// the @_documentation attribute is from https://github.com/apple/swift/pull/60242

/// The base protocol for defining calendrical units
///
/// - Warning: You may not implement this protocol.
public protocol Unit {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    static var _closer: ProtocolCloser<Self> { get }
    static var component: Calendar.Component { get }
}

/// The representation of nanoseconds to the Swift type system
///
/// This type is always used as a generic parameter, such as in `Fixed<Nanosecond>`.
public enum Nanosecond: Unit, LTOENanosecond, GTOENanosecond {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.nanosecond` calendar component
    public static let component: Calendar.Component = .nanosecond
}

/// The representation of seconds to the Swift type system
public enum Second: Unit, LTOESecond, GTOESecond {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.second` calendar component
    public static let component: Calendar.Component = .second
}

/// The representation of minutes to the Swift type system
public enum Minute: Unit, LTOEMinute, GTOEMinute {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.minute` calendar component
    public static let component: Calendar.Component = .minute
}

/// The representation of hours to the Swift type system
public enum Hour: Unit, LTOEHour, GTOEHour {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.hour` calendar component
    public static let component: Calendar.Component = .hour
}

/// The representation of days to the Swift type system
public enum Day: Unit, LTOEDay, GTOEDay {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.day` calendar component
    public static let component: Calendar.Component = .day
}

/// The representation of months to the Swift type system
public enum Month: Unit, LTOEMonth, GTOEMonth {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.month` calendar component
    public static let component: Calendar.Component = .month
}

/// The representation of years to the Swift type system
public enum Year: Unit, LTOEYear, GTOEYear {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.year` calendar component
    public static let component: Calendar.Component = .year
}

/// The representation of eras to the Swift type system
public enum Era: Unit, LTOEEra, GTOEEra {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.era` calendar component
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

// A type used to prevent external types from adopting the Unit protocol

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public struct ProtocolCloser<U: Unit> {
    fileprivate init() { }
}

