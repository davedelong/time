//
//  ClockChimeTests.swift
//  TimeTests
//
//  Created by James Robinson on 4/11/20.
//

import XCTest
import Combine
import Time

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class ClockChimeTests: XCTestCase {
    
    static var allTests: [(String, (ClockChimeTests) -> () throws -> ())] = [
        ("testPastChime", testPastChime),
        ("testImmediateChime", testImmediateChime),
        ("testChimeAtSpecificPeriod", testChimeAtSpecificPeriod),
        ("testScaledChimeAtSpecificPeriod", testScaledChimeAtSpecificPeriod),
        ("testAbsoluteChimeCancel", testAbsoluteChimeCancel),
        ("testIntervalChime", testIntervalChime),
        ("testIntervalChimeOnce", testIntervalChimeOnce),
        ("testIntervalChimeAfterDelay", testIntervalChimeAfterDelay),
        ("testIntervalChimeCancel", testIntervalChimeCancel),
        ("testPredicateChime", testPredicateChime),
    ]
    
    var clock: Clock!
    
    override func setUp() {
        clock = Clock()
    }
    
    func testPastChime() {
        let chimesOnce = expectation(description: "Clock chimes immediately")
        let completes = expectation(description: "Chime completes")
        let minutesAgo = clock.thisNanosecond().subtracting(minutes: 5)
        let now = clock.thisNanosecond()
        
        var observation: AnyCancellable? = clock
            .chime(at: minutesAgo) // Should fire ASAP
            .sink(
                receiveCompletion: { (completion) in
                    completes.fulfill()
                },
                receiveValue: { (result) in
                    let expected = now.firstInstant.intervalSinceEpoch.rawValue
                    let actual = result.firstInstant.intervalSinceEpoch.rawValue
                    XCTAssertEqual(actual, expected, accuracy: 0.005,
                                   "Chime at \(actual)s is \(actual - expected)s late (early if negative).")
                    XCTAssertEqual(result.absoluteSecond,
                                   now.absoluteSecond)
                    chimesOnce.fulfill()
                }
            )
        
        wait(for: [chimesOnce, completes], timeout: 0.5, enforceOrder: true)
        if observation != nil { // Otherwise, the observer deallocates early, and cancels!
            observation = nil
        }
    }
    
    func testImmediateChime() {
        let chimesOnce = expectation(description: "Clock chimes immediately")
        let completes = expectation(description: "Chime completes")
        let now = clock.thisNanosecond()
        
        var observation: AnyCancellable? = clock
            .chime(at: now) // Should fire immediately
            .sink(
                receiveCompletion: { (completion) in
                    completes.fulfill()
                },
                receiveValue: { (result) in
                    let expected = now.firstInstant.intervalSinceEpoch.rawValue
                    let actual = result.firstInstant.intervalSinceEpoch.rawValue
                    XCTAssertEqual(actual, expected, accuracy: 0.005,
                                   "Chime at \(actual)s is \(actual - expected)s late (early if negative).")
                    XCTAssertEqual(result.absoluteSecond,
                                   now.absoluteSecond)
                    chimesOnce.fulfill()
                }
            )
        
        wait(for: [chimesOnce, completes], timeout: 0.5, enforceOrder: true)
        if observation != nil { // Otherwise, the observer deallocates early, and cancels!
            observation = nil
        }
    }
    
    func testChimeAtSpecificPeriod() {
        let chimesOnce = expectation(description: "Clock chimes shortly")
        let completes = expectation(description: "Chime completes")
        let seconds: Int = 2
        let xSecondsFromNow = clock.thisNanosecond().adding(seconds: seconds)
        
        var observation: AnyCancellable? = clock
            .chime(at: xSecondsFromNow) // Should fire in `seconds`
            .sink(
                receiveCompletion: { (completion) in
                    completes.fulfill()
                },
                receiveValue: { (result) in
                    let expected = xSecondsFromNow.firstInstant.intervalSinceEpoch.rawValue
                    let actual = result.firstInstant.intervalSinceEpoch.rawValue
                    XCTAssertEqual(actual, expected, accuracy: 0.005,
                                   "Chime at \(actual)s is \(actual - expected)s late (early if negative).")
                    XCTAssertEqual(result.absoluteSecond,
                                   xSecondsFromNow.absoluteSecond)
                    chimesOnce.fulfill()
                }
            )
        
        wait(for: [chimesOnce, completes], timeout: Double(seconds) + 0.5, enforceOrder: true)
        if observation != nil { // Otherwise, the observer deallocates early, and cancels!
            observation = nil
        }
    }
    
    func testScaledChimeAtSpecificPeriod() {
        let chimesOnce = expectation(description: "Clock chimes shortly")
        let completes = expectation(description: "Chime completes")
        let seconds: Int = 2
        let rate: Double = 2.0
        let clock = Clock(startingFrom: .reference, rate: rate)
        let xScaledSeconds = clock.thisNanosecond().adding(seconds: seconds)
        
        var observation: AnyCancellable? = clock
            .chime(at: xScaledSeconds) // Should fire when clock reads `seconds` (`seconds` / `rate`)
            .sink(
                receiveCompletion: { (completion) in
                    completes.fulfill()
                },
                receiveValue: { (result) in
                    let expected = xScaledSeconds.firstInstant.intervalSinceEpoch.rawValue
                    let actual = result.firstInstant.intervalSinceEpoch.rawValue
                    XCTAssertEqual(actual, expected, accuracy: 0.01,
                                   "Chime at \(actual)s is \(actual - expected)s late (early if negative).")
                    XCTAssertEqual(result.absoluteSecond,
                                   xScaledSeconds.absoluteSecond)
                    chimesOnce.fulfill()
                }
            )
        
        wait(for: [chimesOnce, completes], timeout: 1.5, enforceOrder: true)
        if observation != nil { // Otherwise, the observer deallocates early, and cancels!
            observation = nil
        }
    }
    
    func testAbsoluteChimeCancel() {
        let distantFuture = Absolute<Second>(region: .posix, date: .distantFuture)
        let chime = clock.chime(at: distantFuture).sink { (result) in
            XCTFail("We shouldn't get a chime from the distant future: \(result)")
        }
        chime.cancel()
        // This is mostly for coverage's sake. Cancellation is much easier to test with IntervalChime.
    }
    
    func testIntervalChime() {
        let chimesTwice = expectation(description: "Clock chimes twice, once per second")
        let units: Int = 1
        let count: Int = 2
        chimesTwice.expectedFulfillmentCount = count
        var results = [Double]()
        let now = clock.thisSecond().firstInstant.intervalSinceEpoch.rawValue
        for value in 0..<count {
            results.append(now + Double(units + units * value))
        } // Expected results are [units, units * 2, ..., units * (n-1)]
        
        var observation: AnyCancellable? = clock
            .chime(every: TimeDifference<Second, Era>.seconds(units))
            .sink(
                receiveCompletion: { (completion) in
                    XCTFail("Repeating chime completed: \(completion)")
                },
                receiveValue: { (result) in
                    let expected = results.removeFirst()
                    let actual = result.firstInstant.intervalSinceEpoch.rawValue
                    XCTAssertEqual(actual, expected, accuracy: 0.005,
                                   "Chime at \(actual)s is \(actual - expected)s late (early if negative).")
                    chimesTwice.fulfill()
                }
            )
        
        wait(for: [chimesTwice], timeout: 2.5)
        if observation != nil { // Otherwise, the observer deallocates early, and cancels!
            observation = nil
        }
    }
    
    func testIntervalChimeOnce() {
        let chimesOnce = expectation(description: "Clock chimes shortly")
        let nanoseconds: Int = 500_000_000 // half second
        let then = clock.thisNanosecond().adding(nanoseconds: nanoseconds)
        
        var observation: AnyCancellable? = clock
            .chime(every: TimeDifference<Nanosecond, Era>.nanoseconds(nanoseconds))
            .sink(
                receiveCompletion: { (completion) in
                    XCTFail("Repeating chime completed: \(completion)")
                },
                receiveValue: { (result) in
                    let expected = then.firstInstant.intervalSinceEpoch.rawValue
                    let actual = result.firstInstant.intervalSinceEpoch.rawValue
                    XCTAssertEqual(actual, expected, accuracy: 0.01,
                                   "Chime at \(actual)s is \(actual - expected)s late (early if negative).")
                    XCTAssertEqual(result.absoluteSecond,
                                   then.absoluteSecond)
                    chimesOnce.fulfill()  // This lets the waiter go through, which then cancels the watcher
                }
            )
        
        wait(for: [chimesOnce], timeout: 0.75)
        if observation != nil {
            observation = nil // See? Cancelled.
        }
    }
    
    func testIntervalChimeAfterDelay() {
        let chimesOnce = expectation(description: "Clock chimes shortly")
        let nanoseconds: Int = 500_000_000 // half second
        let delay: Int = 1
        let now = clock.thisNanosecond()
        let delaySeconds = now.adding(seconds: delay)
        let then = delaySeconds.adding(nanoseconds: nanoseconds)
        
        var observation: AnyCancellable? = clock
            .chime(every: TimeDifference<Nanosecond, Era>.nanoseconds(nanoseconds),
                   startingFrom: delaySeconds)
            .sink(
                receiveCompletion: { (completion) in
                    XCTFail("Repeating chime completed: \(completion)")
                },
                receiveValue: { (result) in
                    let expected = then.firstInstant.intervalSinceEpoch.rawValue
                    let actual = result.firstInstant.intervalSinceEpoch.rawValue
                    XCTAssertEqual(actual, expected, accuracy: 0.01,
                                   "Chime at \(actual)s is \(actual - expected)s late (early if negative).")
                    XCTAssertEqual(result.absoluteSecond,
                                   then.absoluteSecond)
                    chimesOnce.fulfill() // This lets the waiter go through, which then cancels the watcher
                }
            )
        
        wait(for: [chimesOnce], timeout: 2)
        if observation != nil {
            observation = nil // See? Cancelled.
        }
    }
    
    func testIntervalChimeCancel() {
        let blueMoon = TimeDifference<Nanosecond, Era>.nanoseconds(1_000_000_000 / 12)
        let bellOfStJohn = expectation(description: "The bell rings twelve times")
        bellOfStJohn.expectedFulfillmentCount = 12
        let chime = clock.chime(every: blueMoon).sink { (result) in
            bellOfStJohn.fulfill()
        }
        
        wait(for: [bellOfStJohn], timeout: 2)
        // We get here after the 12th chime. This should halt our listener, and the expectation won't assert.
        chime.cancel()
    }
    
    func testPredicateChime() {
        // Set to the top of the hour
        let justBeforeNextHour = clock
            .nextHour().firstMinute.subtracting(minutes: 1).firstInstant
        let fastClock = Clock(startingFrom: justBeforeNextHour, rate: 3600) // an hour per second!
        
        let chimes = expectation(description: "Clock chimes five times in an hour")
        var expectedMins = [0, 13, 26, 39, 52]
        chimes.expectedFulfillmentCount = expectedMins.count
        // This should prove the example in the documentation.
        var observation: AnyCancellable? = fastClock
            .chime(when: { (time: Absolute<Minute>) in time.minute % 13 == 0 })
            .sink { (result) in
                let expected = expectedMins.removeFirst()
                let actual = result.minute
                XCTAssertEqual(actual, expected,
                               "Chime at *:\(actual) is \(actual - expected)m late (early if negative).")
                chimes.fulfill()
            }
        
        wait(for: [chimes], timeout: 2)
        if observation != nil {
            observation = nil
        }
    }
    
}
