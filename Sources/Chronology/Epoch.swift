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
    
    public static let unix = Epoch(-SISeconds.secondsBetweenUnixAndReferenceEpochs)
    
    public var hashValue: Int { return offsetFromReferenceDate.hashValue }
    
    internal let offsetFromReferenceDate: SISeconds
    
    internal init(_ offsetFromReferenceDate: SISeconds) {
        self.offsetFromReferenceDate = offsetFromReferenceDate
    }
    
}
