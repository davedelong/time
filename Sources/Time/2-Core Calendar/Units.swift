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
    static var requiredComponent: Calendar.Component { get }
}

extension Unit {
    public static var requiredComponent: Calendar.Component { self.component }
}

public protocol StandardUnit: Unit { }

public protocol PseudoUnit: Unit { }

/// The representation of nanoseconds to the Swift type system
///
/// This type is always used as a generic parameter, such as in `Fixed<Nanosecond>`.
public enum Nanosecond: StandardUnit, LTOENanosecond, GTOENanosecond {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.nanosecond` calendar component
    public static let component: Calendar.Component = .nanosecond
}

/// The representation of seconds to the Swift type system
public enum Second: StandardUnit, LTOESecond, GTOESecond {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.second` calendar component
    public static let component: Calendar.Component = .second
}

/// The representation of minutes to the Swift type system
public enum Minute: StandardUnit, LTOEMinute, GTOEMinute {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.minute` calendar component
    public static let component: Calendar.Component = .minute
}

/// The representation of hours to the Swift type system
public enum Hour: StandardUnit, LTOEHour, GTOEHour {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.hour` calendar component
    public static let component: Calendar.Component = .hour
}

/// The representation of days to the Swift type system
public enum Day: StandardUnit, LTOEDay, GTOEDay {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.day` calendar component
    public static let component: Calendar.Component = .day
}

/// The representation of months to the Swift type system
public enum Month: StandardUnit, LTOEMonth, GTOEMonth {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.month` calendar component
    public static let component: Calendar.Component = .month
}

/// The representation of years to the Swift type system
public enum Year: StandardUnit, LTOEYear, GTOEYear {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.year` calendar component
    public static let component: Calendar.Component = .year
}

/// The representation of eras to the Swift type system
public enum Era: StandardUnit, LTOEEra, GTOEEra {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.era` calendar component
    public static let component: Calendar.Component = .era
}

