//
//  File.swift
//  
//
//  Created by Dave DeLong on 1/20/24.
//

import Foundation

/// A type that encapsulates the information necessary to format a fixed value
internal struct FixedFormat<Granularity: Unit & LTOEEra> {
    
    internal let configuration: FormatConfiguration
    
    internal init(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) {
        self.configuration = .styles(dateStyle, timeStyle)
    }
    
    internal init(raw: String) {
        self.configuration = .raw(raw)
    }
    
    internal init(templates: Array<Format?>) {
        self.configuration = .template(templates.compactMap { $0?.template }.joined())
    }
    
    init(naturalFormats calendar: Calendar) {
        let formats = Fixed<Granularity>.naturalFormats(in: calendar)
        self.init(templates: formats)
    }
    
}
