//
//  File.swift
//

import Foundation
import XCTest
@testable import Time

@discardableResult
func XCTAssertEqualWithAccuracyWorkaround<FP: BinaryFloatingPoint>(_ value1: FP, _ value2: FP, accuracy: FP, file: StaticString = #file, line: UInt = #line) -> Bool {
    let halfRange = accuracy / 2.0
    let value1Range = (value1 - halfRange) ..< (value1 + halfRange)
    let value2Range = (value2 - halfRange) ..< (value2 + halfRange)
    
    let relation = value1Range.determineRelationship(to: value2Range)
    if relation.isOverlapping == false {
        XCTFail("\(value1) ≠ \(value2) with accuracy \(accuracy)", file: file, line: line)
        return false
    } else {
        return true
    }
}

@discardableResult
func XCTAssertTime<U: LTOEEra>(_ time: Fixed<U>, era: Int, file: StaticString = #file, line: UInt = #line) -> Bool {
    if time.era == era { return true }
    XCTFail("Unexpected time components: \(time), expecting era=\(era)", file: file, line: line)
    return false
}

@discardableResult
func XCTAssertTime<U: LTOEYear>(_ time: Fixed<U>, era: Int, year: Int, file: StaticString = #file, line: UInt = #line) -> Bool {
    if time.era == era && time.year == year { return true }
    XCTFail("Unexpected time components: \(time), expecting era=\(era), year=\(year)", file: file, line: line)
    return false
}

@discardableResult
func XCTAssertTime<U: LTOEMonth>(_ time: Fixed<U>, era: Int, year: Int, month: Int, file: StaticString = #file, line: UInt = #line) -> Bool {
    if time.era == era && time.year == year && time.month == month { return true }
    XCTFail("Unexpected time components: \(time), expecting era=\(era), year=\(year), month=\(month)", file: file, line: line)
    return false
}

@discardableResult
func XCTAssertTime<U: LTOEDay>(_ time: Fixed<U>, era: Int, year: Int, month: Int, day: Int, file: StaticString = #file, line: UInt = #line) -> Bool {
    if time.era == era && time.year == year && time.month == month && time.day == day { return true }
    XCTFail("Unexpected time components: \(time), expecting era=\(era), year=\(year), month=\(month), day=\(day)", file: file, line: line)
    return false
}

@discardableResult
func XCTAssertTime<U: LTOEHour>(_ time: Fixed<U>, era: Int, year: Int, month: Int, day: Int, hour: Int, file: StaticString = #file, line: UInt = #line) -> Bool {
    if time.era == era && time.year == year && time.month == month && time.day == day && time.hour == hour { return true }
    XCTFail("Unexpected time components: \(time), expecting era=\(era), year=\(year), month=\(month), day=\(day), hour=\(hour)", file: file, line: line)
    return false
}

@discardableResult
func XCTAssertTime<U: LTOEMinute>(_ time: Fixed<U>, era: Int, year: Int, month: Int, day: Int, hour: Int, minute: Int, file: StaticString = #file, line: UInt = #line) -> Bool {
    if time.era == era && time.year == year && time.month == month && time.day == day && time.hour == hour && time.minute == minute { return true }
    XCTFail("Unexpected time components: \(time), expecting era=\(era), year=\(year), month=\(month), day=\(day), hour=\(hour), minute=\(minute)", file: file, line: line)
    return false
}

@discardableResult
func XCTAssertTime<U: LTOESecond>(_ time: Fixed<U>, era: Int, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, file: StaticString = #file, line: UInt = #line) -> Bool {
    if time.era == era && time.year == year && time.month == month && time.day == day && time.hour == hour && time.minute == minute && time.second == second { return true }
    XCTFail("Unexpected time components: \(time), expecting era=\(era), year=\(year), month=\(month), day=\(day), hour=\(hour), minute=\(minute), second=\(second)", file: file, line: line)
    return false
}

@discardableResult
func XCTAssertTime<U: LTOENanosecond>(_ time: Fixed<U>, era: Int, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int, file: StaticString = #file, line: UInt = #line) -> Bool {
    if time.era == era && time.year == year && time.month == month && time.day == day && time.hour == hour && time.minute == minute && time.second == second && time.nanosecond == nanosecond { return true }
    XCTFail("Unexpected time components: \(time), expecting era=\(era), year=\(year), month=\(month), day=\(day), hour=\(hour), minute=\(minute), second=\(second), nanosecond=\(nanosecond)", file: file, line: line)
    return false
}
