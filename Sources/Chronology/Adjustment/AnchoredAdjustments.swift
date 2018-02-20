//
//  YearAdjustment.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension Adjustment where I: Anchored & YearField, I == O {
    
    public static func add(years: Int) -> Adjustment<I, O> {
        return Adjustment {
            let d = $0.range.lowerBound.date
            let newDate = $0.calendar.date(byAdding: .year, value: years, to: d).unwrap("Unable to add \(years) years to \($0)")
            return O.init(date: newDate, region: $0.region)
        }
    }
    
}

public extension Adjustment where I: Anchored & MonthField, I == O {
    
    public static func add(months: Int) -> Adjustment<I, O> {
        return Adjustment {
            let d = $0.range.lowerBound.date
            let newDate = $0.calendar.date(byAdding: .month, value: months, to: d).unwrap("Unable to add \(months) months to \($0)")
            return O.init(date: newDate, region: $0.region)
        }
    }
    
}

public extension Adjustment where I: Anchored & DayField, I == O {
    
    public static func add(days: Int) -> Adjustment<I, O> {
        return Adjustment {
            let d = $0.range.lowerBound.date
            let newDate = $0.calendar.date(byAdding: .day, value: days, to: d).unwrap("Unable to add \(days) days to \($0)")
            return O.init(date: newDate, region: $0.region)
        }
    }
    
}

public extension Adjustment where I: Anchored & HourField, I == O {
    
    public static func add(hours: Int) -> Adjustment<I, O> {
        return Adjustment {
            let d = $0.range.lowerBound.date
            let newDate = $0.calendar.date(byAdding: .hour, value: hours, to: d).unwrap("Unable to add \(hours) hours to \($0)")
            return O.init(date: newDate, region: $0.region)
        }
    }
    
}

public extension Adjustment where I: Anchored & MinuteField, I == O {
    
    public static func add(minutes: Int) -> Adjustment<I, O> {
        return Adjustment {
            let d = $0.range.lowerBound.date
            let newDate = $0.calendar.date(byAdding: .minute, value: minutes, to: d).unwrap("Unable to add \(minutes) minutes to \($0)")
            return O.init(date: newDate, region: $0.region)
        }
    }
    
}

public extension Adjustment where I: Anchored & SecondField, I == O {
    
    public static func add(seconds: Int) -> Adjustment<I, O> {
        return Adjustment {
            let d = $0.range.lowerBound.date
            let newDate = $0.calendar.date(byAdding: .second, value: seconds, to: d).unwrap("Unable to add \(seconds) seconds to \($0)")
            return O.init(date: newDate, region: $0.region)
        }
    }
    
}

public extension Adjustment where I: Anchored & NanosecondField, I == O {
    
    public static func add(nanoseconds: Int) -> Adjustment<I, O> {
        return Adjustment {
            let d = $0.range.lowerBound.date
            let newDate = $0.calendar.date(byAdding: .nanosecond, value: nanoseconds, to: d).unwrap("Unable to add \(nanoseconds) nanoseconds to \($0)")
            return O.init(date: newDate, region: $0.region)
        }
    }
    
}
