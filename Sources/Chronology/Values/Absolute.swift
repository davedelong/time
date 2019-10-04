//
//  Absolute.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 10/4/18.
//

import Foundation

public protocol AbsoluteValue: CalendarValue {
    var range: ClosedRange<Instant> { get }
}

extension AbsoluteValue {
    
    internal var approximateMidPoint: Instant {
        let r = self.range
        let lower = r.lowerBound
        let upper = r.upperBound.converting(to: lower.epoch)
        let duration = upper.intervalSinceEpoch - lower.intervalSinceEpoch
        let midPoint = lower + (duration / 2.0)
        return max(lower, midPoint)
    }
    
}

public struct Absolute<Lower: Unit>: AbsoluteValue {
    
    public static var representedComponents: Set<Calendar.Component> {
        return componentsFrom(lower: Lower.self, to: Era.self)
    }
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public var range: ClosedRange<Instant> {
        let date = calendar.date(from: dateComponents).unwrap("Absolute values must always be convertible to a concrete NSDate")
        let unit = type(of: self).smallestRepresentedComponent
        
        var start = Date()
        var length: TimeInterval = 0
        let succeeded = calendar.dateInterval(of: unit, start: &start, interval: &length, for: date)
        require(succeeded, "We should always be able to get the range of a calendar component")
        
        let startInsant = Instant(date: start)
        let endInstant = Instant(date: start.addingTimeInterval(length))
        return startInsant...endInstant
    }
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
}

extension Absolute: EraField { }
extension Absolute: YearField where Lower: LessThanEra { }
extension Absolute: MonthField where Lower: LessThanYear { }
extension Absolute: DayField where Lower: LessThanMonth { }
extension Absolute: HourField where Lower: LessThanDay { }
extension Absolute: MinuteField where Lower: LessThanHour { }
extension Absolute: SecondField where Lower: LessThanMinute { }
extension Absolute: NanosecondField where Lower: LessThanSecond { }
