//
//  Value+Initializers.swift
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
        let components = region.calendar.dateComponents(in: region.timeZone, from: date)
        try! self.init(region: region, dateComponents: components)
    }

}

// Absolute initializers

extension Absolute {
    
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
        let next = try region.calendar.exactDate(from: unsafeDateComponents, matching: Self.representedComponents)
        self.init(region: region, date: next)
    }
    
}

extension Value where Smallest == Year, Largest == Era {
    
    /// Construct an `Absolute<Year>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    /// - Throws: An `AdjustmentError` if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int) throws {
        let components = DateComponents(era: era, year: year)
        try self.init(region: region, unsafeDateComponents: components)
    }
    
}

extension Value where Smallest == Month, Largest == Era {
    
    /// Construct an `Absolute<Month>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    /// - Throws: An `AdjustmentError` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int) throws {
        let components = DateComponents(era: era, year: year, month: month)
        try self.init(region: region, unsafeDateComponents: components)
    }
    
}

extension Value where Smallest == Day, Largest == Era {
    
    /// Construct an `Absolute<Day>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    ///   - day: the numeric `Day` value.
    /// - Throws: An `AdjustmentError` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day)
        try self.init(region: region, unsafeDateComponents: components)
    }
    
}

extension Value where Smallest == Hour, Largest == Era {
    
    /// Construct an `Absolute<Hour>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    ///   - day: the numeric `Day` value.
    ///   - hour: the numeric `Hour` value.
    /// - Throws: An `AdjustmentError` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day, hour: hour)
        try self.init(region: region, unsafeDateComponents: components)
    }
    
}

extension Value where Smallest == Minute, Largest == Era {
    
    /// Construct an `Absolute<Minute>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    ///   - day: the numeric `Day` value.
    ///   - hour: the numeric `Hour` value.
    ///   - minute: the numeric `Minute` value.
    /// - Throws: An `AdjustmentError` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int, minute: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute)
        try self.init(region: region, unsafeDateComponents: components)
    }
    
}

extension Value where Smallest == Second, Largest == Era {
    
    /// Construct an `Absolute<Second>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    ///   - day: the numeric `Day` value.
    ///   - hour: the numeric `Hour` value.
    ///   - minute: the numeric `Minute` value.
    ///   - second: the numeric `Second` value.
    /// - Throws: An `AdjustmentError` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        try self.init(region: region, unsafeDateComponents: components)
    }
    
}

extension Value where Smallest == Nanosecond, Largest == Era {
    
    /// Construct an `Absolute<Nanosecond>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    ///   - day: the numeric `Day` value.
    ///   - hour: the numeric `Hour` value.
    ///   - minute: the numeric `Minute` value.
    ///   - second: the numeric `Second` value.
    ///   - nanosecond: the numeric `Nanosecond` value.
    /// - Throws: An `AdjustmentError` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
        try self.init(region: region, unsafeDateComponents: components)
    }
    
}
