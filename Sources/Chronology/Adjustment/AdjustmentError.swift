//
//  File.swift
//  
//
//  Created by Dave DeLong on 11/9/19.
//

import Foundation

public enum AdjustmentError: Error {
    
    case invalidDateComponents(DateComponents)
    case missingValueForUnit(Calendar.Component)
    
}
