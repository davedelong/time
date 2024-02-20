import Foundation

/// An enum dictating how the conversion of a fixed value from one region to another should behave
public enum ConversionBehavior {
    
    /// When converting a fixed value, the [component](<doc:Terminology>)'s (day, hour, minute, etc) should be preserved.
    ///
    /// This is a failable operation and may result in a ``TimeError`` being thrown, as the value's
    /// components may not exist in the new region. For example, a 2 AM value in a European region may
    /// throw an error when converted to a US region, if that fixed value happens to occur during a daylight
    /// saving time transition.
    ///
    /// Similarly, a fixed value representing a 13th month on a lunisolar calendar would fail
    /// when converted to a gregorian region.
    ///
    /// - Warning: In general, this operation only makes sense to perform on fixed values that represent a day (or larger) range.
    case preservingComponents
    
    /// When converting a fixed value, the ``Fixed/range`` should be preserved.
    ///
    /// This operation represents answering the question "if it's 2 PM in Los Angeles, what time is it in Rome?".
    ///
    /// - Warning: In general, this operation only makes sense to perform on fixed values that represent a day (or smaller) range.
    /// Attempting to use this on larger units (months, years, and eras) will likely result in a thrown ``TimeError``, since most calendars
    /// do not have the same month, year, or era boundaries as other calendars.
    case preservingRange
    
}

extension Fixed {
    
    /// Convert a fixed value to a new region.
    ///
    /// - Parameters:
    ///   - region: The region to which the new fixed value should belong
    ///   - behavior: The ``ConversionBehavior`` specifying how the conversion should happen
    /// - Returns: A new fixed value that has been converted to the specified time zone.
    /// - Throws: A ``TimeError`` if the conversion could not be completed
    /// - Warning: This operation may fail for many possible reasons and should be used with care. For full details, see ``ConversionBehavior``.
    public func converted(to newRegion: Region, behavior: ConversionBehavior) throws -> Self {
        if newRegion.isEquivalent(to: self.region) { return self }
        
        switch behavior {
            case .preservingComponents:
                return try Fixed(region: newRegion, strictDateComponents: self.dateComponents)
                
            case .preservingRange:
                let currentRange = self.range
                
                let midPointValue = Fixed(region: newRegion, instant: self.approximateMidPoint)
                if midPointValue.range == currentRange { return midPointValue }
                
                let startValue = Fixed(region: newRegion, instant: currentRange.lowerBound)
                if startValue.range == currentRange { return startValue }
                
                if self.instant != currentRange.lowerBound {
                    let instantValue = Fixed(region: newRegion, instant: self.instant)
                    if instantValue.range == currentRange { return instantValue }
                }
                
                throw TimeError.invalidDateComponents(self.dateComponents, in: newRegion)
        }
    }
    
    /// Convert a fixed value to a new time zone.
    ///
    /// - Parameters:
    ///   - timeZone: The time zone to which the new fixed value should belong
    ///   - behavior: The ``ConversionBehavior`` specifying how the conversion should happen
    /// - Returns: A new fixed value that has been converted to the specified time zone.
    /// - Throws: A ``TimeError`` if the conversion could not be completed
    /// - Warning: This operation may fail for many possible reasons and should be used with care. For full details, see ``ConversionBehavior``.
    public func converted(to timeZone: TimeZone, behavior: ConversionBehavior) throws -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return try self.converted(to: newRegion, behavior: behavior)
    }
    
    /// Convert a fixed value to a new calendar.
    ///
    /// - Parameters:
    ///   - calendar: The calendar to which the new fixed value should belong
    ///   - behavior: The ``ConversionBehavior`` specifying how the conversion should happen
    /// - Returns: A new fixed value that has been converted to the specified calendar.
    /// - Throws: A ``TimeError`` if the conversion could not be completed
    /// - Warning: This operation may fail for many possible reasons and should be used with care. For full details, see ``ConversionBehavior``.
    public func converted(to calendar: Calendar, behavior: ConversionBehavior) throws -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return try self.converted(to: newRegion, behavior: behavior)
    }
    
    /// Construct a new `Fixed` value by converting this fixed value to a new `Locale`.
    ///
    /// Changing a fixed value's locale affects how the value is formatted. It does not change the underlying components.
    public func converted(to locale: Locale) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return Self(region: newRegion, instant: self.instant, components: self.dateComponents)
    }
    
}

extension Fixed where Granularity: GTOEDay {
    
    /// Convert a fixed date to another time zone
    ///
    /// This works by transitioning the underlying *components* to a new time zone. If successful, the resulting value
    /// will have the same `.year`, `.month`, etc as the original value. However, the resulting `.range` will be different.
    ///
    /// - Parameter timeZone: The new time zone of the resulting fixed value
    /// - Returns: A new fixed value with the same underlying components
    /// - Throws: Throws a ``TimeError`` if the underlying components do not exist in the specified `timeZone`. For example,
    /// converting "30 December 2011" to the `Pacific/Apia` time zone throws an error, because that day did not exist in that time zone.
    public func converted(to timeZone: TimeZone) throws -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return try Self(region: newRegion, strictDateComponents: self.dateComponents)
    }
    
}

extension Fixed where Granularity: LTOEDay {
    
    /// Construct a new `Fixed` value by converting this fixed value to a new `Calendar`.
    ///
    /// - Note: This functionality is only available when dealing with fixed values that represent a day or smaller. All
    /// supported calendars have the same basic definition of a day, being roughly `00:00:00 ... 23:59:59.999`.
    /// Therefore, converting such a value to another calendar will result in the old temporal range being equivalent to
    /// the new temporal range. This is not true for eras, years, and months: calendars have different definitions of when years start
    /// and when months change, etc. Therefore, it is not possible to map "February 2024" to a non-gregorian calendar, since
    /// there is not a guaranteed correspondance between their underlying `Range<Instant>` values.
    public func converted(to calendar: Calendar) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return Self(region: newRegion, instant: self.approximateMidPoint)
    }
    
}

extension Fixed where Granularity: LTOEHour {
    
    /// Convert a fixed time to another time zone.
    ///
    /// This works by transitioning the underlying time range to the new time zone. Therefore, the resulting components
    /// (`.hour`, `.minute`, etc) will be *different* from the original components. However, the resulting `.range` will
    /// be the same.
    ///
    /// - Parameter timeZone: The new time zone of the resulting fixed value
    /// - Returns: A fixed value representing the same range of time in a different `TimeZone`.
    public func converted(to timeZone: TimeZone) -> Self {
        let newRegion = Region(calendar: calendar, timeZone: timeZone, locale: locale)
        return Self(region: newRegion, instant: self.firstInstant)
    }
    
}
