//
//  Fixed+Parsing.swift
//
//
//  Created by Dave DeLong on 2/4/20.
//

import Foundation

extension Fixed {
    
    public init(stringValue: String, rawFormat: String, region: Region) throws {
        let df = DateFormatter.formatter(for: rawFormat, region: region)
        if let date = df.date(from: stringValue) {
            self.init(region: region, date: date)
        } else {
            throw TimeError.cannotParseString(stringValue, in: region)
        }
    }
    
}
