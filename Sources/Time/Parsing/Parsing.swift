//
//  Parsing.swift
//  
//
//  Created by Dave DeLong on 2/4/20.
//

import Foundation

extension TimePeriod {
    
    internal init(stringValue: String, region: Region, formats: Array<Format?>) throws {
        let template = formats.compactMap { $0?.template }.joined()
        let df = DateFormatterCache.shared.formatter(forTemplate: template, region: region)
        if let date = df.date(from: stringValue) {
            self.init(region: region, date: date)
        } else {
            throw TimeError.cannotParseString(stringValue, in: region)
        }
    }
    
}
