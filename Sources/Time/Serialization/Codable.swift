//
//  Codable.swift
//  
//
//  Created by Daniel Kennett on 2023-01-09.
//

import Foundation

extension Region: Codable {
    enum CodingKeys: String, CodingKey {
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

enum TimePeriodDecodeError: Error {
    case invalidDate
}

extension TimePeriod: Codable {

    enum CodingKeys: String, CodingKey {
        case components
        case region
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let components = try container.decode(DateComponents.self, forKey: .components)
        let region = try container.decode(Region.self, forKey: .region)
        try self.init(region: region, dateComponents: components)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateComponents, forKey: .components)
        try container.encode(region, forKey: .region)
    }
}
