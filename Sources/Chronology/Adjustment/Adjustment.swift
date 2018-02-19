//
//  Adjustment.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public protocol Adjustment {
    
    func adjust<A: CalendarValue, B: CalendarValue>(_ input: A) -> B
    
}
