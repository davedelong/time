//
//  File.swift
//  
//
//  Created by Dave DeLong on 11/9/19.
//

import Foundation

extension UnsafeAdjustment where IL: GTOEEra, IS == OS, IL == OL {
    
    fileprivate init(setting: DateComponents) {
        self.init { old -> Value<OS, OL> in
            let proposed = old.dateComponents.merging(setting)
            let adjusted = try old.calendar.exactDate(from: proposed, matching: Value<OS, OL>.representedComponents)
            return Value<OS, OL>.init(region: old.region, date: adjusted)
        }
    }
    
}

extension UnsafeAdjustment where IL: GTOEEra, OL: GTOEEra {

    fileprivate init(setting: DateComponents) {
        self.init { old -> Value<OS, OL> in
            let proposed = old.dateComponents.merging(setting)
            let adjusted = try old.calendar.exactDate(from: proposed, matching: Value<OS, OL>.representedComponents)
            return Value<OS, OL>.init(region: old.region, date: adjusted)
        }
    }

}

public extension Absolute where Smallest: LTOEYear, Largest == Era {
    
    func setting(year: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(year: year)))
    }
    
}

public extension Absolute where Smallest: LTOEMonth, Largest == Era {
    
    func setting(year: Int, month: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(year: year, month: month)))
    }
    
    func setting(month: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month)))
    }
    
}

public extension Absolute where Smallest: LTOEDay, Largest == Era {
    
    func setting(year: Int, month: Int, day: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(year: year, month: month, day: day)))
    }
    
    func setting(month: Int, day: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month, day: day)))
    }
    
    func setting(day: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(day: day)))
    }
    
}

public extension Absolute where Smallest: LTOEHour, Largest == Era {
    
    func setting(year: Int, month: Int, day: Int, hour: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(year: year, month: month, day: day, hour: hour)))
    }
    
    func setting(month: Int, day: Int, hour: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour)))
    }
    
    func setting(day: Int, hour: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(day: day, hour: hour)))
    }
    
    func setting(hour: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(hour: hour)))
    }
    
}

public extension Absolute where Smallest: LTOEMinute, Largest == Era {
    
    func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(year: year, month: month, day: day, hour: hour, minute: minute)))
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour, minute: minute)))
    }
    
    func setting(day: Int, hour: Int, minute: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(day: day, hour: hour, minute: minute)))
    }
    
    func setting(hour: Int, minute: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(hour: hour, minute: minute)))
    }
    
    func setting(minute: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(minute: minute)))
    }
    
}

public extension Absolute where Smallest: LTOESecond, Largest == Era {
    
    func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(year: year, month: month, day: day, hour: hour, minute: minute, second: second)))
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second)))
    }
    
    func setting(day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(day: day, hour: hour, minute: minute, second: second)))
    }
    
    func setting(hour: Int, minute: Int, second: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(hour: hour, minute: minute, second: second)))
    }
    
    func setting(minute: Int, second: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(minute: minute, second: second)))
    }
    
    func setting(second: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(second: second)))
    }
    
}

public extension Absolute where Smallest: LTOENanosecond, Largest == Era {
    
    func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
    
    func setting(day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
    
    func setting(hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
    
    func setting(minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(minute: minute, second: second, nanosecond: nanosecond)))
    }
    
    func setting(second: Int, nanosecond: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(second: second, nanosecond: nanosecond)))
    }
    
    func setting(nanosecond: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(nanosecond: nanosecond)))
    }
}

public extension Value where Smallest == Year, Largest == Era {
    
    func setting(month: Int) throws -> Value<Month, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month)))
    }
    
    func setting(month: Int, day: Int) throws -> Value<Day, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month, day: day)))
    }
    
    func setting(month: Int, day: Int, hour: Int) throws -> Value<Hour, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour)))
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int) throws -> Value<Minute, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour, minute: minute)))
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Value<Second, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second)))
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Value<Nanosecond, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
}

public extension Value where Smallest == Month, Largest == Era {
    
    func setting(day: Int) throws -> Value<Day, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(day: day)))
    }
    
    func setting(day: Int, hour: Int) throws -> Value<Hour, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(day: day, hour: hour)))
    }
    
    func setting(day: Int, hour: Int, minute: Int) throws -> Value<Minute, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(day: day, hour: hour, minute: minute)))
    }
    
    func setting(day: Int, hour: Int, minute: Int, second: Int) throws -> Value<Second, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(day: day, hour: hour, minute: minute, second: second)))
    }
    
    func setting(day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Value<Nanosecond, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
}

public extension Value where Smallest == Day, Largest == Era {
    
    func setting(hour: Int) throws -> Value<Hour, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(hour: hour)))
    }
    
    func setting(hour: Int, minute: Int) throws -> Value<Minute, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(hour: hour, minute: minute)))
    }
    
    func setting(hour: Int, minute: Int, second: Int) throws -> Value<Second, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(hour: hour, minute: minute, second: second)))
    }
    
    func setting(hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Value<Nanosecond, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(hour: hour, minute: minute, second: second, nanosecond: nanosecond)))
    }
}

public extension Value where Smallest == Hour, Largest == Era {
    
    func setting(minute: Int) throws -> Value<Minute, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(minute: minute)))
    }
    
    func setting(minute: Int, second: Int) throws -> Value<Second, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(minute: minute, second: second)))
    }
    
    func setting(minute: Int, second: Int, nanosecond: Int) throws -> Value<Nanosecond, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(minute: minute, second: second, nanosecond: nanosecond)))
    }
}

public extension Value where Smallest == Minute, Largest == Era {
    
    func setting(second: Int) throws -> Value<Second, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(second: second)))
    }
    
    func setting(second: Int, nanosecond: Int) throws -> Value<Nanosecond, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(second: second, nanosecond: nanosecond)))
    }
}

public extension Value where Smallest == Second, Largest == Era {
    
    func setting(nanosecond: Int) throws -> Value<Nanosecond, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(nanosecond: nanosecond)))
    }
}
