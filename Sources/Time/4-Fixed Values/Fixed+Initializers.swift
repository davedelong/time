//
//  Fixed+Initializers.swift
//
//
//  Created by Dave DeLong on 11/9/19.
//

import Foundation

extension Fixed where Granularity == Era {
    
    /// Construct a `Fixed<Era>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value.
    /// - Throws: A ``TimeError`` if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int) throws {
        let components = DateComponents(era: era)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension Fixed where Granularity == Year {
    
    /// Construct a `Fixed<Year>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    /// - Throws: A ``TimeError`` if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int) throws {
        let components = DateComponents(era: era, year: year)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension Fixed where Granularity == Month {
    
    /// Construct a `Fixed<Month>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    /// - Throws: A ``TimeError`` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int) throws {
        let components = DateComponents(era: era, year: year, month: month)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension Fixed where Granularity == Day {
    
    /// Construct a `Fixed<Day>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    ///   - day: the numeric `Day` value.
    /// - Throws: A ``TimeError`` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension Fixed where Granularity == Hour {
    
    /// Construct a `Fixed<Hour>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    ///   - day: the numeric `Day` value.
    ///   - hour: the numeric `Hour` value.
    /// - Throws: A ``TimeError`` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day, hour: hour)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension Fixed where Granularity == Minute {
    
    /// Construct a `Fixed<Minute>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    ///   - day: the numeric `Day` value.
    ///   - hour: the numeric `Hour` value.
    ///   - minute: the numeric `Minute` value.
    /// - Throws: A ``TimeError`` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int, minute: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension Fixed where Granularity == Second {
    
    /// Construct a `Fixed<Second>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    ///   - day: the numeric `Day` value.
    ///   - hour: the numeric `Hour` value.
    ///   - minute: the numeric `Minute` value.
    ///   - second: the numeric `Second` value.
    /// - Throws: A ``TimeError`` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension Fixed where Granularity == Nanosecond {
    
    /// Construct a `Fixed<Nanosecond>` from the specified numeric components.
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
    /// - Throws: A ``TimeError`` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension Fixed {
    
    /// Create a "deep" copy of the receiver. This is a reasonably expensive operation, and should be used with care.
    ///
    /// This method is useful if you're on a platform that doesn't provide thread safety for the underlying date
    /// primatives, most notably Linux at the time of writing (mid-2023). If you're using `Fixed` value objects in a
    /// multithreaded environment and are seeing odd behaviour, you may need to work with copies.
    ///
    /// Notable observed "odd behaviours" include:
    ///
    /// - Attempting to create what should be a valid `Fixed` value range (like `someDay..<someDay.adding(days: 7)`)
    ///   crashing with `Fatal error: Range requires lowerBound <= upperBound`.
    ///
    /// - Attempts to work with `FixedSequence` or other basic time period manipulations crashing with a
    ///   stack trace deep into Foundation's internals (often mentioning `NSCalendar`).
    ///
    /// For some technical background, `Calendar`/`NSCalendar` is *not* thread-safe in the `swift-corelibs-foundation`
    /// package, which is used to provide Foundation to Swift on non-Apple platforms. Many operations that don't
    /// outwardly appear to be mutating do temporarily perform mutating operations internally when performing
    /// calendrical calculations, which in turn makes many nonmutating operations on `Fixed` value not thread-safe.
    ///
    /// Note that modern Apple platforms (iOS, macOS, etc) have thread-safe `Calendar`/`NSCalendar` implementations
    /// and don't suffer from this particular problem.
    public func _forcedCopy() -> Self {
        return Self(region: region._forcedCopy(), 
                    instant: Instant(interval: instant.intervalSinceEpoch, since: instant.epoch))
    }
    
}
