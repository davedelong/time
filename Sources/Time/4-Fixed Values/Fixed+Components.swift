//
//  TimePeriod+Components.swift
//  
//
//  Created by Dave DeLong on 10/5/19.
//

import Foundation

extension Fixed {
    
    internal func value(for unit: Calendar.Component) -> Int {
        // TODO: what if it's a pseudo unit?
        return dateComponents.value(for: unit).unwrap("A Fixed<\(Smallest.self)> does not contain a represented \(unit)")
    }
    
}

extension Fixed {
    
    /// Retrieve the `Range` of `Instants` described by this `Fixed` value.
    ///
    /// All fixed values contain many possible `Instants`. This property allows you
    /// to retrieve that range to use in calculations, such as knowing things like:
    /// - do these two calendar values overlap?
    /// - is this calendar value contained within this other calendar value?
    /// - etc
    public var range: Range<Instant> {
        let range = calendar.range(containing: self.date, in: self.representedComponents)
        
        return Instant(date: range.lowerBound) ..< Instant(date: range.upperBound)
    }
    
    /// Retrieve the first `Instant` known to occur within this `Value`.
    public var firstInstant: Instant { return range.lowerBound }
    
    @available(*, unavailable, message: "It's impossible to know the last instant of a calendar value, just like it's impossible to know the last number before 1.0")
    public var lastInstant: Instant { fatalError() }
    
    /// Retrieve the numeric era of a fixed calendrical value.
    public var era: Int { dateComponents.era.unwrap("A Fixed<\(Smallest.self)> must have an era value") }
}

extension Fixed where Smallest: LTOEYear {
    
    /// Retrieve the numeric year of a fixed calendrical value.
    public var year: Int { dateComponents.year.unwrap("A Fixed<\(Smallest.self)> must have a year value") }
}

extension Fixed where Smallest: LTOEMonth {
    
    /// Retrieve the numeric month of a fixed calendrical value.
    public var month: Int { dateComponents.month.unwrap("A Fixed<\(Smallest.self)> must have a month value") }
}

extension Fixed where Smallest: LTOEDay {
    
    /// Retrieve the numeric day of a fixed calendrical value.
    public var day: Int { dateComponents.day.unwrap("A Fixed<\(Smallest.self)> must have a day value") }
}

extension Fixed where Smallest: LTOEHour {
    
    /// Retrieve the numeric hour of a fixed calendrical value.
    public var hour: Int { dateComponents.hour.unwrap("A Fixed<\(Smallest.self)> must have an hour value") }
}

extension Fixed where Smallest: LTOEMinute {
    
    /// Retrieve the numeric minute of a fixed calendrical value
    public var minute: Int { dateComponents.minute.unwrap("A Fixed<\(Smallest.self)> must have a minute value") }
}

extension Fixed where Smallest: LTOESecond {
    
    /// Retrieve the numeric second of a fixed calendrical value.
    public var second: Int { dateComponents.second.unwrap("A Fixed<\(Smallest.self)> must have a second value") }
}

extension Fixed where Smallest: LTOENanosecond {
    
    /// Retrieve the numeric nanosecond of a fixed calendrical value.
    public var nanosecond: Int { dateComponents.nanosecond.unwrap("A Fixed<\(Smallest.self)> must have a nanosecond value") }
}
