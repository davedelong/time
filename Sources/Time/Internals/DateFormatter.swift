#if os(Linux)
@preconcurrency import Foundation
#else
import Foundation
#endif

// swiftlint:disable prefer-anycalendar

internal struct FormatterKey: Hashable {
    let configuration: FormatConfiguration
    // this uses a Foundation.Calendar because that's what DateFormatter requires
    let calendar: Calendar
    let locale: Locale
    let timeZone: TimeZone
}

extension DateFormatter {
    
    internal static func formatter(for key: FormatterKey) -> DateFormatter {
        return dateFormatterCache.get(key, create: {
            DateFormatter(key: key)
        })
    }
    
    internal static func formatter(for rawFormat: String, region: Region) -> DateFormatter {
        let key = FormatterKey(configuration: .raw(rawFormat), calendar: region.calendar, locale: region.locale, timeZone: region.timeZone)
        return self.formatter(for: key)
    }
    
    private convenience init(key: FormatterKey) {
        self.init()
        self.locale = key.locale
        self.calendar = key.calendar
        self.timeZone = key.timeZone
        switch key.configuration {
            case .template(let template):
                self.dateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: key.locale)
            case .raw(let format):
                self.dateFormat = format
            case .styles(let date, let time):
                self.dateStyle = date?.style ?? .none
                self.timeStyle = time?.style ?? .none
        }
    }
}

private let dateFormatterCache = SimpleCache<FormatterKey, DateFormatter>()
