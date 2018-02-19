//
//  __Policy.swift
//  ChronologyPackageDescription
//
//  Created by Dave DeLong on 11/30/17.
//

import Foundation

enum Policy {
    case strict
    case smart
    case lenient
}

var ymd: YearMonthDay?
let foo = ymd?.set(month: 4)
