//
//  Day.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Day: RegionField, DayField, DateComponentsField {
    
    public let region: Region
    public let dateComponents: DateComponents
    
    internal init(dateComponents: DateComponents, region: Region) {
        require(dateComponents.day != nil, "Cannot create a Day without a day value")
        self.region = region
        self.dateComponents = dateComponents
    }
    
}


