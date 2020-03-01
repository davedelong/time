//
//  DateFormatterCache.swift
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
    
    private var registeredForAutoupdatingNotifications = false
    private var autoupdating = Dictionary<Key, DateFormatter>()
    
    private init() { }
    
    private func onqueue_registerForAutoupdatingChanges() {
        guard registeredForAutoupdatingNotifications == false else { return }
        
        let observer: (Notification) -> Void = { [weak self] _ in
            self?.resetAutoupdatingFormatters()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.NSSystemTimeZoneDidChange, object: nil, queue: nil, using: observer)
        NotificationCenter.default.addObserver(forName: NSLocale.currentLocaleDidChangeNotification, object: nil, queue: nil, using: observer)
        
        registeredForAutoupdatingNotifications = true
    }
    
    private func resetAutoupdatingFormatters() {
        queue.async {
            self.autoupdating.removeAll()
        }
    }
    
    private func onqueue_autoupdatingFormatter(for key: Key) -> DateFormatter {
        if let existing = autoupdating[key] { return existing }
        
        let formatter = DateFormatter()
        formatter.locale = key.region.locale.isAutoupdating ? .current : key.region.locale
        formatter.calendar = key.region.calendar.isAutoupdating ? .current : key.region.calendar
        formatter.timeZone = key.region.timeZone.isAutoupdating ? .current : key.region.timeZone
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
    
    private func onqueue_nonupdatingFormatter(for key: Key) -> DateFormatter {
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
    
    private func formatter(for key: Key) -> DateFormatter {
        return queue.sync {
            if key.region.isAutoupdating {
                return onqueue_autoupdatingFormatter(for: key)
            } else {
                return onqueue_nonupdatingFormatter(for: key)
            }
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
