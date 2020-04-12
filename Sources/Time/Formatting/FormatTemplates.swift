//
//  FormatTemplates.swift
//  Time
//
//  Created by Dave DeLong on 5/17/18.
//

import Foundation

public struct Template<F>: Format {
    internal let template: String
    internal init(_ template: String) {
        self.template = template
    }
}

public extension Template where F == Era {
    static let narrow = Template("GGGGG")
    static let abbreviated = Template("G")
    static let wide = Template("GGGG")
}

public extension Template where F == Year {
    static let full = Template("y")
    static let twoDigits = digits(paddedToLength: 2)
    static func digits(paddedToLength: Int) -> Template {
        guard paddedToLength > 0 else { fatalError("Cannot pad to a length less than 1") }
        let template = String(repeating: "y", count: paddedToLength)
        return Template(template)
    }
}

public extension Template where F == Month {
    static let fullDigits = Template("M")
    static let twoDigits = Template("MM")
    static let abbreviatedName = Template("MMM")
    static let fullName = Template("MMMM")
    static let narrowName = Template("MMMMM")
}

public enum Standalone<Field> { }
public extension Template where F == Standalone<Month> {
    static let fullDigits = Template("L")
    static let twoDigits = Template("LL")
    static let abbreviatedName = Template("LLL")
    static let fullName = Template("LLLL")
    static let narrowName = Template("LLLLL")
}

public extension Template where F == Day {
    static let full = Template("d")
    static let twoDigits = Template("dd")
}

public enum Weekday { }
public extension Template where F == Weekday {
    static let fullDigits = Template("e")
    static let twoDigits = Template("ee")
    static let abbreviatedName = Template("eee")
    static let fullName = Template("eeee")
    static let narrowName = Template("eeeee")
    static let shortName = Template("eeeeee")
}

public extension Template where F == Standalone<Weekday> {
// these don't appear to be working correctly. Until I figure out what's going on, let's leave them out
//    static let fullDigits = Template("c")
//    static let twoDigits = Template("cc")
    static let fullName = Template("cccc")
    static let abbreviatedName = Template("ccc")
    static let shortName = Template("cccccc")
    static let narrowName = Template("ccccc")
}

public enum DayPeriod { }
public extension Template where F == DayPeriod {
    static let abbreviated = Template("a")
    static let wide = Template("aaaa")
    static let narrow = Template("aaaaa")
}

public extension Template where F == Hour {
    static let full = Template.full(with: nil)
    static let twoDigits = Template.twoDigits(with: nil)
    
    static func full(with period: Template<DayPeriod>? = .abbreviated) -> Template {
        guard let p = period else { return Template("J") }
        
        if p.template == Template<DayPeriod>.wide.template {
            return Template("jjj")
        } else if p.template == Template<DayPeriod>.narrow.template {
            return Template("jjjjj")
        } else {
            return Template("j")
        }
    }
    
    static func twoDigits(with period: Template<DayPeriod>? = .abbreviated) -> Template {
        guard let p = period else { return Template("JJ") }
        
        if p.template == Template<DayPeriod>.wide.template {
            return Template("jjjj")
        } else if p.template == Template<DayPeriod>.narrow.template {
            return Template("jjjjjj")
        } else {
            return Template("jj")
        }
    }
    
}

public extension Template where F == Minute {
    static let full = Template("m")
    static let twoDigits = Template("mm")
}

public extension Template where F == Second {
    static let full = Template("s")
    static let twoDigits = Template("ss")
}

public extension Template where F == Nanosecond {
    static func digits(_ length: Int) -> Template {
        guard length > 0 else { fatalError("Cannot pad to a length less than 1") }
        let template = String(repeating: "S", count: length)
        return Template(template)
    }
}

public extension Template where F == TimeZone {
    static let shortSpecific = Template("z")
    static let longSpecific = Template("zzzz")
    
    static let ISO8601Basic = Template("Z")
    static let ISO8601Extended = Template("ZZZZZ")
    
    static let shortLocalizedGMT = Template("O")
    static let longLocalizedGMT = Template("ZZZZ")
    
    static let shortGeneric = Template("v")
    static let longGeneric = Template("vvvv")
    
    static let shortID = Template("V")
    static let longID = Template("VV")
    static let exemplarCity = Template("VVV")
    static let genericLocation = Template("VVVV")
    
    static func ISO8601BasicWithHours(includingZ: Bool = false) -> Template {
        return Template(includingZ ? "X" : "x")
    }
    
    static func ISO8601WithHoursAndMinutes(extended: Bool = false, includingZ: Bool = false) -> Template {
        if extended {
            return Template(includingZ ? "XXX" : "xxx")
        } else {
            return Template(includingZ ? "XX" : "xx")
        }
    }
    static func ISO8601WithHoursMinutesAndSeconds(extended: Bool = false, includingZ: Bool = false) -> Template {
        if extended {
            return Template(includingZ ? "XXXXX" : "xxxxx")
        } else {
            return Template(includingZ ? "XXXX" : "xxxx")
        }
    }
}
