//
//  Hour.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Hour: RegionField, HourField, DateComponentsField {
    
    public let region: Region
    public let dateComponents: DateComponents
    
    internal init(dateComponents: DateComponents, region: Region) {
        require(dateComponents.hour != nil, "Cannot create an hour without an hour value")
        self.region = region
        self.dateComponents = dateComponents
    }
    
}
