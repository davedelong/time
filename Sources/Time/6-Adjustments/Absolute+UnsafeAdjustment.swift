//
//  Fixed+StrictAdjustment.swift
//  
//
//  Created by Dave DeLong on 11/9/19.
//

import Foundation

extension Fixed where Smallest: LTOEYear {
    
    public func setting(year: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year))
    }
    
}

extension Fixed where Smallest: LTOEMonth {
    
    public func setting(year: Int, month: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(year: year, month: month))
    }
    
    public func setting(month: Int) throws -> Self {
        return try Self(region: region, strictDateComponents: dateComponents.setting(month: month))
    }
    
}

extension Fixed where Smallest: LTOEDay {
    
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

extension Fixed where Smallest: LTOEHour {
    
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

extension Fixed where Smallest: LTOEMinute {
    
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

extension Fixed where Smallest: LTOESecond {
    
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

extension Fixed where Smallest: LTOENanosecond {
    
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

extension Fixed where Smallest == Year {
    
    public func setting(month: Int) throws -> Fixed<Month> {
        return try Fixed<Month>(region: region, strictDateComponents: dateComponents.setting(month: month))
    }
    
    public func setting(month: Int, day: Int) throws -> Fixed<Day> {
        return try Fixed<Day>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day))
    }
    
    public func setting(month: Int, day: Int, hour: Int) throws -> Fixed<Hour> {
        return try Fixed<Hour>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour))
    }
    
    public func setting(month: Int, day: Int, hour: Int, minute: Int) throws -> Fixed<Minute> {
        return try Fixed<Minute>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute))
    }
    
    public func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Fixed<Second> {
        return try Fixed<Second>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second))
    }
    
    public func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Fixed<Nanosecond> {
        return try Fixed<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
}

extension Fixed where Smallest == Month {
    
    public func setting(day: Int) throws -> Fixed<Day> {
        return try Fixed<Day>(region: region, strictDateComponents: dateComponents.setting(day: day))
    }
    
    public func setting(day: Int, hour: Int) throws -> Fixed<Hour> {
        return try Fixed<Hour>(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour))
    }
    
    public func setting(day: Int, hour: Int, minute: Int) throws -> Fixed<Minute> {
        return try Fixed<Minute>(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute))
    }
    
    public func setting(day: Int, hour: Int, minute: Int, second: Int) throws -> Fixed<Second> {
        return try Fixed<Second>(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute, second: second))
    }
    
    public func setting(day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Fixed<Nanosecond> {
        return try Fixed<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
}

extension Fixed where Smallest == Day {
    
    public func setting(hour: Int) throws -> Fixed<Hour> {
        return try Fixed<Hour>(region: region, strictDateComponents: dateComponents.setting(hour: hour))
    }
    
    public func setting(hour: Int, minute: Int) throws -> Fixed<Minute> {
        return try Fixed<Minute>(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute))
    }
    
    public func setting(hour: Int, minute: Int, second: Int) throws -> Fixed<Second> {
        return try Fixed<Second>(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute, second: second))
    }
    
    public func setting(hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Fixed<Nanosecond> {
        return try Fixed<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(hour: hour, minute: minute, second: second, nanosecond: nanosecond))
    }
}

extension Fixed where Smallest == Hour {
    
    public func setting(minute: Int) throws -> Fixed<Minute> {
        return try Fixed<Minute>(region: region, strictDateComponents: dateComponents.setting(minute: minute))
    }
    
    public func setting(minute: Int, second: Int) throws -> Fixed<Second> {
        return try Fixed<Second>(region: region, strictDateComponents: dateComponents.setting(minute: minute, second: second))
    }
    
    public func setting(minute: Int, second: Int, nanosecond: Int) throws -> Fixed<Nanosecond> {
        return try Fixed<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(minute: minute, second: second, nanosecond: nanosecond))
    }
}

extension Fixed where Smallest == Minute {
    
    public func setting(second: Int) throws -> Fixed<Second> {
        return try Fixed<Second>(region: region, strictDateComponents: dateComponents.setting(second: second))
    }
    
    public func setting(second: Int, nanosecond: Int) throws -> Fixed<Nanosecond> {
        return try Fixed<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(second: second, nanosecond: nanosecond))
    }
}

extension Fixed where Smallest == Second {
    
    public func setting(nanosecond: Int) throws -> Fixed<Nanosecond> {
        return try Fixed<Nanosecond>(region: region, strictDateComponents: dateComponents.setting(nanosecond: nanosecond))
    }
}