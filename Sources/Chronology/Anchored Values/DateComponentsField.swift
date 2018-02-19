//
//  DateComponentsField.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol DateComponentsField: RegionField {
    
    var dateComponents: Foundation.DateComponents { get }
    
}
