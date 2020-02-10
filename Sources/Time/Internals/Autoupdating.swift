//
//  Autoupdating.swift
//  
//
//  Created by Dave DeLong on 10/6/19.
//

import Foundation

extension Region {
    internal var isAutoupdating: Bool {
        return timeZone.isAutoupdating || calendar.isAutoupdating || locale.isAutoupdating
    }
}

extension TimeZone {
    var isAutoupdating: Bool { return self == .autoupdatingCurrent }
}

extension Calendar {
    var isAutoupdating: Bool { return self == .autoupdatingCurrent }
}

extension Locale {
    var isAutoupdating: Bool { return self == .autoupdatingCurrent }
}
