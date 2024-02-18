//
//  Codable.swift
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
        
        let calendarContainer = try container.decode(CodableCalendar.self, forKey: .calendar)
        let timeZoneContainer = try container.decode(CodableTimeZone.self, forKey: .timeZone)
        let localeContainer = try container.decode(CodableLocale.self, forKey: .locale)
        
        self.init(calendar: calendarContainer.calendar,
                  timeZone: timeZoneContainer.timeZone,
                  locale: localeContainer.locale)
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

private struct CodableLocale: Codable {
    
    let locale: Locale
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let identifier = try container.decode(String.self)
            self.locale = Locale.standard(identifier)
        } catch {
            self.locale = try container.decode(Locale.self)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        let standard = Locale.standard(locale.identifier)
        
        if standard.isEquivalent(to: locale) {
            var single = encoder.singleValueContainer()
            try single.encode(locale.identifier)
        } else {
            try locale.encode(to: encoder)
        }
    }
    
}

private struct CodableTimeZone: Codable {
    
    let timeZone: TimeZone
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let identifier = try container.decode(String.self)
            self.timeZone = TimeZone.standard(identifier)
        } catch {
            self.timeZone = try container.decode(TimeZone.self)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        let standard = TimeZone.standard(timeZone.identifier)
        
        if standard.isEquivalent(to: timeZone) {
            var single = encoder.singleValueContainer()
            try single.encode(timeZone.identifier)
        } else {
            try timeZone.encode(to: encoder)
        }
    }
    
}

private struct CodableCalendar: Codable {
    
    let calendar: Calendar
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            #if os(Linux)
            // on Linux, Calendar.Identifier does not appear to be Codable
            // therefore, we must manually decode its value
            let encodingIdentifier = try container.decode(String.self)
            let identifier = try Calendar.Identifier(encodingIdentifier: encodingIdentifier)
            #else
            let identifier = try container.decode(Calendar.Identifier.self)
            #endif
            self.calendar = Calendar.standard(identifier)
        } catch {
            self.calendar = try container.decode(Calendar.self)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        let standard = Calendar.standard(calendar.identifier)
        
        if standard.isEquivalent(to: calendar) {
            var single = encoder.singleValueContainer()
            #if os(Linux)
            // on Linux, Calendar.Identifier does not appear to be Codable
            // therefore, we must manually encode its value
            let encodingIdentifier = try calendar.identifier.encodingIdentifier
            try single.encode(encodingIdentifier)
            #else
            try single.encode(calendar.identifier)
            #endif
        } else {
            try calendar.encode(to: encoder)
        }
    }
    
}
