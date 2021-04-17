//
//  ClockTests.swift
//  
//
//  Created by Dave DeLong on 10/28/19.
//

import XCTest
import Time

class ClockTests: XCTestCase {
    
    static var allTests = [
        ("testSystem", testSystem),
        ("testExplicit", testExplicit),
        ("testAccelerated_2x", testAccelerated_2x),
        ("testAccelerated_10x", testAccelerated_10x),
        ("testDecelerated_2x", testDecelerated_2x),
        ("testDecelerated_10x", testDecelerated_10x),
        ("testNextDSTTransitionForTimeZoneWithDST", testNextDSTTransitionForTimeZoneWithDST),
        ("testNextDSTTransitionNextYearForTimeZoneWithDST", testNextDSTTransitionNextYearForTimeZoneWithDST),
        ("testNextDSTTransitionForTimeZoneWithoutDST", testNextDSTTransitionForTimeZoneWithoutDST),
        ("testNextDSTTransitionNextYearForTimeZoneWithoutDST", testNextDSTTransitionNextYearForTimeZoneWithoutDST)
    ]
    
    func testSystem() {
        
        let c = Clocks.system
        let now = c.now()
        
        XCTAssertEqual(now.intervalSinceEpoch.rawValue, Date.timeIntervalSinceReferenceDate, accuracy: 0.001)
    }
    
    func testExplicit() {
        let c = Clocks.posix
        
        let now = c.now()
        XCTAssertEqual(now.intervalSinceEpoch.rawValue, Date.timeIntervalSinceReferenceDate, accuracy: 0.001)
        
        let today = c.today()
        XCTAssertEqual(today.region, c.region)
    }
    
    func testAccelerated_2x() {
        let now = Clocks.system.now()
        let c = Clocks.custom(startingFrom: now, rate: 2.0, region: Region.current)
        
        let thisSecond = c.now()
        wait(1)
        let nextSecond = c.now()
        
        let elapsedTime = nextSecond - thisSecond
        
        XCTAssertEqual(elapsedTime.rawValue, 2.0, accuracy: 0.2) // 10% margin for error
    }
    
    func testAccelerated_10x() {
        let now = Clocks.system.now()
        let c = Clocks.custom(startingFrom: now, rate: 10.0, region: Region.current)
        
        let thisSecond = c.now()
        wait(1)
        let nextSecond = c.now()
        
        let elapsedTime = nextSecond - thisSecond
        
        // we need a larger margin for error here so the CI tests can handle this
        XCTAssertEqual(elapsedTime.rawValue, 10.0, accuracy: 1.5) // 15% margin for error
    }
    
    func testDecelerated_2x() {
        let now = Clocks.system.now()
        let c = Clocks.custom(startingFrom: now, rate: 0.5, region: Region.current)
        
        let thisSecond = c.now()
        wait(1)
        let nextSecond = c.now()
        
        let elapsedTime = nextSecond - thisSecond
        
        XCTAssertEqual(elapsedTime.rawValue, 0.5, accuracy: 0.05) // 10% margin for error
    }
    
    func testDecelerated_10x() {
        let now = Clocks.system.now()
        let c = Clocks.custom(startingFrom: now, rate: 0.1, region: Region.current)
        
        let thisSecond = c.now()
        wait(1)
        let nextSecond = c.now()
        
        let elapsedTime = nextSecond - thisSecond
        
        XCTAssertEqual(elapsedTime.rawValue, 0.1, accuracy: 0.01) // 10% margin for error
    }
}

// MARK: - Next Daylight Saving Time Transition

extension ClockTests {
    
    func testNextDSTTransitionForTimeZoneWithDST() {
        let timeZone = TimeZone(identifier: "Europe/London")!
        
        let region = Region(
            calendar: .autoupdatingCurrent,
            timeZone: timeZone,
            locale: .autoupdatingCurrent)
        
        let clock = Clocks.system(in: region)
        
        let instant = clock.nextDaylightSavingTimeTransition()
        XCTAssertNotNil(instant)
        XCTAssertEqual(
            instant?.intervalSinceEpoch.rawValue,
            timeZone.nextDaylightSavingTimeTransition?.timeIntervalSinceReferenceDate)
    }
    
    func testNextDSTTransitionNextYearForTimeZoneWithDST() {
        let timeZone = TimeZone(identifier: "Europe/London")!
        
        let region = Region(
            calendar: .autoupdatingCurrent,
            timeZone: timeZone,
            locale: .autoupdatingCurrent)
        
        let clock = Clocks.system(in: region)
        let instantNextYear = (clock.thisDay() + .years(1)).firstInstant
        
        let nextDSTSeconds = clock
            .nextDaylightSavingTimeTransition(after: instantNextYear)?.intervalSinceEpoch.rawValue
        
        let expectedDSTSeconds = timeZone
            .nextDaylightSavingTimeTransition(after: instantNextYear.date)?.timeIntervalSinceReferenceDate
        
        XCTAssertNotNil(nextDSTSeconds)
        XCTAssertEqual(nextDSTSeconds, expectedDSTSeconds)
    }
    
    func testNextDSTTransitionForTimeZoneWithoutDST() {
        let timeZone = TimeZone(identifier: "Europe/Moscow")!

        let region = Region(
            calendar: .autoupdatingCurrent,
            timeZone: timeZone,
            locale: .autoupdatingCurrent)

        let clock = Clocks.system(in: region)
        
        XCTAssertNil(clock.nextDaylightSavingTimeTransition())
    }
    
    func testNextDSTTransitionNextYearForTimeZoneWithoutDST() {
        let timeZone = TimeZone(identifier: "Europe/Moscow")!

        let region = Region(
            calendar: .autoupdatingCurrent,
            timeZone: timeZone,
            locale: .autoupdatingCurrent)

        let clock = Clocks.system(in: region)
        let instantNextYear = (clock.thisDay() + .years(1)).firstInstant
        
        let nextDSTSeconds = clock
            .nextDaylightSavingTimeTransition(after: instantNextYear)?.intervalSinceEpoch.rawValue
        
        XCTAssertNil(nextDSTSeconds)
    }
    
}
