//
//  Adjustment+AbsoluteConvenience.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Value where Largest: GTOEEra {
    
    /// Adjust an absolute value by applying a temporal delta value
    ///
    /// - Parameter delta: The `Difference` that describes the difference between the receiver
    ///    and the produced value.
    func applying(delta: Difference<Smallest, Largest>) -> Value<Smallest, Largest> {
        let adjuster = Adjustment<Smallest, Largest, Smallest, Largest> {
            let d = $0.range.lowerBound.date
            let diff = delta.dateComponents
            let newDate = $0.calendar.date(byAdding: diff, to: d).unwrap("Unable to add \(diff) to \($0)")
            return Value<Smallest, Largest>(region: $0.region, date: newDate)
        }
        return applying(adjuster)
    }

}

public extension Value where Smallest: LTOEYear, Largest: GTOEEra {
    
    /// Create a new `Value` by moving forward one year
    func nextYear() -> Self { return adding(years: 1) }
    
    /// Create a new `Value` by moving backward one year
    func previousYear() -> Self { return subtracting(years: 1) }
    
    /// Create a new `Value` by moving forward some number of years
    /// - Parameter years: The number of years by which to move forward
    func adding(years: Int) -> Self { return applying(delta: .years(years)) }
    
    /// Create a new `Value` by moving backward some number of years
    /// - Parameter years: The number of years by which to move backward
    func subtracting(years: Int) -> Self { return applying(delta: .years(-years)) }
    
}

public extension Value where Smallest: LTOEMonth, Largest: GTOEEra {
    
    /// Create a new `Value` by moving forward one month
    func nextMonth() -> Self { return adding(months: 1) }
    
    /// Create a new `Value` by moving backward one month
    func previousMonth() -> Self { return subtracting(months: 1) }
    
    /// Create a new `Value` by moving forwward some number of months
    /// - Parameter months: The number of months by which to move forward
    func adding(months: Int) -> Self { return applying(delta: .months(months)) }
    
    /// Create a new `Value` by moving backward some number of months
    /// - Parameter months: The number of months by which to move backward
    func subtracting(months: Int) -> Self { return applying(delta: .months(-months)) }
    
}

public extension Value where Smallest: LTOEDay, Largest: GTOEEra {
    
    /// Adjust the date to the beginning of the calendar's week
    func startOfWeek() -> Self {
        var s = self
        let targetWeekday = region.calendar.firstWeekday
        
        // TODO: this is O(n). Could this be done in O(1) by pre-computing the number of days to move backwards?
        while s.dayOfWeek != targetWeekday {
            s = s.previousDay()
        }
        return s
    }
    
    /// Create a new `Value` by moving forward one day
    func nextDay() -> Self { return adding(days: 1) }
    
    /// Create a new `Value` by moving backward one day
    func previousDay() -> Self { return subtracting(days: 1) }
    
    /// Create a new `Value` by moving forwward some number of days
    /// - Parameter days: The number of days by which to move forward
    func adding(days: Int) -> Self { return applying(delta: .days(days)) }
    
    /// Create a new `Value` by moving backward some number of days
    /// - Parameter days: The number of days by which to move backward
    func subtracting(days: Int) -> Self { return applying(delta: .days(-days)) }
    
}

public extension Value where Smallest: LTOEHour, Largest: GTOEEra {
    
    /// Create a new `Value` by moving forward one hour
    func nextHour() -> Self { return adding(hours: 1) }
    
    /// Create a new `Value` by moving backward one hour
    func previousHour() -> Self { return subtracting(hours: 1) }
    
    /// Create a new `Value` by moving forwward some number of hours
    /// - Parameter hours: The number of hours by which to move forward
    func adding(hours: Int) -> Self { return applying(delta: .hours(hours)) }
    
    /// Create a new `Value` by moving backward some number of hours
    /// - Parameter hours: The number of hours by which to move backward
    func subtracting(hours: Int) -> Self { return applying(delta: .hours(-hours)) }
    
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEEra {
    
    /// Create a new `Value` by moving forward one minute
    func nextMinute() -> Self { return adding(minutes: 1) }
    
    /// Create a new `Value` by moving backward one minute
    func previousMinute() -> Self { return subtracting(minutes: 1) }
    
    /// Create a new `Value` by moving forwward some number of minutes
    /// - Parameter minutes: The number of minutes by which to move forward
    func adding(minutes: Int) -> Self { return applying(delta: .minutes(minutes)) }
    
    /// Create a new `Value` by moving backward some number of minutes
    /// - Parameter minutes: The number of minutes by which to move backward
    func subtracting(minutes: Int) -> Self { return applying(delta: .minutes(-minutes)) }
    
}

public extension Value where Smallest: LTOESecond, Largest: GTOEEra {
    
    /// Create a new `Value` by moving forward one second
    func nextSecond() -> Self { return adding(seconds: 1) }
    
    /// Create a new `Value` by moving backward one second
    func previousSecond() -> Self { return subtracting(seconds: 1) }
    
    /// Create a new `Value` by moving forwward some number of seconds
    /// - Parameter seconds: The number of seconds by which to move forward
    func adding(seconds: Int) -> Self { return applying(delta: .seconds(seconds)) }
    
    /// Create a new `Value` by moving backward some number of seconds
    /// - Parameter seconds: The number of seconds by which to move backward
    func subtracting(seconds: Int) -> Self { return applying(delta: .seconds(-seconds)) }
    
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEEra {
    
    /// Create a new `Value` by moving forward one nanosecond
    func nextNanosecond() -> Self { return adding(nanoseconds: 1) }
    
    /// Create a new `Value` by moving backward one nanosecond
    func previousNanosecond() -> Self { return subtracting(nanoseconds: 1) }
    
    /// Create a new `Value` by moving forwward some number of nanoseconds
    /// - Parameter nanoseconds: The number of nanoseconds by which to move forward
    func adding(nanoseconds: Int) -> Self { return applying(delta: .nanoseconds(nanoseconds)) }
    
    /// Create a new `Value` by moving backward some number of nanoseconds
    /// - Parameter nanoseconds: The number of nanoseconds by which to move backward
    func subtracting(nanoseconds: Int) -> Self { return applying(delta: .nanoseconds(-nanoseconds)) }
    
}
