//
//  File.swift
//  
//
//  Created by Dave DeLong on 1/26/24.
//

import Foundation

// https://gist.github.com/davedelong/466bf3d63037529f4709d779d83a9896

public enum RoundingDirection {
    case forward
    case backward
    case nearest
}

extension Fixed where Smallest: LTOEYear {
    
    public func roundedToNearestMultiple(of match: TimeDifference<Smallest, Era>) -> Self {
        return self.roundToMultiple(of: match, direction: .nearest)
    }
    
    public func roundedToMultiple(of match: TimeDifference<Smallest, Era>, direction: RoundingDirection) -> Self {
        return self.roundToMultiple(of: match, direction: direction)
    }
    
    /// Round the receiver towards an Era boundary
    ///
    /// This method may end up rounding backwards (down), even if the `direction` is `.forward`.
    /// This happens if there is no "next" era. For example, on the Gregorian calendar, there are only two
    /// eras: 0 (BC/BCE) and 1 (AD/CE). A `Fixed` value in the AD era that is asked to round forward will
    /// always round *down* to the start of the AD era, because there is no known future era boundary.
    ///
    /// - Parameter direction: The suggested rounding direction
    /// - Returns: A `Fixed` value whos `.firstInstant` is an Era boundary
    public func roundedToEra(direction: RoundingDirection) -> Self {
        round(to: Era.self, direction: direction)
    }
    
    public func roundedToNearestEra() -> Self {
        round(to: Era.self, direction: .nearest)
    }
    
    public var nearestEra: Fixed<Era> { roundedToNearestEra().fixedEra }
}

extension Fixed where Smallest: LTOEMonth {
    // round to year
    
    public func roundedToYear(direction: RoundingDirection) -> Self {
        round(to: Year.self, direction: direction)
    }
    
    public func roundedToNearestYear() -> Self {
        round(to: Year.self, direction: .nearest)
    }
    
    public var nearestYear: Fixed<Year> { roundedToNearestYear().fixedYear }
}

extension Fixed where Smallest: LTOEDay {
    // round to month
    
    public func roundedToMonth(direction: RoundingDirection) -> Self {
        round(to: Month.self, direction: direction)
    }
    
    public func roundedToNearestMonth() -> Self {
        round(to: Month.self, direction: .nearest)
    }
    
    public var nearestMonth: Fixed<Month> { roundedToNearestMonth().fixedMonth }
}

extension Fixed where Smallest: LTOEHour {
    // round to day
    
    public func roundedToDay(direction: RoundingDirection) -> Self {
        round(to: Day.self, direction: direction)
    }
    
    public func roundedToNearestDay() -> Self {
        round(to: Day.self, direction: .nearest)
    }
    
    public var nearestDay: Fixed<Day> { roundedToNearestDay().fixedDay }
}

extension Fixed where Smallest: LTOEMinute {
    // round to hour
    
    public func roundedToHour(direction: RoundingDirection) -> Self {
        round(to: Hour.self, direction: direction)
    }
    
    public func roundedToNearestHour() -> Self {
        round(to: Hour.self, direction: .nearest)
    }
    
    public var nearestHour: Fixed<Hour> { roundedToNearestHour().fixedHour }
}

extension Fixed where Smallest: LTOESecond {
    // round to minute
    
    public func roundedToMinute(direction: RoundingDirection) -> Self {
        round(to: Minute.self, direction: direction)
    }
    
    public func roundedToNearestMinute() -> Self {
        round(to: Minute.self, direction: .nearest)
    }
    
    public var nearestMinute: Fixed<Minute> { roundedToNearestMinute().fixedMinute }
}

extension Fixed where Smallest: LTOENanosecond {
    // round to second
    
    public func roundedToSecond(direction: RoundingDirection) -> Self {
        round(to: Second.self, direction: direction)
    }
    
    public func roundedToNearestSecond() -> Self {
        round(to: Second.self, direction: .nearest)
    }
    
    public var nearestSecond: Fixed<Second> { roundedToNearestSecond().fixedSecond }
}
