//
//  Month.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Month: RegionField, MonthField, DateComponentsField {
    
    public let region: Region
    public let dateComponents: DateComponents
    
    internal init(dateComponents: DateComponents, region: Region) {
        require(dateComponents.month != nil, "Cannot create a Month without a month value")
        self.region = region
        self.dateComponents = dateComponents
    }
    
}
