//
//  Relative.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 10/4/18.
//

import Foundation

public struct Relative<Lower: Unit, Upper: Unit>: CalendarValue {
    
    public typealias Smallest = Lower
    public typealias Largest = Upper
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = type(of: self).restrict(dateComponents: dateComponents)
    }
    
}
