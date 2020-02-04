//
//  File.swift
//  
//
//  Created by Dave DeLong on 2/4/20.
//

import Foundation

public extension Value where Largest: GTOEEra {
    
    func interval(to other: Value<Smallest, Largest>) -> Delta<Smallest, Largest> {
        return computeInterval(to: other)
    }
    
}

public extension Value where Smallest: LTOEYear, Largest: GTOEEra {
    
    func intervalInYears(to other: Value<Smallest, Largest>) -> Delta<Year, Year> {
        return computeInterval(to: other)
    }
    
}

public extension Value where Smallest: LTOEMonth, Largest: GTOEEra {
    
    func intervalInMonths(to other: Value<Smallest, Largest>) -> Delta<Month, Month> {
        return computeInterval(to: other)
    }
    
    func intervalInMonthsAndYears(to other: Value<Smallest, Largest>) -> Delta<Month, Year> {
        return computeInterval(to: other)
    }
    
}

public extension Value where Smallest: LTOEDay, Largest: GTOEEra {
    
    func intervalInDays(to other: Value<Smallest, Largest>) -> Delta<Day, Day> {
        return computeInterval(to: other)
    }
    
    func intervalInDaysAndMonths(to other: Value<Smallest, Largest>) -> Delta<Day, Month> {
        return computeInterval(to: other)
    }
    
    func intervalInDaysMonthsAndYears(to other: Value<Smallest, Largest>) -> Delta<Day, Year> {
        return computeInterval(to: other)
    }
    
}

public extension Value where Smallest: LTOEHour, Largest: GTOEEra {
    
    func intervalInHours(to other: Value<Smallest, Largest>) -> Delta<Hour, Hour> {
        return computeInterval(to: other)
    }
    
    func intervalInHoursAndDays(to other: Value<Smallest, Largest>) -> Delta<Hour, Day> {
        return computeInterval(to: other)
    }
    
    func intervalInHoursDaysAndMonths(to other: Value<Smallest, Largest>) -> Delta<Hour, Month> {
        return computeInterval(to: other)
    }
    
    func intervalInHoursDaysMonthsAndYears(to other: Value<Smallest, Largest>) -> Delta<Hour, Year> {
        return computeInterval(to: other)
    }
    
}

public extension Value where Smallest: LTOEMinute, Largest: GTOEEra {
    
    func intervalInMinutes(to other: Value<Smallest, Largest>) -> Delta<Minute, Minute> {
        return computeInterval(to: other)
    }
    
    func intervalInMinutesAndHours(to other: Value<Smallest, Largest>) -> Delta<Minute, Hour> {
        return computeInterval(to: other)
    }
    
    func intervalInMinutesHoursAndDays(to other: Value<Smallest, Largest>) -> Delta<Minute, Day> {
        return computeInterval(to: other)
    }
    
    func intervalInMinutesHoursDaysAndMonths(to other: Value<Smallest, Largest>) -> Delta<Minute, Month> {
        return computeInterval(to: other)
    }
    
    func intervalInMinutesHoursDaysMonthsAndYears(to other: Value<Smallest, Largest>) -> Delta<Minute, Year> {
        return computeInterval(to: other)
    }
    
}

public extension Value where Smallest: LTOESecond, Largest: GTOEEra {
    
    func intervalInSeconds(to other: Value<Smallest, Largest>) -> Delta<Second, Second> {
        return computeInterval(to: other)
    }
    
    func intervalInSecondsAndMinutes(to other: Value<Smallest, Largest>) -> Delta<Second, Minute> {
        return computeInterval(to: other)
    }
    
    func intervalInSecondsMinutesAndHours(to other: Value<Smallest, Largest>) -> Delta<Second, Hour> {
        return computeInterval(to: other)
    }
    
    func intervalInSecondsMinutesHoursAndDays(to other: Value<Smallest, Largest>) -> Delta<Second, Day> {
        return computeInterval(to: other)
    }
    
    func intervalInSecondsMinutesHoursDaysAndMonths(to other: Value<Smallest, Largest>) -> Delta<Second, Month> {
        return computeInterval(to: other)
    }
    
    func intervalInSecondsMinutesHoursDaysMonthsAndYears(to other: Value<Smallest, Largest>) -> Delta<Second, Year> {
        return computeInterval(to: other)
    }
    
}

public extension Value where Smallest: LTOENanosecond, Largest: GTOEEra {
    
    func intervalInNanoseconds(to other: Value<Smallest, Largest>) -> Delta<Nanosecond, Nanosecond> {
        return computeInterval(to: other)
    }
    
    func intervalInNanosecondsAndSeconds(to other: Value<Smallest, Largest>) -> Delta<Nanosecond, Second> {
        return computeInterval(to: other)
    }
    
    func intervalInNanosecondsSecondsMinutes(to other: Value<Smallest, Largest>) -> Delta<Nanosecond, Minute> {
        return computeInterval(to: other)
    }
    
    func intervalInNanosecondsSecondsMinutesAndHours(to other: Value<Smallest, Largest>) -> Delta<Nanosecond, Hour> {
        return computeInterval(to: other)
    }
    
    func intervalInNanosecondsSecondsMinutesHoursAndDays(to other: Value<Smallest, Largest>) -> Delta<Nanosecond, Day> {
        return computeInterval(to: other)
    }
    
    func intervalInNanosecondsSecondsMinutesHoursDaysAndMonths(to other: Value<Smallest, Largest>) -> Delta<Nanosecond, Month> {
        return computeInterval(to: other)
    }
    
    func intervalInNanosecondsSecondsMinutesHoursDaysMonthsAndYears(to other: Value<Smallest, Largest>) -> Delta<Nanosecond, Year> {
        return computeInterval(to: other)
    }
    
}
