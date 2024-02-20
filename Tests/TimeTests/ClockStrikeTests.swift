import XCTest
import Time

#if canImport(Combine)
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class ClockStrikeTests: XCTestCase {
    
    static var allTests = [
        ("testPastStrike", testPastStrike),
        ("testImmediateStrike", testImmediateStrike),
        ("testStrikeAtSpecificValue", testStrikeAtSpecificValue),
        ("testScaledStrikeAtSpecificValue", testScaledStrikeAtSpecificValue),
        ("testFixedStrikeCancel", testFixedStrikeCancel),
        ("testIntervalStrike", testIntervalStrike),
        ("testIntervalStrikeWithPastStart", testIntervalStrikeWithPastStart),
        ("testIntervalStrikeCancel", testIntervalStrikeCancel),
        ("testPredicateStrike", testPredicateStrike),
    ]
    
    let clock = Clocks.system
    var cancellables = Set<AnyCancellable>()
    
    override func tearDown() {
        super.tearDown()
        cancellables = []
    }
    
    func testPastStrike() {
        let dontStrike = expectation(description: "Clock never strikes")
        dontStrike.isInverted = true
        
        let completes = expectation(description: "Strike completes")
        let lastMinute = clock.previousMinute
        
        clock
            .strike(at: lastMinute) // Should fire ASAP
            .publisher
            .sink(receiveCompletion: { _ in
                completes.fulfill()
            }, receiveValue: { _ in
                dontStrike.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [completes, dontStrike], timeout: 0.01, enforceOrder: true)
    }
    
    func testPastStrikeAsync() async throws {
        let lastMinute = clock.previousMinute
        
        var strikeCount = 0
        for try await _ in clock.strike(at: lastMinute).asyncValues {
            XCTFail("Clock strikes should skip times in the past")
            strikeCount += 1
        }
        XCTAssertEqual(strikeCount, 0)
    }
    
    func testImmediateStrike() {
        let strikesOnce = expectation(description: "Clock strikes immediately")
        let completes = expectation(description: "Strike completes")
        let now = clock.currentSecond
        
        clock
            .strike(at: now) // Should fire immediately
            .publisher
            .sink(receiveCompletion: { _ in
                completes.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(now, value)
                strikesOnce.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [strikesOnce, completes], timeout: 0.5, enforceOrder: true)
    }
    
    func testImmediateStrikeAsync() async throws {
        let start = clock.currentSecond
        
        var strikeCount = 0
        for try await time in clock.strike(at: start).asyncValues {
            let now = clock.currentSecond
            XCTAssertEqual(start, now)
            XCTAssertEqual(time, now)
            strikeCount += 1
        }
        XCTAssertEqual(strikeCount, 1)
    }
    
    func testStrikeAtSpecificValue() {
        let strikesOnce = expectation(description: "Clock strikes shortly")
        let completes = expectation(description: "Strike completes")
        
        let nextSecond = clock.nextSecond
        clock
            .strike(at: nextSecond)
            .publisher
            .sink(receiveCompletion: { _ in
                completes.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(value, nextSecond)
                strikesOnce.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [strikesOnce, completes], timeout: 1, enforceOrder: true)
    }
    
    func testStrikeAtSpecificValueAsync() async throws {
        let nextSecond = clock.nextSecond
        var strikeCount = 0
        
        for try await time in clock.strike(at: nextSecond).asyncValues {
            XCTAssertEqual(time, nextSecond)
            strikeCount += 1
        }
        XCTAssertEqual(strikeCount, 1)
    }
    
    func testScaledStrikeAtSpecificValue() {
        let strikesOnce = expectation(description: "Clock strikes shortly")
        let completes = expectation(description: "Strike completes")
        
        let sixtyXClock = Clocks.custom(startingFrom: clock.now, rate: 60.0, region: clock.region)
        let nextMinute = sixtyXClock.nextMinute
        
        sixtyXClock
            .strike(at: nextMinute)
            .publisher
            .sink(receiveCompletion: { _ in
                completes.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(value, nextMinute)
                strikesOnce.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [strikesOnce, completes], timeout: 1, enforceOrder: true)
    }
    
    func testScaledStrikeAtSpecificValueAsync() async throws {
        let sixtyXClock = Clocks.custom(startingFrom: clock.now, rate: 60.0, region: clock.region)
        let nextMinute = sixtyXClock.nextMinute
        
        var strikeCount = 0
        for try await time in sixtyXClock.strike(at: nextMinute).asyncValues {
            XCTAssertEqual(time, nextMinute)
            strikeCount += 1
        }
        XCTAssertEqual(strikeCount, 1)
    }
    
    func testFixedStrikeCancel() {
        let nextSecond = clock.nextSecond
        let dontStrike = expectation(description: "Clock does not strike")
        dontStrike.isInverted = true
        let strike = clock.strike(at: nextSecond)
            .publisher
            .sink { value in
                dontStrike.fulfill()
            }
        strike.cancel()
        wait(for: [dontStrike], timeout: 1.0)
    }
    
    // There's no way to make a `testFixedStrikeCancelAsync()` test, because callers cannot cancel an async for loop
    
    func testIntervalStrike() {
        let strikesTwice = expectation(description: "Clock strikes twice, once per second")
        strikesTwice.expectedFulfillmentCount = 2
        
        let start = clock.nextSecond
        var results = [start, start.nextSecond]
        print("Expecting strikes at \(results)")
        
        clock
            .strike(every: TimeDifference<Second, Era>.seconds(1), startingFrom: start)
            .publisher
            .sink(receiveCompletion: { (completion) in
                XCTFail("Repeating strike completed: \(completion)")
            }, receiveValue: { value in
                let expected = results.removeFirst()
                XCTAssertEqual(value, expected)
                strikesTwice.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [strikesTwice], timeout: 2.0)
    }
    
    func testIntervalStrikeAsync() async throws {
        let start = clock.nextSecond
        
        var expected = [start, start.nextSecond]
        var strikeCount = 0
        
        for try await time in clock.strike(every: .seconds(1), startingFrom: start).asyncValues {
            XCTAssertEqual(time, expected.removeFirst())
            strikeCount += 1
            if expected.isEmpty { break }
        }
        
        XCTAssertEqual(strikeCount, 2)
    }
    
    func testIntervalStrikeWithPastStart() {
        let strikes = expectation(description: "Clock strikes once")
        
        let thisSecond = clock.currentSecond
        let aMinuteAgo = thisSecond.subtracting(minutes: 1)
        
        clock
            .strike(every: .seconds(1), startingFrom: aMinuteAgo)
            .publisher
            .sink(receiveCompletion: { (completion) in
                XCTFail("Repeating strike completed: \(completion)")
            }, receiveValue: { value in
                XCTAssertEqual(value, thisSecond)
                strikes.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [strikes], timeout: 1)
    }
    
    func testIntervalStrikeWithPastStartAsync() async throws {
        let thisSecond = clock.currentSecond
        let aMinuteAgo = thisSecond.subtracting(minutes: 1)
        
        var strikeCount = 0
        for try await time in clock.strike(every: .seconds(1), startingFrom: aMinuteAgo).asyncValues {
            XCTAssertEqual(time, thisSecond)
            strikeCount += 1
            break
        }
        XCTAssertEqual(strikeCount, 1)
    }
    
    func testIntervalStrikeCancel() {
        let blueMoon = TimeDifference<Nanosecond, Era>.nanoseconds(1_000_000_000 / 12)
        let bellOfStJohn = expectation(description: "The bell rings twelve times")
        bellOfStJohn.expectedFulfillmentCount = 12
        clock.strike(every: blueMoon)
            .publisher
            .sink { _ in
                bellOfStJohn.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [bellOfStJohn], timeout: 2)
    }
    
    func testPredicateStrike() {
        // Set to the next hour
        let justBeforeNextMinute = clock.nextMinute.firstSecond.previous
        
        // every second is a minute
        let fastClock = Clocks.custom(startingFrom: justBeforeNextMinute.firstInstant, rate: 60.0, region: clock.region)
        var results = [0, 13, 26, 39, 52]
        
        let strikes = expectation(description: "Clock strikes 5 times in an hour")
        strikes.expectedFulfillmentCount = 5
        
        fastClock
            .strike(when: { (value: Fixed<Second>) -> Bool in
                return value.second % 13 == 0
            })
            .publisher
            .sink(receiveValue: { value in
                let expected = results.removeFirst()
                XCTAssertEqual(value.second, expected)
                strikes.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [strikes], timeout: 10.0)
    }
    
    func testPredicateStrikeAsync() async throws {
        let justBeforeTheNextMinute = clock.nextMinute.firstSecond.previous
        
        let fastClock = Clocks.custom(startingFrom: justBeforeTheNextMinute.firstInstant, rate: 60.0, region: clock.region)
        var results = [0, 13, 26, 39, 52]
        
        for try await time in fastClock.strike(producing: Second.self, when: { $0.second.isMultiple(of: 13) }).asyncValues {
            XCTAssertEqual(time.second, results.removeFirst())
            if results.isEmpty { break }
        }
        
        XCTAssertTrue(results.isEmpty)
    }
    
}

#else

final class ClockStrikeTests: XCTestCase {
    static var allTests: [(String, (ClockStrikeTests) -> () throws -> ())] = []
}

#endif
