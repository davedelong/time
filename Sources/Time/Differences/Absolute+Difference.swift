//
//  File.swift
//  
//
//  Created by Dave DeLong on 2/4/20.
//

import Foundation

extension Absolute {
    
    func computeDifference<S: Unit, L: Unit>(to other: Value<Smallest, Largest>) -> Difference<S, L> {
        
        let thisMid = self.approximateMidPoint.date
        let otherMid = other.approximateMidPoint.date
        
        let units = componentsFrom(lower: S.self, to: L.self)
        let difference = calendar.dateComponents(units, from: thisMid, to: otherMid)
        return Difference(difference)
    }
    
}

public extension Absolute {
    
    func difference(to other: Value<Smallest, Largest>) -> Difference<Smallest, Largest> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOEYear {
    
    func differenceInYears(to other: Value<Smallest, Largest>) -> Difference<Year, Year> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOEMonth {
    
    func differenceInMonths(to other: Value<Smallest, Largest>) -> Difference<Month, Month> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOEDay {
    
    func differenceInDays(to other: Value<Smallest, Largest>) -> Difference<Day, Day> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOEHour {
    
    func differenceInHours(to other: Value<Smallest, Largest>) -> Difference<Hour, Hour> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOEMinute {
    
    func differenceInMinutes(to other: Value<Smallest, Largest>) -> Difference<Minute, Minute> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOESecond {
    
    func differenceInSeconds(to other: Value<Smallest, Largest>) -> Difference<Second, Second> {
        return computeDifference(to: other)
    }
    
}

public extension Absolute where Smallest: LTOENanosecond {
    
    func differenceInNanoseconds(to other: Value<Smallest, Largest>) -> Difference<Nanosecond, Nanosecond> {
        return computeDifference(to: other)
    }
    
}

// Absolute differences

public func - <S>(lhs: Value<S, Era>, rhs: Value<S, Era>) -> Difference<S, Era> {
    return lhs.difference(to: rhs)
}

public func - <IS, OS, OL>(lhs: Value<IS, Era>, rhs: Value<IS, Era>) -> Difference<OS, OL> {
    return lhs.computeDifference(to: rhs)
}
