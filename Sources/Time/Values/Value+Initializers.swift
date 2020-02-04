//
//  File.swift
//  
//
//  Created by Dave DeLong on 11/9/19.
//

import Foundation

extension Value {

    /// Construct a `Value` from an instantaneous point in time.
    /// - Parameter region: The `Region` in which to interpret the point in time
    /// - Parameter instant: The `Instant` that is contained by the constructed `Value`
    public init(region: Region, instant: Instant) {
        self.init(region: region, date: instant.date)
    }
    
    /// Construct a `Value` from an instantaneous point in time.
    /// - Parameter region: The `Region` in which to interpret the point in time
    /// - Parameter instant: The `Date` that is contained by the constructed `Value`
    public init(region: Region, date: Date) {
        let dc = region.components(Self.representedComponents, from: date)
        try! self.init(region: region, dateComponents: dc)
    }

}

// Absolute initializers

extension Value where Largest: GTOEEra {
    
    /// Construct an absolute `Value` from a set of `DateComponents`.
    ///
    /// This method is "unsafe" because it is fairly easy for it to produce an error.
    /// For example, if you are attempting to construct an `Absolute<Month>` but only provide
    /// a `year` value in the `DateComponents`, then this will throw an `AdjustmentError`.
    ///
    /// If you are attempting to construct a calendrically impossible date, such as "February 30th",
    /// then this will throw an `AdjustmentError`.
    ///
    /// The matching done on the `DateComponents` is a *strict* match; the returned `Value` will
    /// either exactly match the provided components, or this will throw an `AdjustmentError`.
    ///
    /// - Parameter region: The `Region` in which to interpret the date components
    /// - Parameter unsafeDateComponents: The `DateComponents` describing the desired calendrical date
    public init(region: Region, unsafeDateComponents: DateComponents) throws {
        let now = Date()
        let base = region.calendar.dateComponents(Self.representedComponents, from: now)
        guard let direction = base.relationTo(unsafeDateComponents) else {
            throw AdjustmentError.invalidDateComponents(base)
        }
        let proposed = region.calendar.nextDate(after: now, matching: unsafeDateComponents, matchingPolicy: .strict, repeatedTimePolicy: .first, direction: direction)
        guard let next = proposed else {
            throw AdjustmentError.invalidDateComponents(unsafeDateComponents)
        }
        self.init(region: region, date: next)
    }
    
}

extension Value where Smallest == Year, Largest: GTOEEra {
    
    public init(region: Region, era: Int? = nil, year: Int) throws {
        try self.init(region: region, unsafeDateComponents: DateComponents(era: era, year: year))
    }
    
}

extension Value where Smallest == Month, Largest: GTOEEra {
    
    public init(region: Region, era: Int? = nil, year: Int, month: Int) throws {
        try self.init(region: region, unsafeDateComponents: DateComponents(era: era, year: year, month: month))
    }
    
}

extension Value where Smallest == Day, Largest: GTOEEra {
    
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int) throws {
        try self.init(region: region, unsafeDateComponents: DateComponents(era: era, year: year, month: month, day: day))
    }
    
}

extension Value where Smallest == Hour, Largest: GTOEEra {
    
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int) throws {
        try self.init(region: region, unsafeDateComponents: DateComponents(era: era, year: year, month: month, day: day, hour: hour))
    }
    
}

extension Value where Smallest == Minute, Largest: GTOEEra {
    
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int, minute: Int) throws {
        try self.init(region: region, unsafeDateComponents: DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute))
    }
    
}

extension Value where Smallest == Second, Largest: GTOEEra {
    
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws {
        try self.init(region: region, unsafeDateComponents: DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second))
    }
    
}

extension Value where Smallest == Nanosecond, Largest: GTOEEra {
    
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws {
        try self.init(region: region, unsafeDateComponents: DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
    
}
