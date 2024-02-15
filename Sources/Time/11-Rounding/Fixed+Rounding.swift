//
//  File.swift
//  
//
//  Created by Dave DeLong on 1/26/24.
//

import Foundation

/// An enum describing the direction to perform a rounding calculation
public enum RoundingDirection {
    
    /// Perform a rounding calculation such that the rounded value is preferred to be forward in time
    case forward
    
    /// Perform a rounding calcuation such that the rounded value is preferred to be backwards in time
    case backward
    
    /// Perform a rounding calculation towards the closer of two forwards and backwards values
    case nearest
}

extension Fixed where Granularity: LTOEYear {
    
    /// Round the fixed value towards the nearest boundary that matches a whole multiple.
    ///
    /// Equivalent to `roundedToMultiple(of: match, direction: .nearest)`
    ///
    /// - Parameter match: A `TimeDifference` that describes the desired boundary
    /// - Returns: A new fixed value
    public func roundedToNearestMultiple(of match: TimeDifference<Granularity, Era>) -> Self {
        return self.roundToMultiple(of: match, direction: .nearest)
    }
    
    /// Round the fixed value towards the nearest boundary that matches a whole multiple.
    ///
    /// This method rounds towards the nearest multiple of the `match`. Multiples are computed based on a a boundary.
    ///
    /// Example: consider a `Fixed<Second>` with time components of   `hour: 14, minute: 38, second: 42`. Rounding
    /// this value towards the nearest match of `.minutes(15)` will result in `hour: 14, minute: 45, second: 0`. The `minutes`
    /// of the returned value is a integer multiple of the specified `match`.
    ///
    /// Example: rounding that same value towards the nearest multiple of `.minutes(32)` will result in
    /// `hour: 15, minute: 0, second: 0`. When crossing the "boundary" of a larger unit (hours), the smaller units reset to their
    /// zero values, and `0` is considered a whole multiple of any number.
    ///
    /// - Parameter match: A `TimeDifference` that describes the desired boundary
    /// - Parameter direction: The preferred rounding direction
    /// - Returns: A new fixed value
    public func roundedToMultiple(of match: TimeDifference<Granularity, Era>, direction: RoundingDirection) -> Self {
        return self.roundToMultiple(of: match, direction: direction)
    }
    
    /// Round the receiver towards an Era boundary
    ///
    /// - Warning: This method may end up rounding backwards (down), even if the `direction` is `.forward`.
    /// This happens if there is no "next" era. For example, on the Gregorian calendar, there are only two
    /// eras: 0 (BC/BCE) and 1 (AD/CE). A `Fixed` value in the AD era that is asked to round forward will
    /// always round *down* to the start of the AD era, because there is no known future era boundary.
    ///
    /// - Parameter direction: The suggested rounding direction
    /// - Returns: A `Fixed` value whose `.firstInstant` is an Era boundary
    public func roundedToEra(direction: RoundingDirection) -> Self {
        round(to: Era.self, direction: direction)
    }
    
    /// Round the receiver towards the nearest Era boundary
    ///
    /// Equivalent to `.roundedToEra(direction: .nearest)`
    ///
    /// - Returns: A `Fixed` value whose `.firstInstant` is an Era boundary
    public func roundedToNearestEra() -> Self {
        round(to: Era.self, direction: .nearest)
    }
    
    /// Retrieve the nearest `Fixed<Era>`
    public var nearestEra: Fixed<Era> { roundedToNearestEra().fixedEra }
}

extension Fixed where Granularity: LTOEMonth {
    
    /// Round this fixed value towards a year boundary
    /// - Parameter direction: The preferred rounding direction
    /// - Returns: A fixed value whose `.firstInstant` is a year boundary
    public func roundedToYear(direction: RoundingDirection) -> Self {
        round(to: Year.self, direction: direction)
    }
    
    /// Round this fixed value towards the nearest year boundary
    ///
    /// Equivalent to `.roundedToYear(direction: .nearest)`
    ///
    /// - Returns: A fixed value whose `.firstInstant` is a year boundary
    public func roundedToNearestYear() -> Self {
        round(to: Year.self, direction: .nearest)
    }
    
    /// Retrieve the nearest `Fixed<Year>`
    public var nearestYear: Fixed<Year> { roundedToNearestYear().fixedYear }
}

