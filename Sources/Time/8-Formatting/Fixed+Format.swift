extension Fixed {
    
    /// Format the value using a ``FormatStyle``
    ///
    /// A `FormatStyle` encapsulates all of the information necessary to conver the value into a
    /// human-readable representation. It is configured with a level of granularity analogous
    /// to the Fixed value's granularity.
    /// - Parameter style: The style to use for formatting
    /// - Returns: A human-readable representation of this value
    public func format(using style: FixedFormat<Granularity>) -> String {
        let date = self.dateForFormatting()
        return self.region.format(date: date, using: style.configuration)
    }
    
}
