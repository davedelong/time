//
//  YearMonth.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol MonthField {
    var monthValue: Int { get }
}

public extension MonthField where Self: DateComponentsField {
    var monthValue: Int { return dateComponents.month.unwrap("Cannot create a MonthField without a month value") }
}

public extension MonthField where Self: Anchored, Self: DateComponentsField {
    var year: Year { return Year(dateComponents: self.dateComponents, region: region) }
}

public struct YearMonth: RegionField, EraField, YearField, MonthField, DateComponentsField, Anchored {
    
    public let region: Region
    public let dateComponents: DateComponents
    public var range: ClosedRange<Instant> { return getRange(self, unit: .month) }
    
    internal init(dateComponents: DateComponents, region: Region) {
        require(dateComponents.month != nil, "Cannot create a YearMonth without a month value")
        require(dateComponents.year != nil, "Cannot create a YearMonth without a year value")
        require(dateComponents.era != nil, "Cannot create a YearMonth without an era value")
        
        self.region = region
        self.dateComponents = dateComponents
    }
    
}
