//
//  Value+Components.swift
//  
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

public extension Absolute where Smallest: LTOEEra, Largest: GTOEEra {
    
    /// Retrieve the numeric era of an absolute calendrical value.
    var era: Int { return dateComponents.era.unwrap("A Value<\(Smallest.self), \(Largest.self)> must have an era value") }
}

public extension Absolute where Smallest: LTOEYear, Largest: GTOEYear {
    
    /// Retrieve the numeric year of an absolute calendrical value.
    var year: Int { return dateComponents.year.unwrap("A Value<\(Smallest.self), \(Largest.self)> must have a year value") }
}

public extension Value where Smallest: LTOEMonth, Largest: GTOEMonth {
    
    /// Retrieve the numeric month of an absolute calendrical value.
    var month: Int { return dateComponents.month.unwrap("A Value<\(Smallest.self), \(Largest.self)> must have a month value") }
}

public extension Value where Smallest: LTOEDay, Largest: GTOEDay {
    
    /// Retrieve the numeric day of an absolute calendrical value.
    var day: Int { return dateComponents.day.unwrap("A Value<\(Smallest.self), \(Largest.self)> must have a day value") }
}

public extension Value where Smallest: LTOEHour, Largest: GTOEHour {
    
    /// Retrieve the numeric hour of an absolute calendrical value.
    var hour: Int { return dateComponents.hour.unwrap("A Value<\(Smallest.self), \(Largest.self)> must have an hour value") }
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEMinute {
    
    /// Retrieve the numeric minute of an absolute calendrical value
    var minute: Int { return dateComponents.minute.unwrap("A Value<\(Smallest.self), \(Largest.self)> must have a minute value") }
}

public extension Value where Smallest: LTOESecond, Largest: GTOESecond {
    
    /// Retrieve the numeric second of an absolute calendrical value.
    var second: Int { return dateComponents.second.unwrap("A Value<\(Smallest.self), \(Largest.self)> must have a second value") }
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOENanosecond {
    
    /// Retrieve the numeric nanosecond of an absolute calendrical value.
    var nanosecond: Int { return dateComponents.nanosecond.unwrap("A Value<\(Smallest.self), \(Largest.self)> must have a nanosecond value") }
}
