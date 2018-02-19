//
//  Second.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Second: RegionField, SecondField, DateComponentsField {
    
    public let region: Region
    public let dateComponents: DateComponents
    
    internal init(dateComponents: DateComponents, region: Region) {
        require(dateComponents.second != nil, "Cannot create a Second without a second value")
        self.region = region
        self.dateComponents = dateComponents
    }
    
}
