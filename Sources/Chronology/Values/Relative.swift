//
//  Relative.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 10/4/18.
//

import Foundation

public struct Relative<Lower: Unit, Upper: Unit>: CalendarValue {
    
    public static var representedComponents: Set<Calendar.Component> {
        return componentsFrom(lower: Lower.self, to: Upper.self)
    }
    
    public let region: Region
    public let dateComponents: DateComponents
    
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
    
}

extension Relative: NanosecondField where Upper: LessThanOrEqualToNanosecond { }
extension Relative: SecondField where Lower: LargerThanNanosecond, Upper: LessThanOrEqualToSecond { }
extension Relative: MinuteField where Lower: LargerThanSecond, Upper: LessThanOrEqualToMinute { }
extension Relative: HourField where Lower: LargerThanMinute, Upper: LessThanOrEqualToHour { }
extension Relative: DayField where Lower: LargerThanHour, Upper: LessThanOrEqualToDay { }
extension Relative: MonthField where Lower: LargerThanDay, Upper: LessThanOrEqualToMonth { }
