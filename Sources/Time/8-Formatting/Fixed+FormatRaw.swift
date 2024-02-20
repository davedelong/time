import Foundation

extension Fixed {
    
    /// Format a `Fixed` value using hard-coded format string.
    ///
    /// The localized format options provided for Fixed values are not always sufficient.
    /// The most common scenario for needing a hard-coded format string is when communicating with servers,
    /// which tend to expect a timestamp in a very specific format (ex: ISO8601). This requirement
    /// is at odds with the locale-sensitive formatting provided by this package.
    ///
    /// This method allows you to provided an explicit format string while formatting.
    ///
    /// The format string is checked to make sure the specified calendar components are
    /// all represented by this value. If they are not *and* the `strict` parameter is `true` (the default),
    /// then a `TimeError` is thrown indicating that there are missing components while parsing.
    ///
    /// If the format string specifies unrepresented calendar components and `strict` is `false`, then
    /// the `firstInstant` of the value is used.
    ///
    /// - Parameters:
    ///   - rawFormatString: The raw, unlocalized format string to be used for formatting.
    ///   - strict: Whether or not this method should throw a ``TimeError`` if the format string specifies
    ///     unrepresented calendar components.
    /// - Throws: A `TimeError` if either the `rawFormatString` is syntactically incorrect, or the format string is
    /// requesting units for formatting that are not represented by this fixed value *and* the `strict` parameter is `true`
    public func format(raw rawFormatString: String, strict: Bool = true) throws -> String {
        let format = try ParsedFormat(formatString: rawFormatString)
        
        let formattedUnits = format.components.compactMap(\.unit)
        let requiredUnits = formattedUnits.map(\.minimumRequiredComponent)
        
        let missingUnits = Set(requiredUnits).subtracting(self.representedComponents)
        
        let style: FixedFormat<Granularity>
        if missingUnits.isEmpty == false {
            if strict == true {
                // the format string specified units that are not represented by this value
                let desc = "The provided format string '\(rawFormatString)' includes components (\(missingUnits)) that are not represented in a \(Self.self) value (\(Self.representedComponents))"
                throw TimeError.invalidFormatString(rawFormatString, units: missingUnits, description: desc)
            } else {
                style = .init(raw: rawFormatString)
            }
        } else {
            style = .init(raw: rawFormatString)
        }
        return self.format(style)
    }
}
