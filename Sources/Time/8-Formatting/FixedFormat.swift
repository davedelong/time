import Foundation

/// A type that encapsulates the information necessary to format a fixed value
public struct FixedFormat<Granularity: Unit & LTOEEra>: Sendable {
    
    internal let configuration: FormatConfiguration
    
    internal init(configuration: FormatConfiguration) {
        self.configuration = configuration
    }
    
}

internal enum FormatConfiguration: Hashable, Sendable {
    case template(String)
    case raw(String)
    case styles(FixedFormatStyle?, FixedFormatStyle?)
}

extension FixedFormat {
    
    internal init(dateStyle: FixedFormatStyle?, timeStyle: FixedFormatStyle?) {
        self.init(configuration: .styles(dateStyle, timeStyle))
    }
    
    internal init(templates: Array<Format?>) {
        self.init(configuration: .template(templates.compactMap { $0?.template }.joined()))
    }
    
    init(naturalFormats calendar: any CalendarProtocol) {
        let formats = Fixed<Granularity>.naturalFormats(in: calendar)
        self.init(templates: formats)
    }
    
}
