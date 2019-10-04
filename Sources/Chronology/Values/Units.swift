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

protocol LessThanEternity: Unit { }
protocol LessThanEra: LessThanEternity { }
protocol LessThanYear: LessThanEra { }
protocol LessThanMonth: LessThanYear { }
protocol LessThanDay: LessThanMonth { }
protocol LessThanHour: LessThanDay { }
protocol LessThanMinute: LessThanHour { }
protocol LessThanSecond: LessThanMinute { }
protocol LessThanNanosecond: LessThanSecond { }

protocol GreaterThanOrEqualToNanosecond: Unit { }
protocol GreaterThanOrEqualToSecond: GreaterThanOrEqualToNanosecond { }
protocol GreaterThanOrEqualToMinute: GreaterThanOrEqualToSecond { }
protocol GreaterThanOrEqualToHour: GreaterThanOrEqualToMinute { }
protocol GreaterThanOrEqualToDay: GreaterThanOrEqualToHour { }
protocol GreaterThanOrEqualToMonth: GreaterThanOrEqualToDay { }
protocol GreaterThanOrEqualToYear: GreaterThanOrEqualToMonth { }
protocol GreaterThanOrEqualToEra: GreaterThanOrEqualToYear { }

public struct Nanosecond: Unit, GreaterThanOrEqualToNanosecond {
    public static let component: Calendar.Component = .nanosecond
}

public struct Second: Unit, LessThanMinute, GreaterThanOrEqualToSecond {
    public static let component: Calendar.Component = .second
}

public struct Minute: Unit, LessThanHour, GreaterThanOrEqualToMinute {
    public static let component: Calendar.Component = .minute
}

public struct Hour: Unit, LessThanDay, GreaterThanOrEqualToHour {
    public static let component: Calendar.Component = .hour
}

public struct Day: Unit, LessThanMonth, GreaterThanOrEqualToDay {
    public static let component: Calendar.Component = .day
}

public struct Month: Unit, LessThanYear, GreaterThanOrEqualToMonth {
    public static let component: Calendar.Component = .month
}

public struct Year: Unit, LessThanEra, GreaterThanOrEqualToYear {
    public static let component: Calendar.Component = .year
}

public struct Era: Unit, LessThanEternity, GreaterThanOrEqualToEra {
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
 extension Hour: LessThanOrEqualToHour, GreaterThanOrEqualToThanMinute {}
 extension Minute: LessThanOrEqualToMinute, GreaterThanOrEqualToThanSecond {}
 extension Second: LessThanOrEqualToSecond {}
 ​​
 extension Relative where Smallest: LessThanOrEqualToSecond, Modulo: GreaterThanOrEqualToThanSecond {
 var second: Int { dateComponents.second! }
 }
 ​​
 extension Relative where Smallest: LessThanOrEqualToMinute, Modulo: GreaterThanOrEqualToThanMinute {
 var minute: Int { dateComponents.minute! }
 }
 ​​
 extension Relative where Smallest: LessThanOrEqualToHour, Modulo: GreaterThanOrEqualToThanHour {
 var hour: Int { dateComponents.hour! }
 }
 
 */
