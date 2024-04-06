import Foundation

extension Fixed {
    
    /// Retrieve the `Range` of `Instants` described by this `Fixed` value.
    ///
    /// All fixed values contain many possible `Instants`. This property allows you
    /// to retrieve that range to use in calculations, such as knowing things like:
    /// - do these two calendar values overlap?
    /// - is this calendar value contained within this other calendar value?
    /// - etc
    public var range: Range<Instant> {
        let range = calendar.range(of: Granularity.component, containing: self.instant.date)
        
        return Instant(date: range.lowerBound) ..< Instant(date: range.upperBound)
    }
    
    /// Retrieve the first `Instant` known to occur within this `Value`.
    public var firstInstant: Instant { return range.lowerBound }
    
    @available(*, unavailable, message: "It's impossible to know the last instant of a calendar value, just like it's impossible to know the last number before 1.0")
    public var lastInstant: Instant { fatalError() }
    
    /// Retrieve the numeric era of a fixed calendrical value.
    ///
    /// This value is typically very low (`0` or `1`), but some calendars use eras extensively and can return values much larger.
    public var era: Int { dateComponents.era.unwrap("A Fixed<\(Granularity.self)> must have an era value") }
}

extension Fixed where Granularity: StandardUnit & LTOEYear {
    
    /// Retrieve the numeric year of a fixed calendrical value.
    public var year: Int { dateComponents.year.unwrap("A Fixed<\(Granularity.self)> must have a year value") }
}

extension Fixed where Granularity: StandardUnit & LTOEMonth {
    
    /// Retrieve the numeric month of a fixed calendrical value.
    public var month: Int { dateComponents.month.unwrap("A Fixed<\(Granularity.self)> must have a month value") }
}

extension Fixed where Granularity: StandardUnit & LTOEDay {
    
    /// Retrieve the numeric day of a fixed calendrical value.
    public var day: Int { dateComponents.day.unwrap("A Fixed<\(Granularity.self)> must have a day value") }
}

extension Fixed where Granularity: StandardUnit & LTOEHour {
    
    /// Retrieve the numeric hour of a fixed calendrical value.
    public var hour: Int { dateComponents.hour.unwrap("A Fixed<\(Granularity.self)> must have an hour value") }
}

extension Fixed where Granularity: StandardUnit & LTOEMinute {
    
    /// Retrieve the numeric minute of a fixed calendrical value
    public var minute: Int { dateComponents.minute.unwrap("A Fixed<\(Granularity.self)> must have a minute value") }
}

extension Fixed where Granularity: StandardUnit & LTOESecond {
    
    /// Retrieve the numeric second of a fixed calendrical value.
    public var second: Int { dateComponents.second.unwrap("A Fixed<\(Granularity.self)> must have a second value") }
}

extension Fixed where Granularity: StandardUnit & LTOENanosecond {
    
    /// Retrieve the numeric nanosecond of a fixed calendrical value.
    public var nanosecond: Int { dateComponents.nanosecond.unwrap("A Fixed<\(Granularity.self)> must have a nanosecond value") }
}
