//
//  Absolute+Conversion.swift
//  
//
//  Created by Dave DeLong on 2/12/20.
//

import Foundation

// absolute conversion
extension Absolute {
    
    /// Construct a new `TimePeriod` by converting the receiver to a new `Region`.
    public func converting(to newRegion: Region) -> Self {
        if newRegion == self.region { return self }
        
        if newRegion.calendar != region.calendar || newRegion.timeZone != region.timeZone {
            // changing calendar or timezone means generating new date components
            return Self.init(region: newRegion, instant: approximateMidPoint)
        } else {
            // changing locale does not affect the underlying date components
            return try! Self.init(region: newRegion, dateComponents: dateComponents)
        }
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
