//
//  XCFlakyTestCase.swift
//  Time
//
//  Created by Dave DeLong on 9/5/26.
//

import XCTest

open class XCFlakyTestCase: XCTestCase {
    
    open override func record(_ issue: XCTIssue) {
        var copy = issue
        copy.severity = .warning
        super.record(copy)
    }
    
}
