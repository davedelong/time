//
//  Epoch.swift
//  Chronology
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

public struct Epoch {
    
    public static let reference = Epoch(0)
    
    public static let unix = Epoch(-Date.timeIntervalBetween1970AndReferenceDate)
    
    internal let offsetFromReferenceDate: TimeInterval
    
    internal init(_ offsetFromReferenceDate: TimeInterval) {
        self.offsetFromReferenceDate = offsetFromReferenceDate
    }
    
}
