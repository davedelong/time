//
//  TimeError.swift
//

#if os(Linux)
@preconcurrency import Foundation
#else
import Foundation
#endif

/// A  type describing the possible ways that a calendrical operation might fail
public struct TimeError: Error, Sendable, CustomStringConvertible {
    
    /// The specific operation that failed
    public enum Reason: Hashable, Sendable {
        
        /// An operation failed because some units that are required were missing
        case missingUnits
        
        /// An operation failed because the supplied components were not valid
        case invalidComponents
        
        /// An operation failed because a supplied format string was incorrect
        case invalidFormatString
        
        /// An operation failed because a supplied date string was incorrect
        case invalidValueString
        
        /// An error occured while decoding a fixed value
        case decodingError
    }
    
    /// The reason the operation failed
    public let reason: Reason
    
    /// Any units that were incorrect
    public let units: Set<Calendar.Component>?
    
    /// The incorrect `DateComponents`, if any
    public let dateComponents: DateComponents?
    
    /// The region used as part of the operation that failed, if any
    public let region: Region?
    
    /// The format string used in the failing operation, if any
    public let formatString: String?
    
    /// The date string used in the failing operation, if any
    public let valueString: String?
    
    /// Another error that occurred during the operation, if any
    public let underlyingError: Error?
    
    /// An unlocalized and developer-readable description of the error
    public let description: String
    
}

extension TimeError {
    
    internal static func missingCalendarComponents(_ units: Set<Calendar.Component>, 
                                                   in dateComponents: DateComponents? = nil,
                                                   description: String? = nil) -> TimeError {
        
        let resolvedDescription: String
        if let description {
            resolvedDescription = description
        } else if let dateComponents {
            resolvedDescription = "The date components \(dateComponents) is missing units: \(units)"
        } else {
            resolvedDescription = "Required units are missing: \(units)"
        }
        
        return .init(reason: .missingUnits,
                     units: units,
                     dateComponents: dateComponents,
                     region: nil,
                     formatString: nil,
                     valueString: nil,
                     underlyingError: nil,
                     description: resolvedDescription)
    }
    
    internal static func invalidDateComponents(_ components: DateComponents,
                                               units: Set<Calendar.Component>? = nil,
                                               in region: Region,
                                               description: String? = nil) -> TimeError {
        
        return .init(reason: .invalidComponents,
                     units: units ?? components.representedComponents,
                     dateComponents: components,
                     region: region,
                     formatString: nil,
                     valueString: nil,
                     underlyingError: nil,
                     description: description ?? "The provided date components (\(components)) cannot be correctly interpreted in the \(region) region")
    }
    
    internal static func invalidFormatString(_ string: String,
                                             units: Set<Calendar.Component>? = nil,
                                             description: String? = nil) -> TimeError {
        
        return .init(reason: .invalidFormatString,
                     units: units,
                     dateComponents: nil,
                     region: nil,
                     formatString: string,
                     valueString: nil,
                     underlyingError: nil,
                     description: description ?? "Invalid format string: '\(string)'")
    }
    
    internal static func cannotParseString(_ valueString: String,
                                           formatString: String? = nil,
                                           units: Set<Calendar.Component>? = nil,
                                           in region: Region,
                                           description: String? = nil) -> TimeError {
        
        let resolvedDescription: String
        if let description {
            resolvedDescription = description
        } else if let formatString {
            resolvedDescription = "Cannot parse string '\(valueString)' with format '\(formatString)' in the \(region) region"
        } else {
            resolvedDescription = "Cannot parse string '\(valueString)' in the \(region) region"
        }
        
        return .init(reason: .invalidValueString,
                     units: units,
                     dateComponents: nil,
                     region: region,
                     formatString: formatString,
                     valueString: valueString,
                     underlyingError: nil,
                     description: resolvedDescription)
    }
    
    internal static func decodingError(_ fixedError: Error) -> TimeError {
        return .init(reason: .decodingError,
                     units: nil,
                     dateComponents: nil,
                     region: nil,
                     formatString: nil,
                     valueString: nil,
                     underlyingError: fixedError,
                     description: "Cannot decode value from provided data: \(fixedError)")
    }
    
}
