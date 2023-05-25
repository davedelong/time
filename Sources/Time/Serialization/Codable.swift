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

extension TimePeriod: Codable {

    private enum CodingKeys: String, CodingKey {
        case value
        case region
        
        // old key
        case components
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.region = try container.decode(Region.self, forKey: .region)
        
        do {
            // try to decode the old "components" key first
            self.storage = try container.decode(TimePeriodStorage.self, forKey: .components)
        } catch {
            // if that fails, try decoding the newer "value" key
            self.storage = try container.decode(TimePeriodStorage.self, forKey: .value)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(region, forKey: .region)
        try container.encode(storage, forKey: .value)
    }
}
