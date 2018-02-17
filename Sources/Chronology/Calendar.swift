//
//  Calendar.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 2/17/18.
//

import Foundation

public extension Calendar {
    
    public var isTerrestrial: Bool { return SISecondsPerSecond == 1.0 }
    public var SISecondsPerSecond: Double { return 1.0 }
    
}
