//
//  Absolute+TimeDifference.swift
//  
//
//  Created by Dave DeLong on 2/4/20.
//

import Foundation

extension Absolute where Largest == Era {
    
    func computeDifference<S: Unit, L: Unit>(to other: TimePeriod<Smallest, Largest>) -> TimeDifference<S, L> {
        
        let thisMid = self.approximateMidPoint.date
        let otherMid = other.approximateMidPoint.date
        
        let units = componentsFrom(lower: S.self, to: L.self)
        let difference = calendar.dateComponents(units, from: thisMid, to: otherMid)
        return TimeDifference(difference)
    }
    
}

public extension Absolute where Largest == Era {
    
    func difference(to other: TimePeriod<Smallest, Largest>) -> TimeDifference<Smallest, Largest> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOEYear, Largest == Era {
    
    func differenceInYears(to other: TimePeriod<Smallest, Largest>) -> TimeDifference<Year, Year> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOEMonth, Largest == Era {
    
    func differenceInMonths(to other: TimePeriod<Smallest, Largest>) -> TimeDifference<Month, Month> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOEDay, Largest == Era {
    
    func differenceInDays(to other: TimePeriod<Smallest, Largest>) -> TimeDifference<Day, Day> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOEHour, Largest == Era {
    
    func differenceInHours(to other: TimePeriod<Smallest, Largest>) -> TimeDifference<Hour, Hour> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOEMinute, Largest == Era {
    
    func differenceInMinutes(to other: TimePeriod<Smallest, Largest>) -> TimeDifference<Minute, Minute> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOESecond, Largest == Era {
    
    func differenceInSeconds(to other: TimePeriod<Smallest, Largest>) -> TimeDifference<Second, Second> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOENanosecond, Largest == Era {
    
    func differenceInNanoseconds(to other: TimePeriod<Smallest, Largest>) -> TimeDifference<Nanosecond, Nanosecond> {
        return computeDifference(to: other)
    }
    
}

// Absolute differences

public func - <S>(lhs: TimePeriod<S, Era>, rhs: TimePeriod<S, Era>) -> TimeDifference<S, Era> {
    return lhs.difference(to: rhs)
}

public func - <IS, OS, OL>(lhs: TimePeriod<IS, Era>, rhs: TimePeriod<IS, Era>) -> TimeDifference<OS, OL> {
    return lhs.computeDifference(to: rhs)
}
