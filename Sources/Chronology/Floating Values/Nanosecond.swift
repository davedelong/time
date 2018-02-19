//
//  Nanosecond.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Nanosecond: RegionField, NanosecondField, DateComponentsField {
    
    public let region: Region
    public let dateComponents: DateComponents
    
    internal init(dateComponents: DateComponents, region: Region) {
        require(dateComponents.nanosecond != nil, "Cannot create a Nanosecond without a nanosecond value")
        self.region = region
        self.dateComponents = dateComponents
    }
    
}
