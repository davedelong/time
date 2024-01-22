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

extension Template where F == Era {
    
    public static let narrow = Template("GGGGG")
    public static let abbreviated = Template("G")
    public static let wide = Template("GGGG")
    
}

extension Template where F == Year {
    
    public static let naturalDigits = Template("y")
    public static let twoDigits = digits(paddedToLength: 2)
    public static func digits(paddedToLength: Int) -> Template {
        guard paddedToLength > 0 else { fatalError("Cannot pad to a length less than 1") }
        let template = String(repeating: "y", count: paddedToLength)
        return Template(template)
    }
    
}

extension Template where F == Month {
    
    public static let naturalDigits = Template("M")
    public static let twoDigits = Template("MM")
    public static let abbreviatedName = Template("MMM")
    public static let naturalName = Template("MMMM")
    public static let narrowName = Template("MMMMM")
    
}

public enum Standalone<Field> { }

extension Template where F == Standalone<Month> {
    
    public static let naturalDigits = Template("L")
    public static let twoDigits = Template("LL")
    public static let abbreviatedName = Template("LLL")
    public static let naturalName = Template("LLLL")
    public static let narrowName = Template("LLLLL")
    
}

extension Template where F == Day {
    
    public static let naturalDigits = Template("d")
    public static let twoDigits = Template("dd")
    
}

public enum Weekday { }

extension Template where F == Weekday {
    
    public static let naturalDigits = Template("e")
    public static let twoDigits = Template("ee")
    public static let abbreviatedName = Template("eee")
    public static let naturalName = Template("eeee")
    public static let narrowName = Template("eeeee")
    public static let shortName = Template("eeeeee")
    
}

extension Template where F == Standalone<Weekday> {
    
    // these don't appear to be working correctly. Until I figure out what's going on, let's leave them out
    //    public static let naturalDigits = Template("c")
    //    public static let twoDigits = Template("cc")
    public static let naturalName = Template("cccc")
    public static let abbreviatedName = Template("ccc")
    public static let shortName = Template("cccccc")
    public static let narrowName = Template("ccccc")
    
}

public enum DayPeriod { }

extension Template where F == DayPeriod {
    
    public static let natural = Template("a")
    public static let wide = Template("aaaa")
    public static let narrow = Template("aaaaa")
    
}

extension Template where F == Hour {
    
    public static let naturalDigits = Template.naturalDigits(designator: .natural)
    public static let twoDigits = Template.twoDigits(designator: .natural)
    
    public static func naturalDigits(designator period: Template<DayPeriod>?) -> Template {
        guard let p = period else { return Template("J") }
        
        if p.template == Template<DayPeriod>.wide.template {
            return Template("jjj")
        } else if p.template == Template<DayPeriod>.narrow.template {
            return Template("jjjjj")
        } else {
            return Template("j")
        }
    }
    
    public static func twoDigits(designator period: Template<DayPeriod>?) -> Template {
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

extension Template where F == Minute {
    
    public static let naturalDigits = Template("m")
    public static let twoDigits = Template("mm")
    
}

extension Template where F == Second {
    
    public static let naturalDigits = Template("s")
    public static let twoDigits = Template("ss")
    
}

extension Template where F == Nanosecond {
    
    public static func digits(_ length: Int) -> Template {
        guard length > 0 else { fatalError("Cannot pad to a length less than 1") }
        let template = String(repeating: "S", count: length)
        return Template(template)
    }
    
}

extension Template where F == TimeZone {
    
    public static let shortSpecific = Template("z")
    public static let longSpecific = Template("zzzz")
    
    public static let ISO8601Basic = Template("Z")
    public static let ISO8601Extended = Template("ZZZZZ")
    
    public static let shortLocalizedGMT = Template("O")
    public static let longLocalizedGMT = Template("ZZZZ")
    
    public static let shortGeneric = Template("v")
    public static let longGeneric = Template("vvvv")
    
    public static let shortID = Template("V")
    public static let longID = Template("VV")
    public static let exemplarCity = Template("VVV")
    public static let genericLocation = Template("VVVV")
    
    public static func ISO8601BasicWithHours(includingZ: Bool = false) -> Template {
        return Template(includingZ ? "X" : "x")
    }
    
    public static func ISO8601WithHoursAndMinutes(extended: Bool = false, includingZ: Bool = false) -> Template {
        if extended {
            return Template(includingZ ? "XXX" : "xxx")
        } else {
            return Template(includingZ ? "XX" : "xx")
        }
    }
    public static func ISO8601WithHoursMinutesAndSeconds(extended: Bool = false, includingZ: Bool = false) -> Template {
        if extended {
            return Template(includingZ ? "XXXXX" : "xxxxx")
        } else {
            return Template(includingZ ? "XXXX" : "xxxx")
        }
    }
    
}
