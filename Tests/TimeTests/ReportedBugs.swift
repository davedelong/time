//
//  File.swift
//  
//
//  Created by Dave DeLong on 5/24/23.
//

import XCTest
import Time

class ReportedBugs: XCTestCase {
    
    func testSwedenRangeCrashAroundDST() throws {
        let sweden = Region(calendar: Calendar(identifier: .gregorian),
                            timeZone: TimeZone(identifier: "Europe/Stockholm")!,
                              locale: Locale(identifier: "en_US"))

        let start = try Absolute<Second>(region: sweden, year: 2023, month: 10, day: 29, hour: 02, minute: 30, second: 00)
        let end = start.adding(minutes: 30)
        let range = start ..< end
        
        XCTAssertTrue(range.upperBound > range.lowerBound)
    }
    
    func testSwedenRepeatedOffsettingAroundDST() throws {
        let sweden = Region(calendar: Calendar(identifier: .gregorian),
                            timeZone: TimeZone(identifier: "Europe/Stockholm")!,
                              locale: Locale(identifier: "en_US"))

        let start = try Absolute<Second>(region: sweden, year: 2023, month: 10, day: 29, hour: 02, minute: 30, second: 00)
        let target = start.adding(hours: 10)
        var step = start

        while step.isBefore(target) {
            step = step.adding(minutes: 30)
        }
        
        XCTAssertTrue(step >= target)
    }
    
}
