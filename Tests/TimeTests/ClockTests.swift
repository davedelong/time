//
//  File.swift
//  
//
//  Created by Dave DeLong on 10/28/19.
//

import XCTest
import Time

class ClockTests: XCTestCase {
    
    func testSystem() {
        
        let c = Clock.system
        let now = c.now()
        
        XCTAssertEqual(now.intervalSinceEpoch.rawValue, Date.timeIntervalSinceReferenceDate, accuracy: 0.001)
    }
    
    func testExplicit() {
        let c = Clock.posix
        
        let now = c.now()
        XCTAssertEqual(now.intervalSinceEpoch.rawValue, Date.timeIntervalSinceReferenceDate, accuracy: 0.001)
        
        let today = c.today()
        XCTAssertEqual(today.region, c.region)
    }
    
    func testAccelerated_2x() {
        let now = Clock.system.now()
        let c = Clock(startingFrom: now, rate: 2.0, region: Region.current)
        
        let thisSecond = c.now()
        wait(1)
        let nextSecond = c.now()
        
        let elapsedTime = nextSecond - thisSecond
        
        XCTAssertEqual(elapsedTime.rawValue, 2.0, accuracy: 0.2) // 10% margin for error
    }
    
    func testAccelerated_10x() {
        let now = Clock.system.now()
        let c = Clock(startingFrom: now, rate: 10.0, region: Region.current)
        
        let thisSecond = c.now()
        wait(1)
        let nextSecond = c.now()
        
        let elapsedTime = nextSecond - thisSecond
        
        XCTAssertEqual(elapsedTime.rawValue, 10.0, accuracy: 1.0) // 10% margin for error
    }
    
    func testDecelerated_2x() {
        let now = Clock.system.now()
        let c = Clock(startingFrom: now, rate: 0.5, region: Region.current)
        
        let thisSecond = c.now()
        wait(1)
        let nextSecond = c.now()
        
        let elapsedTime = nextSecond - thisSecond
        
        XCTAssertEqual(elapsedTime.rawValue, 0.5, accuracy: 0.05) // 10% margin for error
    }
    
    func testDecelerated_10x() {
        let now = Clock.system.now()
        let c = Clock(startingFrom: now, rate: 0.1, region: Region.current)
        
        let thisSecond = c.now()
        wait(1)
        let nextSecond = c.now()
        
        let elapsedTime = nextSecond - thisSecond
        
        XCTAssertEqual(elapsedTime.rawValue, 0.1, accuracy: 0.01) // 10% margin for error
    }
    
}
