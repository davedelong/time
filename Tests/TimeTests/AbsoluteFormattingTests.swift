//
//  AbsoluteFormattingTests.swift
//  
//
//  Created by Dave DeLong on 4/11/20.
//

import XCTest
import Time

class AbsoluteFormattingTests: XCTestCase {
    
    static var allTests = [
        ("testEraFormatting", testEraFormatting),
        ("testYearFormatting", testYearFormatting),
        ("testMonthFormatting", testMonthFormatting),
        ("testDayFormatting", testDayFormatting),
        ("testRawFormatting_Strict", testRawFormatting_Strict),
        ("testRawFormatting_Lenient", testRawFormatting_Lenient),
    ]
    
    // create a clock that starts at the first instant of the reference era
    // the slow rate is just to make sure that small units (seconds, etc) don't move faster than
    // the unit tests can reasonably handle
    let clock = Clocks.custom(startingFrom: Instant(interval: 0, since: .reference), rate: 0.001, region: .posix)
    
    func testEraFormatting() {
        let v = clock.thisEra()
        
        XCTAssertEqual(v.format(era: .wide), "Anno Domini")
        XCTAssertEqual(v.format(era: .abbreviated), "AD")
        XCTAssertEqual(v.format(era: .narrow), "A")
    }
    
    func testYearFormatting() {
        let v = clock.thisYear()
        
        XCTAssertEqual(v.format(year: .full), "2001")
        XCTAssertEqual(v.format(year: .twoDigits), "01")
        XCTAssertEqual(v.format(year: .digits(paddedToLength: 5)), "02001")
        
        XCTAssertEqual(v.format(era: .abbreviated, year: .full), "2001 AD")
        XCTAssertEqual(v.format(era: .abbreviated, year: .twoDigits), "01 AD")
        XCTAssertEqual(v.format(era: .wide, year: .digits(paddedToLength: 5)), "02001 Anno Domini")
    }
    
    func testMonthFormatting() {
        let v = clock.thisMonth()
        
        XCTAssertEqual(v.format(month: .fullName), "January")
        XCTAssertEqual(v.format(month: .abbreviatedName), "Jan")
        XCTAssertEqual(v.format(month: .narrowName), "J")
        XCTAssertEqual(v.format(month: .fullDigits), "1")
        XCTAssertEqual(v.format(month: .twoDigits), "01")
        
        XCTAssertEqual(v.format(year: .full, month: .fullName), "January 2001")
        XCTAssertEqual(v.format(year: .full, month: .abbreviatedName), "Jan 2001")
        XCTAssertEqual(v.format(year: .full, month: .narrowName), "J 2001")
        XCTAssertEqual(v.format(year: .full, month: .fullDigits), "1/2001")
        XCTAssertEqual(v.format(year: .full, month: .twoDigits), "01/2001")
        
        XCTAssertEqual(v.format(era: .abbreviated, year: .full, month: .fullName), "January 2001 AD")
        XCTAssertEqual(v.format(era: .abbreviated, year: .full, month: .abbreviatedName), "Jan 2001 AD")
        XCTAssertEqual(v.format(era: .abbreviated, year: .full, month: .narrowName), "J 2001 AD")
        XCTAssertEqual(v.format(era: .abbreviated, year: .full, month: .fullDigits), "1 2001 AD")
        XCTAssertEqual(v.format(era: .abbreviated, year: .full, month: .twoDigits), "01 2001 AD")
    }
    
    func testDayFormatting() {
        let v = clock.thisDay()
        
        XCTAssertEqual(v.format(weekday: .fullName), "Monday")
        XCTAssertEqual(v.format(weekday: .abbreviatedName), "Mon")
        XCTAssertEqual(v.format(weekday: .shortName), "Mo")
        XCTAssertEqual(v.format(weekday: .narrowName), "M")
        
        XCTAssertEqual(v.format(day: .full), "1")
        XCTAssertEqual(v.format(day: .twoDigits), "01")
        
        XCTAssertEqual(v.format(month: .fullName, day: .full), "January 1")
        XCTAssertEqual(v.format(month: .fullName, day: .twoDigits), "January 01")
        
        XCTAssertEqual(v.format(year: .full, month: .fullName, day: .full), "January 1, 2001")
        XCTAssertEqual(v.format(year: .full, month: .fullName, day: .twoDigits), "January 01, 2001")
        
        XCTAssertEqual(v.format(era: .abbreviated, year: .full, month: .fullName, day: .full), "January 1, 2001 AD")
        XCTAssertEqual(v.format(era: .abbreviated, year: .full, month: .fullName, day: .twoDigits), "January 01, 2001 AD")
        
        XCTAssertEqual(v.format(year: .full, month: .fullName, day: .full, weekday: .fullName), "Monday, January 1, 2001")
        XCTAssertEqual(v.format(year: .full, month: .fullName, day: .twoDigits, weekday: .fullName), "Monday, January 01, 2001")
        
        XCTAssertEqual(v.format(date: .full), "Monday, January 1, 2001")
    }
    
    func testRawFormatting_Strict() {
        let v = clock.thisMonth()
        
        XCTAssertNoThrow(try v.format(using: "yyyy"), "This should not throw")
        XCTAssertNoThrow(try v.format(using: "y-MM"), "This should not throw")
        XCTAssertNoThrow(try v.format(using: "y-MM Q"), "This should not throw")
        XCTAssertNoThrow(try v.format(using: "y-MM 'some literal stuff'"), "This should not throw")
        
        XCTAssertThrowsError(try v.format(using: "y-MM-dd"), "This should have thrown")
        XCTAssertThrowsError(try v.format(using: "y-MM HH"), "This should have thrown")
        XCTAssertThrowsError(try v.format(using: "y-MM mm"), "This should have thrown")
        XCTAssertThrowsError(try v.format(using: "y-MM ss"), "This should have thrown")
        XCTAssertThrowsError(try v.format(using: "y-MM SSSSSS"), "This should have thrown")
    }
    
    func testRawFormatting_Lenient() {
        let v = clock.thisMonth()
        
        XCTAssertEqual(try v.format(using: "y-MM-dd", strict: false), "2001-01-01")
        XCTAssertEqual(try v.format(using: "y-MM-dd 'at' HH:mm:ss", strict: false), "2001-01-01 at 00:00:00")
    }
    
}
