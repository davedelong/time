//
//  ClockChimeTests.swift
//  TimeTests
//
//  Created by James Robinson on 4/11/20.
//

import XCTest
import Time

#if canImport(Combine)
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class ClockChimeTests: XCTestCase {
    
    static var allTests = [
        ("testPastChime", testPastChime),
        ("testImmediateChime", testImmediateChime),
        ("testChimeAtSpecificValue", testChimeAtSpecificValue),
        ("testScaledChimeAtSpecificValue", testScaledChimeAtSpecificValue),
        ("testAbsoluteChimeCancel", testAbsoluteChimeCancel),
        ("testIntervalChime", testIntervalChime),
        ("testIntervalChimeWithPastStart", testIntervalChimeWithPastStart),
        ("testIntervalChimeCancel", testIntervalChimeCancel),
        ("testPredicateChime", testPredicateChime),
    ]
    
    let clock = Clocks.system
    var cancellables = Set<AnyCancellable>()
    
    override func tearDown() {
        super.tearDown()
        cancellables = []
    }
    
    func testPastChime() {
        let dontChime = expectation(description: "Clock never chimes")
        dontChime.isInverted = true
        
        let completes = expectation(description: "Chime completes")
        let lastMinute = clock.previousMinute()
        
        clock
            .chime(at: lastMinute) // Should fire ASAP
            .sink(receiveCompletion: { _ in
                completes.fulfill()
            }, receiveValue: { _ in
                dontChime.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [completes, dontChime], timeout: 0.01, enforceOrder: true)
    }
    
    func testImmediateChime() {
        let chimesOnce = expectation(description: "Clock chimes immediately")
        let completes = expectation(description: "Chime completes")
        let now = clock.thisSecond()
        
        clock
            .chime(at: now) // Should fire immediately
            .sink(receiveCompletion: { _ in
                completes.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(now, value)
                chimesOnce.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [chimesOnce, completes], timeout: 0.5, enforceOrder: true)
    }
    
    func testChimeAtSpecificValue() {
        let chimesOnce = expectation(description: "Clock chimes shortly")
        let completes = expectation(description: "Chime completes")
        
        let nextSecond = clock.nextSecond()
        clock
            .chime(at: nextSecond)
            .sink(receiveCompletion: { _ in
                completes.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(value, nextSecond)
                chimesOnce.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [chimesOnce, completes], timeout: 1, enforceOrder: true)
    }
    
    func testScaledChimeAtSpecificValue() {
        let chimesOnce = expectation(description: "Clock chimes shortly")
        let completes = expectation(description: "Chime completes")
        
        let sixtyXClock = Clocks.custom(startingFrom: clock.now(), rate: 60.0, region: clock.region)
        let nextMinute = sixtyXClock.nextMinute()
        
        sixtyXClock
            .chime(at: nextMinute)
            .sink(receiveCompletion: { _ in
                completes.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(value, nextMinute)
                chimesOnce.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [chimesOnce, completes], timeout: 1, enforceOrder: true)
    }
    
    func testAbsoluteChimeCancel() {
        let nextSecond = clock.nextSecond()
        let dontChime = expectation(description: "Clock does not chime")
        dontChime.isInverted = true
        let chime = clock.chime(at: nextSecond).sink { value in
            dontChime.fulfill()
        }
        chime.cancel()
        wait(for: [dontChime], timeout: 1.0)
    }
    
    func testIntervalChime() {
        let chimesTwice = expectation(description: "Clock chimes twice, once per second")
        chimesTwice.expectedFulfillmentCount = 2
        
        let start = clock.nextSecond()
        var results = [start, start.nextSecond]
        print("Expecting chimes at \(results)")
        
        clock
            .chime(every: TimeDifference<Second, Era>.seconds(1), startingFrom: start)
            .sink(receiveCompletion: { (completion) in
                XCTFail("Repeating chime completed: \(completion)")
            }, receiveValue: { value in
                let expected = results.removeFirst()
                XCTAssertEqual(value, expected)
                chimesTwice.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [chimesTwice], timeout: 2.0)
    }
    
    func testIntervalChimeWithPastStart() {
        let chimes = expectation(description: "Clock chimes once")
        
        let thisSecond = clock.thisSecond()
        let startAMonthAgo = thisSecond.subtracting(minutes: 1)
        
        clock
            .chime(every: TimeDifference<Second, Era>.seconds(1), startingFrom: startAMonthAgo)
            .sink(receiveCompletion: { (completion) in
                XCTFail("Repeating chime completed: \(completion)")
            }, receiveValue: { value in
                XCTAssertEqual(value, thisSecond)
                chimes.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [chimes], timeout: 0.1)
    }
    
    func testIntervalChimeCancel() {
        let blueMoon = TimeDifference<Nanosecond, Era>.nanoseconds(1_000_000_000 / 12)
        let bellOfStJohn = expectation(description: "The bell rings twelve times")
        bellOfStJohn.expectedFulfillmentCount = 12
        clock.chime(every: blueMoon).sink { _ in
            bellOfStJohn.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [bellOfStJohn], timeout: 2)
    }
    
    func testPredicateChime() {
        // Set to the next hour
        let justBeforeNextMinute = clock.nextMinute().firstSecond.previous
        
        // every second is a minute
        let fastClock = Clocks.custom(startingFrom: justBeforeNextMinute.firstInstant, rate: 60.0, region: clock.region)
        var results = [0, 13, 26, 39, 52]
        
        let chimes = expectation(description: "Clock chimes 5 times in an hour")
        chimes.expectedFulfillmentCount = 5
        
        fastClock
            .chime(when: { (value: Absolute<Second>) -> Bool in
                return value.second % 13 == 0
            })
            .sink(receiveValue: { value in
                let expected = results.removeFirst()
                XCTAssertEqual(value.second, expected)
                chimes.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [chimes], timeout: 10.0)
    }
    
}

#else

final class ClockChimeTests: XCTestCase {
    static var allTests: [(String, (ClockChimeTests) -> () throws -> ())] = []
}

#endif
