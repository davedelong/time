import Foundation

// protocols used to define relative unit durations

// MARK: - Less Than

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTEra: Unit { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTYear: LTEra { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTMonth: LTYear { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTDay: LTMonth { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTHour: LTDay { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTMinute: LTHour { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTSecond: LTMinute { }

// MARK: - Greater Than

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTNanosecond: Unit { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTSecond: GTNanosecond { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTMinute: GTSecond { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTHour: GTMinute { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTDay: GTHour { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTMonth: GTDay { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTYear: GTMonth { }

// MARK: - Less Than Or Equal

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOEEra: Unit { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOEYear: LTOEEra, LTEra { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOEMonth: LTOEYear, LTYear { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOEDay: LTOEMonth, LTMonth { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOEHour: LTOEDay, LTDay { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOEMinute: LTOEHour, LTHour { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOESecond: LTOEMinute, LTMinute { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol LTOENanosecond: LTOESecond, LTSecond { }

// MARK: - Greater Than Or Equal

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOENanosecond: Unit { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOESecond: GTOENanosecond, GTNanosecond { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOEMinute: GTOESecond, GTSecond { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOEHour: GTOEMinute, GTMinute { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOEDay: GTOEHour, GTHour { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOEMonth: GTOEDay, GTDay { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOEYear: GTOEMonth, GTMonth { }

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public protocol GTOEEra: GTOEYear, GTYear { }

// A type used to prevent external types from adopting the Unit protocol

// MARK: -

#if swift(>=5.8)
@_documentation(visibility: internal)
#endif
public struct ProtocolCloser<U: Unit> {
    internal init() { }
}
