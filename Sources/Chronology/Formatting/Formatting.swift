//
//  Formatting.swift
//  Chronology
//
//  Created by Dave DeLong on 5/18/18.
//

import Foundation

internal protocol Format {
    var template: String { get }
}

extension CalendarValue {
    
    internal func format(date: Date, using: Array<Format?>) -> String {
        let template = using.compactMap { $0?.template }.joined()
        let localizedFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.timeZone = timeZone
        formatter.locale = locale
        formatter.dateFormat = localizedFormat
        
        return formatter.string(from: date)
    }
    
    internal func format(relative: Array<Format?>) -> String {
        let date: Date
        if let potential = calendar.date(from: dateComponents) {
            date = potential
        } else if let future = calendar.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .strict) {
            date = future
        } else if let past = calendar.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .strict, direction: .backward) {
            date = past
        } else {
            fatalError("Unable to construct date matching \(dateComponents)")
        }
        
        return format(date: date, using: relative)
    }
    
}

extension AbsoluteValue {
    
    internal func format(absolute: Array<Format?>) -> String {
        return format(date: approximateMidPoint.date, using: absolute)
    }
    
}
