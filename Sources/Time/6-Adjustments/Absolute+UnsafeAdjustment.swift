//
//  Absolute+StrictAdjustment.swift
//  
//
//  Created by Dave DeLong on 11/9/19.
//

import Foundation

extension Absolute where Smallest: LTOEYear {
    
    public func setting(year: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year))
    }
    
}

extension Absolute where Smallest: LTOEMonth {
    
    public func setting(year: Int, month: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month))
    }
    
    public func setting(month: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month))
    }
    
}

extension Absolute where Smallest: LTOEDay {
    
    public func setting(year: Int, month: Int, day: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month, day: day))
    }
    
    public func setting(month: Int, day: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month, day: day))
    }
    
    public func setting(day: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(day: day))
    }
    
}

extension Absolute where Smallest: LTOEHour {
    
    public func setting(year: Int, month: Int, day: Int, hour: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month, day: day, hour: hour))
    }
    
    public func setting(month: Int, day: Int, hour: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour))
    }
    
    public func setting(day: Int, hour: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour))
    }
    
    public func setting(hour: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(hour: hour))
    }
    
}

extension Absolute where Smallest: LTOEMinute {
    
    public func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month, day: day, hour: hour, minute: minute))
    }
    
    public func setting(month: Int, day: Int, hour: Int, minute: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute))
    }
    
    public func setting(day: Int, hour: Int, minute: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute))
    }
    
    public func setting(hour: Int, minute: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute))
    }
    
    public func setting(minute: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(minute: minute))
    }
    
}

extension Absolute where Smallest: LTOESecond {
    
    public func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month, day: day, hour: hour, minute: minute, second: second))
    }
    
    public func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second))
    }
    
    public func setting(day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute, second: second))
    }
    
    public func setting(hour: Int, minute: Int, second: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute, second: second))
    }
    
    public func setting(minute: Int, second: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(minute: minute, second: second))
    }
    
    public func setting(second: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(second: second))
    }
    
}

extension Absolute where Smallest: LTOENanosecond {
    
    public func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
    
    public func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
    
    public func setting(day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
    
    public func setting(hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
    
    public func setting(minute: Int, second: Int, nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(minute: minute, second: second, nanosecond: nanosecond))
    }
    
    public func setting(second: Int, nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(second: second, nanosecond: nanosecond))
    }
    
    public func setting(nanosecond: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(nanosecond: nanosecond))
    }
}

extension Absolute where Smallest == Year {
    
    public func setting(month: Int) throws -> Absolute<Month> {
        return try Absolute<Month>(region: region, strictDateComponents: dateComponents.setting(month: month))
    }
    
    public func setting(month: Int, day: Int) throws -> Absolute<Day> {
        return try Absolute<Day>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day))
    }
    
    public func setting(month: Int, day: Int, hour: Int) throws -> Absolute<Hour> {
        return try Absolute<Hour>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour))
    }
    
    public func setting(month: Int, day: Int, hour: Int, minute: Int) throws -> Absolute<Minute> {
        return try Absolute<Minute>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute))
    }
    
    public func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Absolute<Second> {
        return try Absolute<Second>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second))
    }
    
    public func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Absolute<Nanosecond> {
        return try Absolute<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
}

extension Absolute where Smallest == Month {
    
    public func setting(day: Int) throws -> Absolute<Day> {
        return try Absolute<Day>(region: region, strictDateComponents: dateComponents.setting(day: day))
    }
    
    public func setting(day: Int, hour: Int) throws -> Absolute<Hour> {
        return try Absolute<Hour>(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour))
    }
    
    public func setting(day: Int, hour: Int, minute: Int) throws -> Absolute<Minute> {
        return try Absolute<Minute>(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute))
    }
    
    public func setting(day: Int, hour: Int, minute: Int, second: Int) throws -> Absolute<Second> {
        return try Absolute<Second>(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute, second: second))
    }
    
    public func setting(day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Absolute<Nanosecond> {
        return try Absolute<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
}

extension Absolute where Smallest == Day {
    
    public func setting(hour: Int) throws -> Absolute<Hour> {
        return try Absolute<Hour>(region: region, strictDateComponents: dateComponents.setting(hour: hour))
    }
    
    public func setting(hour: Int, minute: Int) throws -> Absolute<Minute> {
        return try Absolute<Minute>(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute))
    }
    
    public func setting(hour: Int, minute: Int, second: Int) throws -> Absolute<Second> {
        return try Absolute<Second>(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute, second: second))
    }
    
    public func setting(hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Absolute<Nanosecond> {
        return try Absolute<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
}

extension Absolute where Smallest == Hour {
    
    public func setting(minute: Int) throws -> Absolute<Minute> {
        return try Absolute<Minute>(region: region, strictDateComponents: dateComponents.setting(minute: minute))
    }
    
    public func setting(minute: Int, second: Int) throws -> Absolute<Second> {
        return try Absolute<Second>(region: region, strictDateComponents: dateComponents.setting(minute: minute, second: second))
    }
    
    public func setting(minute: Int, second: Int, nanosecond: Int) throws -> Absolute<Nanosecond> {
        return try Absolute<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(minute: minute, second: second, nanosecond: nanosecond))
    }
}

extension Absolute where Smallest == Minute {
    
    public func setting(second: Int) throws -> Absolute<Second> {
        return try Absolute<Second>(region: region, strictDateComponents: dateComponents.setting(second: second))
    }
    
    public func setting(second: Int, nanosecond: Int) throws -> Absolute<Nanosecond> {
        return try Absolute<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(second: second, nanosecond: nanosecond))
    }
}

extension Absolute where Smallest == Second {
    
    public func setting(nanosecond: Int) throws -> Absolute<Nanosecond> {
        return try Absolute<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(nanosecond: nanosecond))
    }
}
