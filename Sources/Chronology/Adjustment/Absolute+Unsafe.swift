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
            guard let direction = old.dateComponents.relationTo(setting) else { return old }
            let mid = old.approximateMidPoint.date
            let proposed = old.calendar.nextDate(after: mid, matching: setting, matchingPolicy: .strict, repeatedTimePolicy: .first, direction: direction)
            guard let new = proposed else {
                throw AdjustmentError.invalidDateComponents(setting)
            }
            return Value<OS, OL>.init(region: old.region, date: new)
        }
    }
    
}

extension UnsafeAdjustment where IL: GTOEEra, OL: GTOEEra {
    
    fileprivate init(setting: DateComponents) {
        self.init { old -> Value<OS, OL> in
            guard let direction = old.dateComponents.relationTo(setting) else {
                // the date components are equal, but the input and output types are not
                // something is decidedly wrong
                throw AdjustmentError.invalidDateComponents(setting)
            }
            
            let mid = old.approximateMidPoint.date
            let proposed = old.calendar.nextDate(after: mid, matching: setting, matchingPolicy: .strict, repeatedTimePolicy: .first, direction: direction)
            guard let new = proposed else {
                throw AdjustmentError.invalidDateComponents(setting)
            }
            return Value<OS, OL>.init(region: old.region, date: new)
        }
    }
    
}

extension Value where Smallest: LTOEYear, Largest: GTOEEra {
    
    func setting(year: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(year: year)))
    }
    
}

extension Value where Smallest: LTOEMonth, Largest: GTOEEra {
    
    func setting(year: Int, month: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(year: year, month: month)))
    }
    
    func setting(month: Int) throws -> Self {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(month: month)))
    }
    
}

extension Value where Smallest: LTOEDay, Largest: GTOEEra {
    
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

extension Value where Smallest: LTOEHour, Largest: GTOEEra {
    
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

extension Value where Smallest: LTOEMinute, Largest: GTOEEra {
    
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

extension Value where Smallest: LTOESecond, Largest: GTOEEra {
    
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

extension Value where Smallest: LTOENanosecond, Largest: GTOEEra {
    
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

extension Value where Smallest == Year, Largest: GTOEEra {
    
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

extension Value where Smallest == Month, Largest: GTOEEra {
    
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

extension Value where Smallest == Day, Largest: GTOEEra {
    
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

extension Value where Smallest == Hour, Largest: GTOEEra {
    
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

extension Value where Smallest == Minute, Largest: GTOEEra {
    
    func setting(second: Int) throws -> Value<Second, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(second: second)))
    }
    
    func setting(second: Int, nanosecond: Int) throws -> Value<Nanosecond, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(second: second, nanosecond: nanosecond)))
    }
}

extension Value where Smallest == Second, Largest: GTOEEra {
    
    func setting(nanosecond: Int) throws -> Value<Nanosecond, Era> {
        return try applying(UnsafeAdjustment(setting: dateComponents.setting(nanosecond: nanosecond)))
    }
}
