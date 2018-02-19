//
//  Minute.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct Minute: RegionField, MinuteField, DateComponentsField {
    
    public let region: Region
    public let dateComponents: DateComponents
    
    internal init(dateComponents: DateComponents, region: Region) {
        require(dateComponents.minute != nil, "Cannot create a Minute without a minute value")
        self.region = region
        self.dateComponents = dateComponents
    }
    
}
