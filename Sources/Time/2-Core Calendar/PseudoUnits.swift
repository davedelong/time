import Foundation

/// The representation of weeks to the Swift type system
///
/// This type is always used as a generic parameter, such as in `Fixed<Week>`.
public enum Week: PseudoUnit, LTMonth, LTOEMonth, GTDay, GTOEDay {
    #if swift(>=5.8)
    @_documentation(visibility: internal)
    #endif
    public static let _closer: ProtocolCloser<Self> = ProtocolCloser()
    
    /// This type represents the `.nanosecond` calendar component
    public static let component: Calendar.Component = .weekOfYear
    
    public static let requiredComponent: Calendar.Component = .day
}
