//
//  AbsoluteFields.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

extension Value where Largest: GTOEEra {
    
    public var range: ClosedRange<Instant> {
        let date = calendar.date(from: dateComponents).unwrap("Absolute values must always be convertible to a concrete NSDate")
        
        var start = Date()
        var length: TimeInterval = 0
        let succeeded = calendar.dateInterval(of: Smallest.component, start: &start, interval: &length, for: date)
        require(succeeded, "We should always be able to get the range of a calendar component")
        
        let startInsant = Instant(date: start)
        let endInstant = Instant(date: start.addingTimeInterval(length))
        return startInsant...endInstant
    }
    
    public var firstInstant: Instant { return range.lowerBound }
    public var lastInstant: Instant { return range.upperBound }
    
}

extension Value where Largest: GTOEEra {
    public var absoluteEra: Absolute<Era> { subComponents() }
}

extension Value where Smallest: LTOEYear, Largest: GTOEEra {
    public var absoluteYear: Absolute<Year> { subComponents() }
}

extension Value where Smallest: LTOEMonth, Largest: GTOEEra {
    public var absoluteMonth: Absolute<Month> { subComponents() }
}

extension Value where Smallest: LTOEDay, Largest: GTOEEra {
    public var absoluteDay: Absolute<Day> { subComponents() }
    
    public var isWeekend: Bool { return calendar.isDateInWeekend(approximateMidPoint.date) }
    public var isWeekday: Bool { return !isWeekend }
    public var dayOfWeek: Int { return calendar.component(.weekday, from: approximateMidPoint.date) }
}

extension Value where Smallest: LTOEHour, Largest: GTOEEra {
    public var absoluteHour: Absolute<Hour> { subComponents() }
}

extension Value where Smallest: LTOEMinute, Largest: GTOEEra {
    public var absoluteMinute: Absolute<Minute> { subComponents() }
}

extension Value where Smallest: LTOESecond, Largest: GTOEEra {
    public var absoluteSecond: Absolute<Second> { subComponents() }
}
