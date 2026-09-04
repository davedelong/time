#if os(Linux)
@preconcurrency import Foundation
#else
import Foundation
#endif

// swiftlint:disable prefer-anycalendar

extension DateIntervalFormatter {
    
    internal static func formatter(for key: FormatterKey) -> DateIntervalFormatter {
        return intervalFormatterCache.get(key, create: {
            DateIntervalFormatter(key: key)
        })
    }
    
    private convenience init(key: FormatterKey) {
        self.init()
        self.locale = key.locale
        self.calendar = key.calendar
        self.timeZone = key.timeZone
        switch key.configuration {
            case .template(let template):
                self.dateTemplate = template
            case .raw(let format):
                self.dateTemplate = format
            case .styles(let date, let time):
                self.dateStyle = date?.intervalStyle ?? .none
                self.timeStyle = time?.intervalStyle ?? .none
        }
    }
}

private let intervalFormatterCache = SimpleCache<FormatterKey, DateIntervalFormatter>()
