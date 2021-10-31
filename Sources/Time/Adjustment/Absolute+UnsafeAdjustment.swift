//
//  Absolute+StrictAdjustment.swift
//  
//
//  Created by Dave DeLong on 11/9/19.
//

import Foundation

extension StrictAdjustment where IL: _GTOEEra, IS == OS, IL == OL {
    
    fileprivate init(setting: DateComponents) {
        self.init { old -> TimePeriod<OS, OL> in
            let proposed = old.dateComponents.merging(setting)
            let adjusted = try old.calendar.exactDate(from: proposed, matching: TimePeriod<OS, OL>.representedComponents)
            return TimePeriod<OS, OL>.init(region: old.region, date: adjusted)
        }
    }
    
}

extension StrictAdjustment where IL: _GTOEEra, OL: _GTOEEra {

    fileprivate init(setting: DateComponents) {
        self.init { old -> TimePeriod<OS, OL> in
            let proposed = old.dateComponents.merging(setting)
            let adjusted = try old.calendar.exactDate(from: proposed, matching: TimePeriod<OS, OL>.representedComponents)
            return TimePeriod<OS, OL>.init(region: old.region, date: adjusted)
        }
    }

}

public extension Absolute where Smallest: _LTOEYear, Largest == Era {
    
    func setting(year: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(year: year)))
    }
    
}

public extension Absolute where Smallest: _LTOEMonth, Largest == Era {
    
    func setting(year: Int, month: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(year: year, month: month)))
    }
    
    func setting(month: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(month: month)))
    }
    
}

public extension Absolute where Smallest: _LTOEDay, Largest == Era {
    
    func setting(year: Int, month: Int, day: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(year: year, month: month, day: day)))
    }
    
    func setting(month: Int, day: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(month: month, day: day)))
    }
    
    func setting(day: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(day: day)))
    }
    
}

public extension Absolute where Smallest: _LTOEHour, Largest == Era {
    
    func setting(year: Int, month: Int, day: Int, hour: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(year: year, month: month, day: day, hour: hour)))
    }
    
    func setting(month: Int, day: Int, hour: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour)))
    }
    
    func setting(day: Int, hour: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(day: day, hour: hour)))
    }
    
    func setting(hour: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(hour: hour)))
    }
    
}

public extension Absolute where Smallest: _LTOEMinute, Largest == Era {
    
    func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(year: year, month: month, day: day, hour: hour, minute: minute)))
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour, minute: minute)))
    }
    
    func setting(day: Int, hour: Int, minute: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(day: day, hour: hour, minute: minute)))
    }
    
    func setting(hour: Int, minute: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(hour: hour, minute: minute)))
    }
    
    func setting(minute: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(minute: minute)))
    }
    
}

public extension Absolute where Smallest: _LTOESecond, Largest == Era {
    
    func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(year: year, month: month, day: day, hour: hour, minute: minute, second: second)))
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second)))
    }
    
    func setting(day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(day: day, hour: hour, minute: minute, second: second)))
    }
    
    func setting(hour: Int, minute: Int, second: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(hour: hour, minute: minute, second: second)))
    }
    
    func setting(minute: Int, second: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(minute: minute, second: second)))
    }
    
    func setting(second: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(second: second)))
    }
    
}

public extension Absolute where Smallest: _LTOENanosecond, Largest == Era {
    
    func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
    
    func setting(day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
    
    func setting(hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
    
    func setting(minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(minute: minute, second: second, nanosecond: nanosecond)))
    }
    
    func setting(second: Int, nanosecond: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(second: second, nanosecond: nanosecond)))
    }
    
    func setting(nanosecond: Int) throws -> Self {
        return try applying(StrictAdjustment(setting: dateComponents.setting(nanosecond: nanosecond)))
    }
}

public extension TimePeriod where Smallest == Year, Largest == Era {
    
    func setting(month: Int) throws -> TimePeriod<Month, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(month: month)))
    }
    
    func setting(month: Int, day: Int) throws -> TimePeriod<Day, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(month: month, day: day)))
    }
    
    func setting(month: Int, day: Int, hour: Int) throws -> TimePeriod<Hour, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour)))
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int) throws -> TimePeriod<Minute, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour, minute: minute)))
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> TimePeriod<Second, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second)))
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> TimePeriod<Nanosecond, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
}

public extension TimePeriod where Smallest == Month, Largest == Era {
    
    func setting(day: Int) throws -> TimePeriod<Day, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(day: day)))
    }
    
    func setting(day: Int, hour: Int) throws -> TimePeriod<Hour, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(day: day, hour: hour)))
    }
    
    func setting(day: Int, hour: Int, minute: Int) throws -> TimePeriod<Minute, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(day: day, hour: hour, minute: minute)))
    }
    
    func setting(day: Int, hour: Int, minute: Int, second: Int) throws -> TimePeriod<Second, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(day: day, hour: hour, minute: minute, second: second)))
    }
    
    func setting(day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> TimePeriod<Nanosecond, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
}

public extension TimePeriod where Smallest == Day, Largest == Era {
    
    func setting(hour: Int) throws -> TimePeriod<Hour, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(hour: hour)))
    }
    
    func setting(hour: Int, minute: Int) throws -> TimePeriod<Minute, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(hour: hour, minute: minute)))
    }
    
    func setting(hour: Int, minute: Int, second: Int) throws -> TimePeriod<Second, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(hour: hour, minute: minute, second: second)))
    }
    
    func setting(hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> TimePeriod<Nanosecond, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
}

public extension TimePeriod where Smallest == Hour, Largest == Era {
    
    func setting(minute: Int) throws -> TimePeriod<Minute, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(minute: minute)))
    }
    
    func setting(minute: Int, second: Int) throws -> TimePeriod<Second, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(minute: minute, second: second)))
    }
    
    func setting(minute: Int, second: Int, nanosecond: Int) throws -> TimePeriod<Nanosecond, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(minute: minute, second: second, nanosecond: nanosecond)))
    }
}

public extension TimePeriod where Smallest == Minute, Largest == Era {
    
    func setting(second: Int) throws -> TimePeriod<Second, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(second: second)))
    }
    
    func setting(second: Int, nanosecond: Int) throws -> TimePeriod<Nanosecond, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(second: second, nanosecond: nanosecond)))
    }
}

public extension TimePeriod where Smallest == Second, Largest == Era {
    
    func setting(nanosecond: Int) throws -> TimePeriod<Nanosecond, Era> {
        return try applying(StrictAdjustment(setting: dateComponents.setting(nanosecond: nanosecond)))
    }
}
