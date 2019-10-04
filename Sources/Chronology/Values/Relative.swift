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

extension Relative: NanosecondField where Lower: LessThanSecond { }
extension Relative: SecondField where Lower: LessThanMinute, Upper: GreaterThanSecond { }
extension Relative: MinuteField where Lower: LessThanHour, Upper: GreaterThanMinute { }
extension Relative: HourField where Lower: LessThanDay, Upper: GreaterThanHour { }
extension Relative: DayField where Lower: LessThanMonth, Upper: GreaterThanDay { }
extension Relative: MonthField where Lower: LessThanYear, Upper: GreaterThanMonth { }
