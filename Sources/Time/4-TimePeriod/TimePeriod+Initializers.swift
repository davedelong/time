//
//  TimePeriod+Initializers.swift
//  
//
//  Created by Dave DeLong on 11/9/19.
//

import Foundation

extension TimePeriod {

    /// Construct a `TimePeriod` from an instantaneous point in time.
    /// - Parameter region: The `Region` in which to interpret the point in time
    /// - Parameter instant: The `Instant` that is contained by the constructed `TimePeriod`
    public init(region: Region, instant: Instant) {
        self.init(region: region, date: instant.date)
    }
    
    /// Construct a `TimePeriod` from an instantaneous point in time.
    /// - Parameter region: The `Region` in which to interpret the point in time
    /// - Parameter instant: The `Date` that is contained by the constructed `TimePeriod`
    public init(region: Region, date: Date) {
        if Largest.self == Era.self {
            self.init(region: region, absolute: date)
        } else {
            let components = region.calendar.dateComponents(in: region.timeZone, from: date)
            try! self.init(region: region, relative: components)
        }
    }

    /// Create a "deep" copy of the receiver. This is a reasonably expensive operation, and should be used with care.
    ///
    /// This method is useful if you're on a platform that doesn't provide thread safety for the underlying date
    /// primatives, most notably Linux at the time of writing (mid-2023). If you're using `TimePeriod` objects in a
    /// multithreaded environment and are seeing odd behaviour, you may need to work with copies.
    ///
    /// Notable observed "odd behaviours" include:
    ///
    /// - Attempting to create what should be a valid `TimePeriod` range (like `someDay..<someDay.adding(days: 7)`)
    ///   crashing with `Fatal error: Range requires lowerBound <= upperBound`.
    ///
    /// - Attempts to work with `AbsoluteTimePeriodSequence` or other basic time period manipulations crashing with a
    ///   stack trace deep into Foundation's internals (often mentioning `NSCalendar`).
    ///
    /// For some technical background, `Calendar`/`NSCalendar` is *not* thread-safe in the `swift-corelibs-foundation`
    /// package, which is used to provide Foundation to Swift on non-Apple platforms. Many operations that don't
    /// outwardly appear to be mutating do temporarily perform mutating operations internally when performing
    /// calendrical calculations, which in turn makes many nonmutating operations on `TimePeriod` not thread-safe.
    ///
    /// Note that modern Apple platforms (iOS, macOS, etc) have thread-safe `Calendar`/`NSCalendar` implementations
    /// and don't suffer from this particular problem.
    public func forcedCopy() -> Self {
        switch storage {
            case .absolute(let date):
                return Self(region: region.forcedCopy(), absolute: Date(timeIntervalSince1970: date.timeIntervalSince1970))
            case .relative(let components):
                // Since we'll already have validated our date components, the try! here *should* be safe.
                return try! Self(region: region.forcedCopy(), relative: components)
        }
    }

}

// Absolute initializers

extension Absolute where Largest == Era {
    
    /// Construct an absolute `TimePeriod` from a set of `DateComponents`.
    ///
    /// This method is "strict" because it is fairly easy for it to produce an error.
    /// For example, if you are attempting to construct an `Absolute<Month>` but only provide
    /// a `year` value in the `DateComponents`, then this will throw a `TimeError`.
    ///
    /// If you are attempting to construct a calendrically impossible date, such as "February 30th",
    /// then this will throw a `TimeError`.
    ///
    /// The matching done on the `DateComponents` is a *strict* match; the returned `TimePeriod` will
    /// either exactly match the provided components, or this will throw a `TimeError`.
    ///
    /// - Parameter region: The `Region` in which to interpret the date components
    /// - Parameter strictDateComponents: The `DateComponents` describing the desired calendrical date
    public init(region: Region, strictDateComponents: DateComponents) throws {
        let next = try region.calendar.exactDate(from: strictDateComponents, matching: Self.representedComponents)
        self.init(region: region, date: next)
    }
}

extension TimePeriod where Smallest == Year, Largest == Era {
    
    /// Construct an `Absolute<Year>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    /// - Throws: A `TimeError` if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int) throws {
        let components = DateComponents(era: era, year: year)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension TimePeriod where Smallest == Month, Largest == Era {
    
    /// Construct an `Absolute<Month>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    /// - Throws: A `TimeError` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int) throws {
        let components = DateComponents(era: era, year: year, month: month)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension TimePeriod where Smallest == Day, Largest == Era {
    
    /// Construct an `Absolute<Day>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    ///   - day: the numeric `Day` value.
    /// - Throws: A `TimeError` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension TimePeriod where Smallest == Hour, Largest == Era {
    
    /// Construct an `Absolute<Hour>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    ///   - day: the numeric `Day` value.
    ///   - hour: the numeric `Hour` value.
    /// - Throws: A `TimeError` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day, hour: hour)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension TimePeriod where Smallest == Minute, Largest == Era {
    
    /// Construct an `Absolute<Minute>` from the specified numeric components.
    /// - Parameters:
    ///   - region: The `Region` in which the components will be interpreted.
    ///   - era: The numeric `Era` value for the value. If omitted, it will assumed to be the "current" era.
    ///   - year: The numeric `Year` value.
    ///   - month: The numeric `Month` value.
    ///   - day: the numeric `Day` value.
    ///   - hour: the numeric `Hour` value.
    ///   - minute: the numeric `Minute` value.
    /// - Throws: A `TimeError` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int, minute: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension TimePeriod where Smallest == Second, Largest == Era {
    
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
    /// - Throws: A `TimeError` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        try self.init(region: region, strictDateComponents: components)
    }
    
}

extension TimePeriod where Smallest == Nanosecond, Largest == Era {
    
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
    /// - Throws: A `TimeError` error if the specified components cannot be converted into a calendar value.
    public init(region: Region, era: Int? = nil, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws {
        let components = DateComponents(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
        try self.init(region: region, strictDateComponents: components)
    }
    
}
