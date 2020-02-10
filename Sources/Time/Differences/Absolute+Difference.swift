//
//  File.swift
//  
//
//  Created by Dave DeLong on 2/4/20.
//

import Foundation

extension Value where Largest: GTOEEra {
    
    func computeDifference<S: Unit, L: Unit>(to other: Value<Smallest, Largest>) -> Difference<S, L> {
        
        let thisMid = self.approximateMidPoint.date
        let otherMid = other.approximateMidPoint.date
        
        let units = componentsFrom(lower: S.self, to: L.self)
        let difference = calendar.dateComponents(units, from: thisMid, to: otherMid)
        return Difference(difference)
    }
    
}

public extension Value where Largest: GTOEEra {
    
    func difference(to other: Value<Smallest, Largest>) -> Difference<Smallest, Largest> {
        return computeDifference(to: other)
    }
    
}

public extension Value where Smallest: LTOEYear, Largest: GTOEEra {
    
    func differenceInYears(to other: Value<Smallest, Largest>) -> Difference<Year, Year> {
        return computeDifference(to: other)
    }
    
}

public extension Value where Smallest: LTOEMonth, Largest: GTOEEra {
    
    func differenceInMonths(to other: Value<Smallest, Largest>) -> Difference<Month, Month> {
        return computeDifference(to: other)
    }
    
}

public extension Value where Smallest: LTOEDay, Largest: GTOEEra {
    
    func differenceInDays(to other: Value<Smallest, Largest>) -> Difference<Day, Day> {
        return computeDifference(to: other)
    }
    
}

public extension Value where Smallest: LTOEHour, Largest: GTOEEra {
    
    func differenceInHours(to other: Value<Smallest, Largest>) -> Difference<Hour, Hour> {
        return computeDifference(to: other)
    }
    
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEEra {
    
    func differenceInMinutes(to other: Value<Smallest, Largest>) -> Difference<Minute, Minute> {
        return computeDifference(to: other)
    }
    
}

public extension Value where Smallest: LTOESecond, Largest: GTOEEra {
    
    func differenceInSeconds(to other: Value<Smallest, Largest>) -> Difference<Second, Second> {
        return computeDifference(to: other)
    }
    
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEEra {
    
    func differenceInNanoseconds(to other: Value<Smallest, Largest>) -> Difference<Nanosecond, Nanosecond> {
        return computeDifference(to: other)
    }
    
}
