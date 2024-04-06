import Foundation

extension RegionalClock {
    
    /// Retrieve the current `Fixed` calendrical value, accurate down to the specified unit.
    public func current<U: Unit>(_ unit: U.Type = U.self) -> Fixed<U> {
        return Fixed(region: self.region, instant: self.now)
    }
    
    /// Retrieve the current calendar day of the `RegionalClock`.
    ///
    /// This is equivalent to `.current(Day.self)`
    public var today: Fixed<Day> { return current() }
    
    /// Retrieve the next calendar day of this `RegionalClock`
    public var tomorrow: Fixed<Day> { return current().next }
    
    /// Retrieve the previous calendar day of this `RegionalClock`
    public var yesterday: Fixed<Day> { return current().previous }
    
    /// Retrieve the current calendar era of the `RegionalClock`.
    public var currentEra: Fixed<Era> { return current() }
    
    /// Retrieve the current calendar year of the `RegionalClock`.
    public var currentYear: Fixed<Year> { return current() }
    
    /// Retrieve the current calendar month of the `RegionalClock`.
    public var currentMonth: Fixed<Month> { return current() }
    
    /// Retrieve the current calendar week of the `RegionalClock`.
    public var currentWeek: Fixed<Week> { return current() }
    
    /// Retrieve the current calendar day of the `RegionalClock`.
    public var currentDay: Fixed<Day> { return current() }
    
    /// Retrieve the current calendar hour of the `RegionalClock`.
    public var currentHour: Fixed<Hour> { return current() }
    
    /// Retrieve the current calendar minute of the `RegionalClock`.
    public var currentMinute: Fixed<Minute> { return current() }
    
    /// Retrieve the current calendar second of the `RegionalClock`.
    public var currentSecond: Fixed<Second> { return current() }
    
    /// Retrieve the current calendar nanosecond of the `RegionalClock`.
    public var currentNanosecond: Fixed<Nanosecond> { return current() }
    
    /// Retrieve the next calendar year of the `RegionalClock`
    public var nextYear: Fixed<Year> { return current().next }
    
    /// Retrieve the next calendar month of the `RegionalClock`
    public var nextMonth: Fixed<Month> { return current().next }
    
    /// Retrieve the next calendar week of the `RegionalClock`
    public var nextWeek: Fixed<Week> { return current().next }
    
    /// Retrieve the next calendar day of the `RegionalClock`
    public var nextDay: Fixed<Day> { return current().next }
    
    /// Retrieve the next calendar hour of the `RegionalClock`
    public var nextHour: Fixed<Hour> { return current().next }
    
    /// Retrieve the next calendar minute of the `RegionalClock`
    public var nextMinute: Fixed<Minute> { return current().next }
    
    /// Retrieve the next calendar second of the `RegionalClock`
    public var nextSecond: Fixed<Second> { return current().next }
    
    /// Retrieve the previous calendar year of the `RegionalClock`
    public var previousYear: Fixed<Year> { return current().previous }
    
    /// Retrieve the previous calendar month of the `RegionalClock`
    public var previousMonth: Fixed<Month> { return current().previous }
    
    /// Retrieve the previous calendar week of the `RegionalClock`
    public var previousWeek: Fixed<Week> { return current().previous }
    
    /// Retrieve the previous calendar day of the `RegionalClock`
    public var previousDay: Fixed<Day> { return current().previous }
    
    /// Retrieve the previous calendar hour of the `RegionalClock`
    public var previousHour: Fixed<Hour> { return current().previous }
    
    /// Retrieve the previous calendar minute of the `RegionalClock`
    public var previousMinute: Fixed<Minute> { return current().previous }
    
    /// Retrieve the previous calendar second of the `RegionalClock`
    public var previousSecond: Fixed<Second> { return current().previous }
    
}
