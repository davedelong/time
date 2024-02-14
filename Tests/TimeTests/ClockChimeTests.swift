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
        ("testFixedChimeCancel", testFixedChimeCancel),
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
        let lastMinute = clock.previousMinute
        
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
    
    func testPastChimeAsync() async throws {
        let lastMinute = clock.previousMinute
        
        var chimeCount = 0
        for try await _ in clock.chime(at: lastMinute) {
            XCTFail("Clock chimes should skip times in the past")
            chimeCount += 1
        }
        XCTAssertEqual(chimeCount, 0)
    }
    
    func testImmediateChime() {
        let chimesOnce = expectation(description: "Clock chimes immediately")
        let completes = expectation(description: "Chime completes")
        let now = clock.currentSecond
        
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
    
    func testImmediateChimeAsync() async throws {
        let start = clock.currentSecond
        
        var chimeCount = 0
        for try await time in clock.chime(at: start) {
            let now = clock.currentSecond
            XCTAssertEqual(start, now)
            XCTAssertEqual(time, now)
            chimeCount += 1
        }
        XCTAssertEqual(chimeCount, 1)
    }
    
    func testChimeAtSpecificValue() {
        let chimesOnce = expectation(description: "Clock chimes shortly")
        let completes = expectation(description: "Chime completes")
        
        let nextSecond = clock.nextSecond
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
    
    func testChimeAtSpecificValueAsync() async throws {
        let nextSecond = clock.nextSecond
        var chimeCount = 0
        
        for try await time in clock.chime(at: nextSecond) {
            XCTAssertEqual(time, nextSecond)
            chimeCount += 1
        }
        XCTAssertEqual(chimeCount, 1)
    }
    
    func testScaledChimeAtSpecificValue() {
        let chimesOnce = expectation(description: "Clock chimes shortly")
        let completes = expectation(description: "Chime completes")
        
        let sixtyXClock = Clocks.custom(startingFrom: clock.now, rate: 60.0, region: clock.region)
        let nextMinute = sixtyXClock.nextMinute
        
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
    
    func testScaledChimeAtSpecificValueAsync() async throws {
        let sixtyXClock = Clocks.custom(startingFrom: clock.now, rate: 60.0, region: clock.region)
        let nextMinute = sixtyXClock.nextMinute
        
        var chimeCount = 0
        for try await time in sixtyXClock.chime(at: nextMinute) {
            XCTAssertEqual(time, nextMinute)
            chimeCount += 1
        }
        XCTAssertEqual(chimeCount, 1)
    }
    
    func testFixedChimeCancel() {
        let nextSecond = clock.nextSecond
        let dontChime = expectation(description: "Clock does not chime")
        dontChime.isInverted = true
        let chime = clock.chime(at: nextSecond).sink { value in
            dontChime.fulfill()
        }
        chime.cancel()
        wait(for: [dontChime], timeout: 1.0)
    }
    
    // There's no way to make a `testFixedChimeCancelAsync()` test, because callers cannot cancel an async for loop
    
    func testIntervalChime() {
        let chimesTwice = expectation(description: "Clock chimes twice, once per second")
        chimesTwice.expectedFulfillmentCount = 2
        
        let start = clock.nextSecond
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
    
    func testIntervalChimeAsync() async throws {
        let start = clock.nextSecond
        
        var expected = [start, start.nextSecond]
        var chimeCount = 0
        
        for try await time in clock.chime(every: .seconds(1), startingFrom: start) {
            XCTAssertEqual(time, expected.removeFirst())
            chimeCount += 1
            if expected.isEmpty { break }
        }
        
        XCTAssertEqual(chimeCount, 2)
    }
    
    func testIntervalChimeWithPastStart() {
        let chimes = expectation(description: "Clock chimes once")
        
        let thisSecond = clock.currentSecond
        let aMinuteAgo = thisSecond.subtracting(minutes: 1)
        
        clock
            .chime(every: .seconds(1), startingFrom: aMinuteAgo)
            .sink(receiveCompletion: { (completion) in
                XCTFail("Repeating chime completed: \(completion)")
            }, receiveValue: { value in
                XCTAssertEqual(value, thisSecond)
                chimes.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [chimes], timeout: 1)
    }
    
    func testIntervalChimeWithPastStartAsync() async throws {
        let thisSecond = clock.currentSecond
        let aMinuteAgo = thisSecond.subtracting(minutes: 1)
        
        var chimeCount = 0
        for try await time in clock.chime(every: .seconds(1), startingFrom: aMinuteAgo) {
            XCTAssertEqual(time, thisSecond)
            chimeCount += 1
            break
        }
        XCTAssertEqual(chimeCount, 1)
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
        let justBeforeNextMinute = clock.nextMinute.firstSecond.previous
        
        // every second is a minute
        let fastClock = Clocks.custom(startingFrom: justBeforeNextMinute.firstInstant, rate: 60.0, region: clock.region)
        var results = [0, 13, 26, 39, 52]
        
        let chimes = expectation(description: "Clock chimes 5 times in an hour")
        chimes.expectedFulfillmentCount = 5
        
        fastClock
            .chime(when: { (value: Fixed<Second>) -> Bool in
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
    
    func testPredicateChimeAsync() async throws {
        let justBeforeTheNextMinute = clock.nextMinute.firstSecond.previous
        
        let fastClock = Clocks.custom(startingFrom: justBeforeTheNextMinute.firstInstant, rate: 60.0, region: clock.region)
        var results = [0, 13, 26, 39, 52]
        
        for try await time in fastClock.chime(producing: Second.self, when: { $0.second.isMultiple(of: 13) }) {
            XCTAssertEqual(time.second, results.removeFirst())
            if results.isEmpty { break }
        }
        
        XCTAssertTrue(results.isEmpty)
    }
    
}

#else

final class ClockChimeTests: XCTestCase {
    static var allTests: [(String, (ClockChimeTests) -> () throws -> ())] = []
}

#endif
