//
//  Intervals.swift
//  Chronology
//
//  Created by Dave DeLong on 2/17/18.
//

import Foundation

public struct TimeInterval {
    
    public static func seconds(_ s: Double) -> Interval { return TimeInterval() }
    public static func minutes(_ s: Int) -> Interval { return TimeInterval() }
    public static func hours(_ s: Int) -> Interval { return TimeInterval() }
    
}

public struct DateInterval {
    
    public static func days(_ s: Int) -> Interval { return DateInterval() }
    public static func weeks(_ s: Int) -> Interval { return DateInterval() }
    public static func months(_ s: Int) -> Interval { return DateInterval() }
    public static func years(_ s: Int) -> Interval { return DateInterval() }
    
}
