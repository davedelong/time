//
//  Codable.swift
//  
//
//  Created by Daniel Kennett on 2023-01-09.
//

import Foundation

extension Region: Codable {
    private enum CodingKeys: String, CodingKey {
        case timeZone
        case locale
        case calendar
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let calendar = try container.decode(Calendar.self, forKey: .calendar)
        let timeZone = try container.decode(TimeZone.self, forKey: .timeZone)
        let locale = try container.decode(Locale.self, forKey: .locale)
        self.init(calendar: calendar, timeZone: timeZone, locale: locale)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(timeZone, forKey: .timeZone)
        try container.encode(locale, forKey: .locale)
        try container.encode(calendar, forKey: .calendar)
    }
}

extension Absolute: Codable {

    private enum CodingKeys: String, CodingKey {
        case value
        case region
        
        // old key
        case components
    }
    
    private enum TimePeriodStorage: Codable {
        case absolute(Foundation.Date)
        case relative(Foundation.DateComponents)
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            do {
                let date = try container.decode(Date.self)
                self = .absolute(date)
            } catch let absoluteError {
                do {
                    let components = try container.decode(DateComponents.self)
                    self = .relative(components)
                } catch let relativeError {
                    throw TimeError.cannotDecodeTimePeriod(absoluteError, relativeError)
                }
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
                case .absolute(let date):
                    try container.encode(date)
                case .relative(let dc):
                    try container.encode(dc)
            }
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let region = try container.decode(Region.self, forKey: .region)
        
        let key = container.contains(.components) ? CodingKeys.components : .value
        let storage = try container.decode(TimePeriodStorage.self, forKey: key)
        
        let date: Date
        switch storage {
        case .absolute(let d):
            date = d
        case .relative(let components):
            // When decoding absolute values, we need to convert the storage to the newer instant-based storage.
            guard let d = region.calendar.date(from: components) else {
                throw TimeError.invalidDateComponents(components, in: region, description: "Decoding an Absolute value")
            }
            date = d
        }
        self.init(region: region, date: date)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(region, forKey: .region)
        try container.encode(date, forKey: .value)
    }
}
