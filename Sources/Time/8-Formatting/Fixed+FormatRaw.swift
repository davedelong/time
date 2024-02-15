//
//  File.swift
//

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
    /// An error is thrown if-and-only-if the `strict` parameter is `true`. If you specify that `strict`
    /// is `false`, then you may safely "`try!`" this method.
    ///
    /// - Parameters:
    ///   - rawFormatString: The raw, unlocalized format string to be used for formatting.
    ///   - strict: Whether or not this method should throw a ``TimeError`` if the format string specifies
    ///     unrepresented calendar components.
    public func format(raw rawFormatString: String, strict: Bool = true) throws -> String {
        let desiredUnits = Calendar.Component.components(in: rawFormatString)
        let missingUnits = desiredUnits.subtracting(representedComponents)
        
        let style: FixedFormat<Granularity>
        if missingUnits.isEmpty == false {
            if strict == true {
                // the format string specified units that are not represented by this value
                let desc = "The provided format string '\(rawFormatString)' includes components (\(missingUnits)) that are not represented in a \(Self.self) value (\(Self.representedComponents))"
                throw TimeError.missingCalendarComponents(missingUnits, whileParsing: true, description: desc)
            } else {
                style = .init(raw: rawFormatString)
            }
        } else {
            style = .init(raw: rawFormatString)
        }
        return self.format(style)
    }
}
