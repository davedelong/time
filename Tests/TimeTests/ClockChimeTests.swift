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
        ("testImmediateChime", testImmediateChime),
        ("testChimeAtSpecificValue", testChimeAtSpecificValue),
        ("testScaledChimeAtSpecificValue", testScaledChimeAtSpecificValue),
    ]
    
    var clock: Clock!
    
    override func setUp() {
        clock = Clock()
    }
    
    func testImmediateChime() {
        let chimesOnce = expectation(description: "Clock chimes in just two seconds")
        let completes = expectation(description: "Chime completes")
        let now = clock.thisNanosecond()
        
        var observation: AnyCancellable? = clock
            .chime(at: now)
            .sink(
                receiveCompletion: { (completion) in
                    completes.fulfill()
                },
                receiveValue: { (result) in
                    XCTAssertEqual(result.firstInstant.intervalSinceEpoch.rawValue,
                                   now.firstInstant.intervalSinceEpoch.rawValue,
                                   accuracy: 0.005)
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
    
    func testChimeAtSpecificValue() {
        let chimesOnce = expectation(description: "Clock chimes in just two seconds")
        let completes = expectation(description: "Chime completes")
        let seconds: Int = 2
        let xSecondsFromNow = clock.thisNanosecond().adding(seconds: seconds)
        
        var observation: AnyCancellable? = clock
            .chime(at: xSecondsFromNow)
            .sink(
                receiveCompletion: { (completion) in
                    completes.fulfill()
                },
                receiveValue: { (result) in
                    XCTAssertEqual(result.firstInstant.intervalSinceEpoch.rawValue,
                                   xSecondsFromNow.firstInstant.intervalSinceEpoch.rawValue,
                                   accuracy: 0.005)
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
    
    func testScaledChimeAtSpecificValue() {
        let chimesOnce = expectation(description: "Clock chimes in just two seconds")
        let completes = expectation(description: "Chime completes")
        let seconds: Int = 2
        let rate: Double = 2.0
        let clock = Clock(startingFrom: .reference, rate: rate)
        let xScaledSeconds = clock.thisNanosecond().adding(seconds: seconds)
        
        var observation: AnyCancellable? = clock
            .chime(at: xScaledSeconds)
            .sink(
                receiveCompletion: { (completion) in
                    completes.fulfill()
                },
                receiveValue: { (result) in
                    XCTAssertEqual(result.firstInstant.intervalSinceEpoch.rawValue,
                                   xScaledSeconds.firstInstant.intervalSinceEpoch.rawValue,
                                   accuracy: 0.01) // Accuracy is a tad screwy with scaled seconds
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
    
}
