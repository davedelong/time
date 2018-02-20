//
//  Assertions.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

internal func require(_ condition: @autoclosure () -> Bool, _ why: String, file: StaticString = #file, line: UInt = #line) {
    guard condition() == true else {
        fatalError(why, file: file, line: line)
    }
}

internal extension Optional {
    
    func unwrap(_ why: String, file: StaticString = #file, line: UInt = #line) -> Wrapped {
        guard let value = self else {
            fatalError(why, file: file, line: line)
        }
        return value
    }
    
}

internal func invalid(_ function: StaticString = #function, file: StaticString = #file, line: UInt = #line) -> Never {
    fatalError("\(function) is invalid", file: file, line: line)
}
