//
//  Absolute+SafeAdjustment.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Absolute {
    
    /// Adjust an absolute value by applying a temporal delta value.
    ///
    /// - Parameter difference: The `TimeDifference` that describes the difference between the receiver
    ///    and the produced value.
    func applying(difference: TimeDifference<Smallest, Largest>) -> TimePeriod<Smallest, Largest> {
        let adjuster = Adjustment<Smallest, Largest, Smallest, Largest> {
            let d = $0.range.lowerBound.date
            let diff = difference.dateComponents
            let newDate = $0.calendar.date(byAdding: diff, to: d).unwrap("Unable to add \(diff) to \($0)")
            return TimePeriod<Smallest, Largest>(region: $0.region, date: newDate)
        }
        return applying(adjuster)
    }

}

public extension Absolute where Smallest: LTOEYear, Largest == Era {
    
    /// Create a new `TimePeriod` by moving forward one year.
    func nextYear() -> Self { return adding(years: 1) }
    
    /// Create a new `TimePeriod` by moving backward one year.
    func previousYear() -> Self { return subtracting(years: 1) }
    
    /// Create a new `TimePeriod` by moving forward some number of years.
    /// - Parameter years: The number of years by which to move forward.
    func adding(years: Int) -> Self { return applying(difference: .years(years)) }
    
    /// Create a new `TimePeriod` by moving backward some number of years.
    /// - Parameter years: The number of years by which to move backward.
    func subtracting(years: Int) -> Self { return applying(difference: .years(-years)) }
    
}

public extension Absolute where Smallest: LTOEMonth, Largest == Era {
    
    /// Create a new `TimePeriod` by moving forward one month.
    func nextMonth() -> Self { return adding(months: 1) }
    
    /// Create a new `TimePeriod` by moving backward one month.
    func previousMonth() -> Self { return subtracting(months: 1) }
    
    /// Create a new `TimePeriod` by moving forward some number of months.
    /// - Parameter months: The number of months by which to move forward.
    func adding(months: Int) -> Self { return applying(difference: .months(months)) }
    
    /// Create a new `TimePeriod` by moving backward some number of months.
    /// - Parameter months: The number of months by which to move backward.
    func subtracting(months: Int) -> Self { return applying(difference: .months(-months)) }
    
}

public extension Absolute where Smallest: LTOEDay, Largest == Era {
    
    /// Adjust the date to the beginning of the calendar's week.
    func startOfWeek() -> Self {
        var s = self
        let targetWeekday = region.calendar.firstWeekday
        
        // TODO: this is O(n). Could this be done in O(1) by pre-computing the number of days to move backwards?
        while s.dayOfWeek != targetWeekday {
            s = s.previousDay()
        }
        return s
    }
    
    /// Create a new `TimePeriod` by moving forward one day.
    func nextDay() -> Self { return adding(days: 1) }
    
    /// Create a new `TimePeriod` by moving backward one day.
    func previousDay() -> Self { return subtracting(days: 1) }
    
    /// Create a new `TimePeriod` by moving forward some number of days.
    /// - Parameter days: The number of days by which to move forward.
    func adding(days: Int) -> Self { return applying(difference: .days(days)) }
    
    /// Create a new `TimePeriod` by moving backward some number of days.
    /// - Parameter days: The number of days by which to move backward.
    func subtracting(days: Int) -> Self { return applying(difference: .days(-days)) }
    
    func next(dayOfWeek: Int) -> Self {
        let daysInWeek = calendar.maximumRange(of: .weekday) ?? 1 ..< 8
        var day = dayOfWeek
        while day < daysInWeek.lowerBound { day += daysInWeek.count }
        day %= daysInWeek.count
        
        let thisDay = self.dayOfWeek
        
        var offset = 0
        if day < thisDay {
            offset = (day + daysInWeek.count) - thisDay
        } else if day == thisDay {
            offset = daysInWeek.count
        } else {
            offset = day - thisDay
        }
        
        // try the "O(1)" jump first
        let proposed = self.adding(days: offset)
        if proposed.dayOfWeek == day { return proposed }
        
        // something went wrong. manually scan forward
        var current = self.nextDay()
        while current.dayOfWeek != day {
            current = current.nextDay()
        }
        return current
    }
    
}

public extension Absolute where Smallest: LTOEHour, Largest == Era {
    
    /// Create a new `TimePeriod` by moving forward one hour.
    func nextHour() -> Self { return adding(hours: 1) }
    
    /// Create a new `TimePeriod` by moving backward one hour.
    func previousHour() -> Self { return subtracting(hours: 1) }
    
    /// Create a new `TimePeriod` by moving forward some number of hours.
    /// - Parameter hours: The number of hours by which to move forward.
    func adding(hours: Int) -> Self { return applying(difference: .hours(hours)) }
    
    /// Create a new `TimePeriod` by moving backward some number of hours.
    /// - Parameter hours: The number of hours by which to move backward.
    func subtracting(hours: Int) -> Self { return applying(difference: .hours(-hours)) }
    
}

public extension Absolute where Smallest: LTOEMinute, Largest == Era {
    
    /// Create a new `TimePeriod` by moving forward one minute.
    func nextMinute() -> Self { return adding(minutes: 1) }
    
    /// Create a new `TimePeriod` by moving backward one minute.
    func previousMinute() -> Self { return subtracting(minutes: 1) }
    
    /// Create a new `TimePeriod` by moving forward some number of minutes.
    /// - Parameter minutes: The number of minutes by which to move forward.
    func adding(minutes: Int) -> Self { return applying(difference: .minutes(minutes)) }
    
    /// Create a new `TimePeriod` by moving backward some number of minutes.
    /// - Parameter minutes: The number of minutes by which to move backward.
    func subtracting(minutes: Int) -> Self { return applying(difference: .minutes(-minutes)) }
    
}

public extension Absolute where Smallest: LTOESecond, Largest == Era {
    
    /// Create a new `TimePeriod` by moving forward one second.
    func nextSecond() -> Self { return adding(seconds: 1) }
    
    /// Create a new `TimePeriod` by moving backward one second.
    func previousSecond() -> Self { return subtracting(seconds: 1) }
    
    /// Create a new `TimePeriod` by moving forward some number of seconds.
    /// - Parameter seconds: The number of seconds by which to move forward.
    func adding(seconds: Int) -> Self { return applying(difference: .seconds(seconds)) }
    
    /// Create a new `TimePeriod` by moving backward some number of seconds.
    /// - Parameter seconds: The number of seconds by which to move backward.
    func subtracting(seconds: Int) -> Self { return applying(difference: .seconds(-seconds)) }
    
}

public extension Absolute where Smallest: LTOENanosecond, Largest == Era {
    
    /// Create a new `TimePeriod` by moving forward one nanosecond.
    func nextNanosecond() -> Self { return adding(nanoseconds: 1) }
    
    /// Create a new `TimePeriod` by moving backward one nanosecond.
    func previousNanosecond() -> Self { return subtracting(nanoseconds: 1) }
    
    /// Create a new `TimePeriod` by moving forward some number of nanoseconds.
    /// - Parameter nanoseconds: The number of nanoseconds by which to move forward.
    func adding(nanoseconds: Int) -> Self { return applying(difference: .nanoseconds(nanoseconds)) }
    
    /// Create a new `TimePeriod` by moving backward some number of nanoseconds.
    /// - Parameter nanoseconds: The number of nanoseconds by which to move backward.
    func subtracting(nanoseconds: Int) -> Self { return applying(difference: .nanoseconds(-nanoseconds)) }
    
}
