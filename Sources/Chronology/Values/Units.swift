//
//  Units.swift
//  
//
//  Created by Dave DeLong on 10/3/19.
//

import Foundation

public protocol Unit {
    static var component: Calendar.Component { get }
}

protocol LessThanOrEqualToEra: Unit { }
protocol LessThanOrEqualToYear: LessThanOrEqualToEra { }
protocol LessThanOrEqualToMonth: LessThanOrEqualToYear { }
protocol LessThanOrEqualToDay: LessThanOrEqualToMonth { }
protocol LessThanOrEqualToHour: LessThanOrEqualToDay { }
protocol LessThanOrEqualToMinute: LessThanOrEqualToHour { }
protocol LessThanOrEqualToSecond: LessThanOrEqualToMinute { }
protocol LessThanOrEqualToNanosecond: LessThanOrEqualToSecond { }

protocol LargerThanNanosecond: Unit { }
protocol LargerThanSecond: LargerThanNanosecond { }
protocol LargerThanMinute: LargerThanSecond { }
protocol LargerThanHour: LargerThanMinute { }
protocol LargerThanDay: LargerThanHour { }
protocol LargerThanMonth: LargerThanDay { }
protocol LargerThanYear: LargerThanMonth { }

public struct Nanosecond: Unit, LessThanOrEqualToNanosecond {
    public static let component: Calendar.Component = .nanosecond
}

public struct Second: Unit, LessThanOrEqualToSecond, LargerThanNanosecond {
    public static let component: Calendar.Component = .second
}

public struct Minute: Unit, LessThanOrEqualToMinute, LargerThanSecond {
    public static let component: Calendar.Component = .minute
}

public struct Hour: Unit, LessThanOrEqualToHour, LargerThanMinute {
    public static let component: Calendar.Component = .hour
}

public struct Day: Unit, LessThanOrEqualToDay, LargerThanHour {
    public static let component: Calendar.Component = .day
}

public struct Month: Unit, LessThanOrEqualToMonth, LargerThanDay {
    public static let component: Calendar.Component = .month
}

public struct Year: Unit, LessThanOrEqualToYear, LargerThanMonth {
    public static let component: Calendar.Component = .year
}

public struct Era: Unit, LessThanOrEqualToEra, LargerThanYear {
    public static let component: Calendar.Component = .era
}

internal func componentsFrom<L: Unit, U: Unit>(lower: L.Type, to upper: U.Type) -> Set<Calendar.Component> {
    let order = Calendar.Component.order
    guard let lowerIndex = order.firstIndex(of: L.component) else { return [] }
    guard let upperIndex = order.firstIndex(of: U.component) else { return [] }
    guard lowerIndex <= upperIndex else { return [] }
    
    let components = order[lowerIndex ... upperIndex]
    return Set(components)
}

/*
 extension Hour: LessThanOrEqualToHour, LargerThanMinute {}
 extension Minute: LessThanOrEqualToMinute, LargerThanSecond {}
 extension Second: LessThanOrEqualToSecond {}
 ​​
 extension Relative where Smallest: LessThanOrEqualToSecond, Modulo: LargerThanSecond {
 var second: Int { dateComponents.second! }
 }
 ​​
 extension Relative where Smallest: LessThanOrEqualToMinute, Modulo: LargerThanMinute {
 var minute: Int { dateComponents.minute! }
 }
 ​​
 extension Relative where Smallest: LessThanOrEqualToHour, Modulo: LargerThanHour {
 var hour: Int { dateComponents.hour! }
 }
 
 */
