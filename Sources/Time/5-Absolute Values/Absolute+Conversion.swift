//
//  Absolute+Conversion.swift
//  
//
//  Created by Dave DeLong on 2/12/20.
//

import Foundation

// absolute conversion
extension Absolute where Largest == Era {
    
    internal var anchorDate: Date {
        switch storage {
            case .absolute(let d):
                return d
            case .relative(let dc):
                fatalError("Unexpectedly have an Absolute TimePeriod with relative stored values \(dc)")
        }
    }
    
    /// Construct a new `TimePeriod` by converting the receiver to a new `Region`.
    public func converting(to newRegion: Region) -> Self {
        if newRegion == self.region { return self }
        return Self.init(region: newRegion, date: self.anchorDate)
    }
    
    /// Construct a new `TimePeriod` by converting the receiver to a new `Calendar`.
    public func converting(to calendar: Calendar) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.converting(to: newRegion)
    }
    
    /// Construct a new `TimePeriod` by converting the receiver to a new `TimeZone`.
    public func converting(to timeZone: TimeZone) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.converting(to: newRegion)
    }
    
    /// Construct a new `TimePeriod` by converting the receiver to a new `Locale`.
    public func converting(to locale: Locale) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return self.converting(to: newRegion)
    }
    
}
