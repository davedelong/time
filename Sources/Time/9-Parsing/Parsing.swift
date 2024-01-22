//
//  Parsing.swift
//  
//
//  Created by Dave DeLong on 2/4/20.
//

import Foundation

extension Absolute {
    
    internal init(stringValue: String, region: Region, formats: Array<Format?>) throws {
        let df = DateFormatter.formatter(for: formats, region: region)
        if let date = df.date(from: stringValue) {
            self.init(region: region, date: date)
        } else {
            throw TimeError.cannotParseString(stringValue, in: region)
        }
    }
    
}
