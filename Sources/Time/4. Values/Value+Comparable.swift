//
//  File.swift
//  
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

extension Value: Equatable {
    
    /// Determine if two `Values` are equal.
    ///
    /// Two `Values` are equal if they have the same `Region` and represent the same calendrical components
    /// - Parameter lhs: a `Value`
    /// - Parameter rhs: a `Value`
    public static func ==(lhs: Value, rhs: Value) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents == rhs.dateComponents
    }
    
}

extension Value: Hashable {
    
    /// Compute the hash of a `Value`
    ///
    /// - Parameter hasher: a `Hasher`
    public func hash(into hasher: inout Hasher) {
        hasher.combine(region)
        hasher.combine(dateComponents)
    }
    
}

extension Value: Comparable {
    
    /// Determine if one `Value` is greater than another `Value`.
    ///
    /// A `Value` is greater than another if they have the same `Region`, and the first's
    /// calendrical components come *after* the other's components.
    /// - Parameter lhs: a `Value`
    /// - Parameter rhs: a `Value`
    public static func > (lhs: Value, rhs: Value) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents.isGreaterThan(other: rhs.dateComponents)
    }
    
    /// Determine if one `Value` is less than another `Value`.
    ///
    /// A `Value` is less than another if they have the same `Region`, and the first's
    /// calendrical components come *before* the other's components.
    /// - Parameter lhs: a `Value`
    /// - Parameter rhs: a `Value`
    public static func < (lhs: Value, rhs: Value) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents.isLessThan(other: rhs.dateComponents)
    }
    
}

extension Value: CustomStringConvertible {
    
    /// Provide a description of the `Value`.
    ///
    /// The description is a localized "full" formatting of the calendar value.
    public var description: String {
        return formatFull()
    }
    
}
