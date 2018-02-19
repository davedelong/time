//
//  Year.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol YearField {
    var yearValue: Int { get }
}

public extension YearField where Self: DateComponentsField {
    var yearValue: Int { return dateComponents.year.unwrap("Cannot create a YearField without a year value") }
}

public extension YearField where Self: Anchored, Self: DateComponentsField {
    var era: Era { return Era(dateComponents: self.dateComponents, region: region) }
}

public struct Year: RegionField, EraField, YearField, DateComponentsField, Anchored, DateComponentsInitializable {
    internal static var representedComponents: Set<Calendar.Component> = [.era, .year]
    
    public let region: Region
    public let dateComponents: DateComponents
    public var range: ClosedRange<Instant> { return getRange(self, unit: .year) }
    
    internal init(dateComponents: DateComponents, region: Region) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
    
}
