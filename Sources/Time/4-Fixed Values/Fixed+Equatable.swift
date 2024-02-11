//
//  File.swift
//  
//
//  Created by Dave DeLong on 2/4/24.
//

import Foundation

extension Fixed: Equatable {
    
    /// Determine if two `Fixed` values are equal.
    ///
    /// Two `Fixed` values are equal if they have the same `Region` and represent the same calendrical components.
    /// - Parameter lhs: a `Fixed` value
    /// - Parameter rhs: a `Fixed` value
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents == rhs.dateComponents
    }
    
}

extension Fixed: Hashable {
    
    /// Compute the hash of an`Fixed` value
    ///
    /// - Parameter hasher: a `Hasher`
    public func hash(into hasher: inout Hasher) {
        hasher.combine(region)
        hasher.combine(dateComponents)
    }
    
}
