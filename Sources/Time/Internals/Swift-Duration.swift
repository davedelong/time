//
//  File.swift
//  
//
//  Created by Dave DeLong on 1/20/24.
//

import Foundation

extension Swift.Duration {
    
    // Swift.Duration has += defined, but not binary +
    internal static func +(lhs: Self, rhs: Self) -> Self {
        var copy = lhs
        copy += rhs
        return copy
    }
    
    // Swift.Duration has prefix + defined, but not prefix -
    internal prefix static func -(rhs: Self) -> Self {
        var copy = Duration.zero
        copy -= rhs
        return copy
    }
    
}
