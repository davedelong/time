//
//  DateFormatterCache.swift
//  
//
//  Created by Dave DeLong on 10/6/19.
//

import Foundation

internal enum FormatConfiguration: Hashable {
    case template(String)
    case raw(String)
    case styles(DateFormatter.Style, DateFormatter.Style)
}

extension DateFormatter {
    
    internal struct Key: Hashable {
        let configuration: FormatConfiguration
        let region: Region
    }
    
    internal static func formatter(for key: Key) -> DateFormatter {
        return DateFormatterCache.shared.formatter(for: key)
    }
    
    internal static func formatter(for rawFormat: String, region: Region) -> DateFormatter {
        return self.formatter(for: .init(configuration: .raw(rawFormat), region: region))
    }
    
    internal static func formatter(for templates: Array<Format?>, region: Region) -> DateFormatter {
        let template = templates.compactMap { $0?.template }.joined()
        return self.formatter(for: .init(configuration: .template(template), region: region))
    }
}

private class DateFormatterCache {
    
    static let shared = DateFormatterCache()
    
    private let queue = DispatchQueue(label: "DateFormatterCache")
    
    private var formatters = Dictionary<DateFormatter.Key, DateFormatter>()
    
    private init() { }
    
    private func onqueue_nonupdatingFormatter(for key: DateFormatter.Key) -> DateFormatter {
        if let existing = formatters[key] { return existing }
        
        let formatter = DateFormatter()
        formatter.locale = key.region.locale
        formatter.calendar = key.region.calendar
        formatter.timeZone = key.region.timeZone
        switch key.configuration {
            case .template(let template):
                formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: key.region.locale)
            case .raw(let format):
                formatter.dateFormat = format
            case .styles(let date, let time):
                formatter.dateStyle = date
                formatter.timeStyle = time
        }
        formatters[key] = formatter
        
        return formatter
    }
    
    func formatter(for key: DateFormatter.Key) -> DateFormatter {
        return queue.sync {
            return onqueue_nonupdatingFormatter(for: key)
        }
    }
    
}
