//
//  Epoch.swift
//  Chronology
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

public struct Epoch: Hashable {
    
    public static func ==(lhs: Epoch, rhs: Epoch) -> Bool {
        return lhs.offsetFromReferenceDate == rhs.offsetFromReferenceDate
    }
    
    public static let reference = Epoch(0)
    
    public static let unix = Epoch(-Date.timeIntervalBetween1970AndReferenceDate)
    
    public var hashValue: Int { return Int(offsetFromReferenceDate) }
    
    internal let offsetFromReferenceDate: TimeInterval
    
    internal init(_ offsetFromReferenceDate: TimeInterval) {
        self.offsetFromReferenceDate = offsetFromReferenceDate
    }
    
}
