//
//  TimeDifference.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

/// This is a nominal wrapper used for adjusting calendar values.
/// This wrapper enables syntax like "today + .days(3)".
public struct TimeDifference<MinimumGranularity: Unit, MaximumGranularity: Unit> {
    internal let dateComponents: DateComponents
    
    internal init(_ dateComponents: DateComponents) {
        let allowed = Calendar.Component.from(lower: MinimumGranularity.self, to: MaximumGranularity.self)
        self.dateComponents = dateComponents.restrict(to: allowed)
    }
    
    internal init(value: Int, unit: Calendar.Component) {
        self.init(DateComponents(value: value, component: unit))
    }
    
    internal func negated() -> TimeDifference {
        return TimeDifference(dateComponents.scale(by: -1))
    }
    
    internal func scale(by scale: Int) -> Self {
        if scale == 1 { return self }
        return Self(dateComponents.scale(by: scale))
    }
}

extension TimeDifference where MinimumGranularity: LTOEYear, MaximumGranularity: GTOEYear {
    public static func eras(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .era) }

    /// Retrieve the number of eras in a calendrical difference.
    public var eras: Int {
        return dateComponents.era
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have an era value")
    }
}

extension TimeDifference where MinimumGranularity: LTOEYear, MaximumGranularity: GTOEYear {
    public static func years(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .year) }
    
    /// Retrieve the number of years in a calendrical difference.
    public var years: Int {
        return dateComponents.year
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have a year value")
    }
}

extension TimeDifference where MinimumGranularity: LTOEMonth, MaximumGranularity: GTOEMonth {
    public static func months(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .month) }
    
    /// Retrieve the number of months in a calendrical difference.
    public var months: Int {
        return dateComponents.month
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have a month value")
    }
}

extension TimeDifference where MinimumGranularity: LTOEDay, MaximumGranularity: GTOEDay {
    public static func days(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .day) }
    
    /// Retrieve the number of days in a calendrical difference.
    public var days: Int {
        return dateComponents.day.unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have a day value")
    }
}

extension TimeDifference where MinimumGranularity: LTOEHour, MaximumGranularity: GTOEHour {
    public static func hours(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .hour) }
    
    /// Retrieve the number of hours in a calendrical difference.
    public var hours: Int {
        return dateComponents.hour
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have an hour value")
    }
}

extension TimeDifference where MinimumGranularity: LTOEMinute, MaximumGranularity: GTOEMinute {
    public static func minutes(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .minute) }
    
    /// Retrieve the number of minutes in a calendrical difference.
    public var minutes: Int {
        return dateComponents.minute
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have a minute value")
    }
}

extension TimeDifference where MinimumGranularity: LTOESecond, MaximumGranularity: GTOESecond {
    public static func seconds(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .second) }
    
    /// Retrieve the number of seconds in a calendrical difference.
    public var seconds: Int {
        return dateComponents.second
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have a second value")
    }
}

extension TimeDifference where MinimumGranularity: LTOENanosecond, MaximumGranularity: GTOENanosecond {
    public static func nanoseconds(_ value: Int) -> TimeDifference { return self.init(value: value, unit: .nanosecond) }
    
    /// Retrieve the number of nanoseconds in a calendrical difference.
    public var nanoseconds: Int {
        return dateComponents.nanosecond
            .unwrap("A TimeDifference<\(MinimumGranularity.self), \(MaximumGranularity.self)> must have a nanosecond value")
    }
}
