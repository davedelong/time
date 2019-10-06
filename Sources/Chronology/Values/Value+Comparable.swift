//
//  File.swift
//  
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

extension Value: Equatable {
    
    public static func ==(lhs: Value, rhs: Value) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents == rhs.dateComponents
    }
    
}

extension Value: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(region)
        hasher.combine(dateComponents)
    }
    
}

extension Value: Comparable {
    
    public static func > (lhs: Value, rhs: Value) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents.isGreaterThan(other: rhs.dateComponents)
    }
    
    public static func < (lhs: Value, rhs: Value) -> Bool {
        return lhs.region == rhs.region && lhs.dateComponents.isLessThan(other: rhs.dateComponents)
    }
    
}
