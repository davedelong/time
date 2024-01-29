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

extension Fixed: Codable {

    private enum CodingKeys: String, CodingKey {
        case value
        case region
        
        // old key
        case components
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let region = try container.decode(Region.self, forKey: .region)
        
        do {
            let instant = try container.decode(Instant.self, forKey: .value)
            self.init(region: region, instant: instant)
        } catch {
            // older format, does not have an instant; look for date components
            let components = try container.decode(DateComponents.self, forKey: .components)
            try self.init(region: region, strictDateComponents: components)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(region, forKey: .region)
        try container.encode(instant, forKey: .value)
    }
}
