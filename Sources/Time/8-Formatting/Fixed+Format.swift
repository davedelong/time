extension Fixed {
    
    /// Format the value using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    public func format(using format: FixedFormat<Granularity>) -> String {
        let date = self.dateForFormatting()
        return self.region.format(date: date, using: format.configuration)
    }
    
}

extension Range {
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Era>) -> String where Bound == Fixed<U>, U: LTOEEra {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Year>) -> String where Bound == Fixed<U>, U: LTOEYear {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Month>) -> String where Bound == Fixed<U>, U: LTOEMonth {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Day>) -> String where Bound == Fixed<U>, U: LTOEDay {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Hour>) -> String where Bound == Fixed<U>, U: LTOEHour {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Minute>) -> String where Bound == Fixed<U>, U: LTOEMinute {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Second>) -> String where Bound == Fixed<U>, U: LTOESecond {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Nanosecond>) -> String where Bound == Fixed<U>, U: LTOENanosecond {
        return self.format(using: format.configuration)
    }
    
    private func format<U: Unit>(using config: FormatConfiguration) -> String where Bound == Fixed<U> {
        let dateRange = self.lowerBound.dateForFormatting() ..< self.upperBound.dateForFormatting()
        return lowerBound.region.format(range: dateRange, using: config)
    }
    
}

extension ClosedRange {
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Era>) -> String where Bound == Fixed<U>, U: LTOEEra {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Year>) -> String where Bound == Fixed<U>, U: LTOEYear {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Month>) -> String where Bound == Fixed<U>, U: LTOEMonth {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Day>) -> String where Bound == Fixed<U>, U: LTOEDay {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Hour>) -> String where Bound == Fixed<U>, U: LTOEHour {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Minute>) -> String where Bound == Fixed<U>, U: LTOEMinute {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Second>) -> String where Bound == Fixed<U>, U: LTOESecond {
        return self.format(using: format.configuration)
    }
    
    /// Format a range of ``Fixed`` values using a ``FixedFormat``
    ///
    /// A `FixedFormat` encapsulates all of the information necessary to convert the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    ///
    /// The `lowerBound`'s `.region` is used for all formatting configuration (timeZone, calendar, etc).
    ///
    /// - Warning: Formats are not strictly followed by the underlying `DateIntervalFormatter`.  The formatter
    /// will always attempt to templatize the provided format information. This means that a ``FixedFormat`` that only
    /// specifies certain units (such as the day of the month) may still result in more units being included in the format string,
    /// such as the month or even the year.
    ///
    /// - Parameter format: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    /// - SeeAlso: `DateIntervalFormatter.string(from:to:)`
    public func format<U>(using format: FixedFormat<Nanosecond>) -> String where Bound == Fixed<U>, U: LTOENanosecond {
        return self.format(using: format.configuration)
    }
    
    private func format<U: Unit>(using config: FormatConfiguration) -> String where Bound == Fixed<U> {
        let dateRange = self.lowerBound.dateForFormatting() ..< self.upperBound.dateForFormatting()
        return lowerBound.region.format(range: dateRange, using: config)
    }
    
}
