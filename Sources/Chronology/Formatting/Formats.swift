//
//  Formats.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 5/17/18.
//

import Foundation

internal protocol Format {
    var template: String { get }
}

public struct FormatTemplate<Field>: Format {
    internal let template: String
    internal init(_ template: String) {
        self.template = template
    }
}

public extension FormatTemplate where Field == EraField {
    static let narrow = FormatTemplate("GGGGG")
    static let abbreviated = FormatTemplate("G")
    static let wide = FormatTemplate("GGGG")
}

public extension FormatTemplate where Field == YearField {
    static let full = FormatTemplate("y")
    static let twoDigits = digits(paddedToLength: 2)
    static func digits(paddedToLength: Int) -> FormatTemplate {
        guard paddedToLength > 0 else { fatalError("Cannot pad to a length less than 1") }
        let template = "".padding(toLength: paddedToLength, withPad: "y", startingAt: 0)
        return FormatTemplate(template)
    }
}

public extension FormatTemplate where Field == MonthField {
    static let fullDigits = FormatTemplate("M")
    static let twoDigits = FormatTemplate("MM")
    static let abbreviated = FormatTemplate("MMM")
    static let fullName = FormatTemplate("MMMM")
    static let narrow = FormatTemplate("MMMMM")
}

public enum Standalone<Field> { }
public extension FormatTemplate where Field == Standalone<MonthField> {
    static let fullDigits = FormatTemplate("L")
    static let twoDigits = FormatTemplate("LL")
    static let abbreviated = FormatTemplate("LLL")
    static let fullName = FormatTemplate("LLLL")
    static let narrow = FormatTemplate("LLLLL")
}

public extension FormatTemplate where Field == DayField {
    static let full = FormatTemplate("d")
    static let twoDigits = FormatTemplate("dd")
}

public enum Weekday { }
public extension FormatTemplate where Field == Weekday {
    static let fullDigits = FormatTemplate("e")
    static let twoDigits = FormatTemplate("ee")
    static let abbreviated = FormatTemplate("eee")
    static let fullName = FormatTemplate("eeee")
    static let narrow = FormatTemplate("eeeee")
    static let short = FormatTemplate("eeeeee")
}

public extension FormatTemplate where Field == Standalone<Weekday> {
    static let fullDigits = FormatTemplate("c")
    static let twoDigits = FormatTemplate("cc")
    static let abbreviated = FormatTemplate("ccc")
    static let fullName = FormatTemplate("cccc")
    static let narrow = FormatTemplate("ccccc")
    static let short = FormatTemplate("cccccc")
}

public enum DayPeriod { }
public extension FormatTemplate where Field == DayPeriod {
    static let abbreviated = FormatTemplate("a")
    static let wide = FormatTemplate("aaaa")
    static let narrow = FormatTemplate("aaaaa")
}

public extension FormatTemplate where Field == HourField {
    static let full = FormatTemplate.full(with: nil)
    static let twoDigits = FormatTemplate.twoDigits(with: nil)
    
    static func full(with period: FormatTemplate<DayPeriod>? = .abbreviated) -> FormatTemplate {
        guard let p = period else { return FormatTemplate("J") }
        
        if p.template == FormatTemplate<DayPeriod>.wide.template {
            return FormatTemplate("jjj")
        } else if p.template == FormatTemplate<DayPeriod>.narrow.template {
            return FormatTemplate("jjjjj")
        } else {
            return FormatTemplate("j")
        }
    }
    
    static func twoDigits(with period: FormatTemplate<DayPeriod>? = .abbreviated) -> FormatTemplate {
        guard let p = period else { return FormatTemplate("JJ") }
        
        if p.template == FormatTemplate<DayPeriod>.wide.template {
            return FormatTemplate("jjjj")
        } else if p.template == FormatTemplate<DayPeriod>.narrow.template {
            return FormatTemplate("jjjjjj")
        } else {
            return FormatTemplate("jj")
        }
    }
    
}

public extension FormatTemplate where Field == MinuteField {
    static let full = FormatTemplate("m")
    static let twoDigits = FormatTemplate("mm")
}

public extension FormatTemplate where Field == SecondField {
    static let full = FormatTemplate("s")
    static let twoDigits = FormatTemplate("ss")
}

public extension FormatTemplate where Field == NanosecondField {
    static func digits(_ length: Int) -> FormatTemplate {
        guard length > 0 else { fatalError("Cannot pad to a length less than 1") }
        let template = "".padding(toLength: length, withPad: "S", startingAt: 0)
        return FormatTemplate(template)
    }
}

public extension FormatTemplate where Field == TimeZone {
    static let shortSpecific = FormatTemplate("z")
    static let longSpecific = FormatTemplate("zzzz")
    
    static let ISO8601Basic = FormatTemplate("Z")
    static let ISO8601Extended = FormatTemplate("ZZZZZ")
    
    static let shortLocalizedGMT = FormatTemplate("O")
    static let longLocalizedGMT = FormatTemplate("ZZZZ")
    
    static let shortGeneric = FormatTemplate("v")
    static let longGeneric = FormatTemplate("vvvv")
    
    static let shortID = FormatTemplate("V")
    static let longID = FormatTemplate("VV")
    static let exemplarCity = FormatTemplate("VVV")
    static let genericLocation = FormatTemplate("VVVV")
    
    static func ISO8601BasicWithHours(includingZ: Bool = false) -> FormatTemplate {
        return FormatTemplate(includingZ ? "X" : "x")
    }
    
    static func ISO8601WithHoursAndMinutes(extended: Bool = false, includingZ: Bool = false) -> FormatTemplate {
        if extended {
            return FormatTemplate(includingZ ? "XXX" : "xxx")
        } else {
            return FormatTemplate(includingZ ? "XX" : "xx")
        }
    }
    static func ISO8601WithHoursMinutesAndSeconds(extended: Bool = false, includingZ: Bool = false) -> FormatTemplate {
        if extended {
            return FormatTemplate(includingZ ? "XXXXX" : "xxxxx")
        } else {
            return FormatTemplate(includingZ ? "XXXX" : "xxxx")
        }
    }
}