extension Fixed where Granularity: LTOEDay {
    
    /// Round this fixed value towards a month boundary
    /// - Parameter direction: The preferred rounding direction
    /// - Returns: A fixed value whose `.firstInstant` is a month boundary
    public func roundedToMonth(direction: RoundingDirection) -> Self {
        round(to: Month.self, direction: direction)
    }
    
    /// Round this fixed value towards the nearest month boundary
    ///
    /// Equivalent to `.roundedToMonth(direction: .nearest)`
    ///
    /// - Returns: A fixed value whose `.firstInstant` is a month boundary
    public func roundedToNearestMonth() -> Self {
        round(to: Month.self, direction: .nearest)
    }
    
    /// Retrieve the nearest `Fixed<Month>`
    public var nearestMonth: Fixed<Month> { roundedToNearestMonth().fixedMonth }
}

extension Fixed where Granularity: LTOEHour {
    
    /// Round this fixed value towards a day boundary
    /// - Parameter direction: The preferred rounding direction
    /// - Returns: A fixed value whose `.firstInstant` is a day boundary
    public func roundedToDay(direction: RoundingDirection) -> Self {
        round(to: Day.self, direction: direction)
    }
    
    /// Round this fixed value towards the nearest day boundary
    ///
    /// Equivalent to `.roundedToDay(direction: .nearest)`
    ///
    /// - Returns: A fixed value whose `.firstInstant` is a day boundary
    public func roundedToNearestDay() -> Self {
        round(to: Day.self, direction: .nearest)
    }
    
    /// Retrieve the nearest `Fixed<Day>`
    public var nearestDay: Fixed<Day> { roundedToNearestDay().fixedDay }
}

extension Fixed where Granularity: LTOEMinute {
    
    /// Round this fixed value towards an hour boundary
    /// - Parameter direction: The preferred rounding direction
    /// - Returns: A fixed value whose `.firstInstant` is an hour boundary
    public func roundedToHour(direction: RoundingDirection) -> Self {
        round(to: Hour.self, direction: direction)
    }
    
    /// Round this fixed value towards the nearest hour boundary
    ///
    /// Equivalent to `.roundedToHour(direction: .nearest)`
    ///
    /// - Returns: A fixed value whose `.firstInstant` is an hour boundary
    public func roundedToNearestHour() -> Self {
        round(to: Hour.self, direction: .nearest)
    }
    
    /// Retrieve the nearest `Fixed<Hour>`
    public var nearestHour: Fixed<Hour> { roundedToNearestHour().fixedHour }
}

extension Fixed where Granularity: LTOESecond {
    
    /// Round this fixed value towards a minute boundary
    /// - Parameter direction: The preferred rounding direction
    /// - Returns: A fixed value whose `.firstInstant` is a minute boundary
    public func roundedToMinute(direction: RoundingDirection) -> Self {
        round(to: Minute.self, direction: direction)
    }
    
    /// Round this fixed value towards the nearest minute boundary
    ///
    /// Equivalent to `.roundedToMinute(direction: .nearest)`
    ///
    /// - Returns: A fixed value whose `.firstInstant` is a minute boundary
    public func roundedToNearestMinute() -> Self {
        round(to: Minute.self, direction: .nearest)
    }
    
    /// Retrieve the nearest `Fixed<Minute>`
    public var nearestMinute: Fixed<Minute> { roundedToNearestMinute().fixedMinute }
}

extension Fixed where Granularity: LTOENanosecond {
    
    /// Round this fixed value towards a second boundary
    /// - Parameter direction: The preferred rounding direction
    /// - Returns: A fixed value whose `.firstInstant` is a second boundary
    public func roundedToSecond(direction: RoundingDirection) -> Self {
        round(to: Second.self, direction: direction)
    }
    
    /// Round this fixed value towards the nearest second boundary
    ///
    /// Equivalent to `.roundedToSecond(direction: .nearest)`
    ///
    /// - Returns: A fixed value whose `.firstInstant` is a second boundary
    public func roundedToNearestSecond() -> Self {
        round(to: Second.self, direction: .nearest)
    }
    
    /// Retrieve the nearest `Fixed<Second>`
    public var nearestSecond: Fixed<Second> { roundedToNearestSecond().fixedSecond }
}
