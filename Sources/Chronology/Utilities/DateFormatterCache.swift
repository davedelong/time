//
//  File.swift
//  
//
//  Created by Dave DeLong on 10/6/19.
//

import Foundation

internal class DateFormatterCache {
    
    internal static let shared = DateFormatterCache()
    
    private struct Key: Hashable {
        enum Configuration: Hashable {
            case template(String)
            case styles(DateFormatter.Style, DateFormatter.Style)
        }
        let configuration: Configuration
        let region: Region
    }
    
    private let queue = DispatchQueue(label: "DateFormatterCache")
    private var formatters = Dictionary<Key, DateFormatter>()
    
    private init() { }
    
    private func formatter(for key: Key) -> DateFormatter {
        return queue.sync {
            if let existing = formatters[key] { return existing }
            
            let formatter = DateFormatter()
            formatter.locale = key.region.locale
            formatter.calendar = key.region.calendar
            formatter.timeZone = key.region.timeZone
            switch key.configuration {
                case .template(let template):
                    formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: key.region.locale)
                case .styles(let date, let time):
                    formatter.dateStyle = date
                    formatter.timeStyle = time
            }
            formatters[key] = formatter
            
            return formatter
        }
    }
    
    func formatter(for template: String, region: Region) -> DateFormatter {
        let key = Key(configuration: .template(template), region: region)
        return formatter(for: key)
    }
    
    func formatter(for dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, region: Region) -> DateFormatter {
        let key = Key(configuration: .styles(dateStyle, timeStyle), region: region)
        return formatter(for: key)
    }
    
}
