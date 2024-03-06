import Foundation

internal enum FormatConfiguration: Hashable, Sendable {
    case template(String)
    case raw(String)
    case styles(DateFormatter.Style, DateFormatter.Style)
}

extension DateFormatter {
    
    internal struct Key: Hashable {
        let configuration: FormatConfiguration
        let calendar: Calendar
        let locale: Locale
        let timeZone: TimeZone
    }
    
    internal static func formatter(for key: Key) -> DateFormatter {
        return DateFormatterCache.shared.formatter(for: key)
    }
    
    internal static func formatter(for rawFormat: String, region: Region) -> DateFormatter {
        let key = Key(configuration: .raw(rawFormat), calendar: region.calendar, locale: region.locale, timeZone: region.timeZone)
        return self.formatter(for: key)
    }
    
    internal static func formatter(for templates: Array<Format?>, region: Region) -> DateFormatter {
        let template = templates.compactMap { $0?.template }.joined()
        if template.isEmpty { fatalError("Somehow have an empty template? this should not happen") }
        let key = Key(configuration: .template(template), calendar: region.calendar, locale: region.locale, timeZone: region.timeZone)
        return self.formatter(for: key)
    }
}

private class DateFormatterCache {
    
    static let shared = DateFormatterCache()
    
    private let lock = NSLock()
    private var formatters = Dictionary<DateFormatter.Key, DateFormatter>()
    
    private init() { }
    
    func formatter(for key: DateFormatter.Key) -> DateFormatter {
        lock.lock()
        let returnValue: DateFormatter
        
        if let existing = formatters[key] {
            returnValue = existing
        } else {
            let formatter = DateFormatter()
            formatter.locale = key.locale
            formatter.calendar = key.calendar
            formatter.timeZone = key.timeZone
            switch key.configuration {
                case .template(let template):
                    formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: key.locale)
                case .raw(let format):
                    formatter.dateFormat = format
                case .styles(let date, let time):
                    formatter.dateStyle = date
                    formatter.timeStyle = time
            }
            formatters[key] = formatter
            returnValue = formatter
        }
        
        lock.unlock()
        return returnValue
    }
    
}
