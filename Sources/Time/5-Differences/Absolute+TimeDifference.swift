//
//  Fixed+TimeDifference.swift
//  
//
//  Created by Dave DeLong on 2/4/20.
//

import Foundation

extension Fixed {
    
    // Fixed differences

    public static func - (lhs: Self, rhs: Self) -> TimeDifference<Smallest, Era> {
        return lhs.difference(to: rhs)
    }
    
    public func difference(to other: Self) -> TimeDifference<Smallest, Era> {
        return computeDifference(to: other)
    }
    
    internal func computeDifference<S: Unit, L: Unit>(to other: Fixed<Smallest>) -> TimeDifference<S, L> {
        
        let thisMid = self.approximateMidPoint.date
        let otherMid = other.approximateMidPoint.date
        
        let units = Calendar.Component.from(lower: S.self, to: L.self)
        let difference = calendar.dateComponents(units, from: thisMid, to: otherMid)
        return TimeDifference(difference)
    }
    
}

extension Fixed where Smallest: LTOEYear {
    
    public func differenceInYears(to other: Self) -> TimeDifference<Year, Year> {
        return computeDifference(to: other)
    }
    
}

extension Fixed where Smallest: LTOEMonth {
    
    public func differenceInMonths(to other: Self) -> TimeDifference<Month, Month> {
        return computeDifference(to: other)
    }
    
}

extension Fixed where Smallest: LTOEDay {
    
    public func differenceInDays(to other: Self) -> TimeDifference<Day, Day> {
        return computeDifference(to: other)
    }
    
}

extension Fixed where Smallest: LTOEHour {
    
    public func differenceInHours(to other: Self) -> TimeDifference<Hour, Hour> {
        return computeDifference(to: other)
    }
    
}

extension Fixed where Smallest: LTOEMinute {
    
    public func differenceInMinutes(to other: Self) -> TimeDifference<Minute, Minute> {
        return computeDifference(to: other)
    }
    
}

extension Fixed where Smallest: LTOESecond {
    
    public func differenceInSeconds(to other: Self) -> TimeDifference<Second, Second> {
        return computeDifference(to: other)
    }
    
}

extension Fixed where Smallest: LTOENanosecond {
    
    public func differenceInNanoseconds(to other: Self) -> TimeDifference<Nanosecond, Nanosecond> {
        return computeDifference(to: other)
    }
    
}
