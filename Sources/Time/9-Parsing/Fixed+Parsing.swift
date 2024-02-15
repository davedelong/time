//
//  Fixed+Parsing.swift
//

import Foundation

extension Fixed {
    
    /// Attempt to create a fixed value from a string and raw format
    /// - Parameters:
    ///   - stringValue: A string to parse, such as `"2024-01-30"`
    ///   - rawFormat: An format string to use as the tempalte for parsing, such as `"y-MM-dd"`
    ///   - region: The ``Region`` to be used for parsing the string
    /// - Throws: A ``TimeError`` if the string cannot be parsed using the provided format and region.
    public init(stringValue: String, rawFormat: String, region: Region) throws {
        let df = DateFormatter.formatter(for: rawFormat, region: region)
        if let date = df.date(from: stringValue) {
            self.init(region: region, date: date)
        } else {
            throw TimeError.cannotParseString(stringValue, in: region)
        }
    }
    
}
