//
//  Assertions.swift
//  Time
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

internal func require(_ condition: @autoclosure () -> Bool, _ why: @autoclosure () -> String, file: StaticString = #fileID, line: UInt = #line) {
    guard condition() == true else {
        fatalError(why(), file: file, line: line)
    }
}

internal extension Optional {
    
    func unwrap(_ why: @autoclosure () -> String, file: StaticString = #fileID, line: UInt = #line) -> Wrapped {
        guard let value = self else {
            fatalError(why(), file: file, line: line)
        }
        return value
    }
    
}

internal func invalid(_ function: StaticString = #function, file: StaticString = #fileID, line: UInt = #line) -> Never {
    fatalError("\(function) is invalid", file: file, line: line)
}
