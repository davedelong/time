//
//  File.swift
//  
//
//  Created by Dave DeLong on 11/9/19.
//

import Foundation

public struct AdjustmentError: Error {
    
    public let proposedDateComponents: DateComponents
    
    internal init(unsafeAdjustment: DateComponents) {
        proposedDateComponents = unsafeAdjustment
    }
    
}
