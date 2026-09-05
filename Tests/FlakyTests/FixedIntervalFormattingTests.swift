import XCTest
@testable import Time
import TestSupport

class FixedIntervalFormattingTests: XCTestCase {
    
    static let allTests = [
        ("testEraFormatting", testEraFormatting),
        ("testYearFormatting", testYearFormatting),
        ("testMonthFormatting", testMonthFormatting),
        ("testDayFormatting", testDayFormatting),
    ]
    
    // create a clock that starts at the first instant of the reference era
    // the slow rate is just to make sure that small units (seconds, etc) don't move faster than
    // the unit tests can reasonably handle
    let clock = Clocks.custom(startingFrom: Instant(interval: 0, since: .reference), rate: 0.001, region: .posix)
    
    func testEraFormatting() {
        // use the japanese calendar, because the gregorian calendar doesn't like dealing with BC dates
        let clock = self.clock.converted(to: Calendar(identifier: .japanese))
        let b = clock.currentEra
        let a = b.previous
        
        XCTAssertEqual((a ..< b).format(using: .era(.wide)), "Shōwa – Heisei")
        XCTAssertEqual((a ..< b).format(using: .era(.abbreviated)), "Shōwa – Heisei")
        XCTAssertEqual((a ..< b).format(using: .era(.narrow)), "S – H")
    }
    
    func testYearFormatting() {
        let a = clock.previousYear
        let b = clock.currentYear
        
        XCTAssertEqual((a ..< b).format(using: .year(.naturalDigits)), "2000 – 2001")
        XCTAssertEqual((a ..< b).format(using: .year(.twoDigits)), "00 – 01")
        XCTAssertEqual((a ..< b).format(using: .year(.digits(paddedToLength: 5))), "02000 – 02001")
        
        XCTAssertEqual((a ..< b).format(using: .era(.abbreviated, year: .naturalDigits)), "2000 – 2001 AD")
        XCTAssertEqual((a ..< b).format(using: .era(.abbreviated, year: .twoDigits)), "00 – 01 AD")
        XCTAssertEqual((a ..< b).format(using: .era(.wide, year: .digits(paddedToLength: 5))), "02000 – 02001 Anno Domini")
    }
    
    func testMonthFormatting() {
        let a = clock.previousMonth
        let b = clock.currentMonth
        
        XCTAssertEqual((a ..< b).format(using: .month(.naturalName)), "December – January")
        XCTAssertEqual((a ..< b).format(using: .month(.abbreviatedName)), "Dec – Jan")
        XCTAssertEqual((a ..< b).format(using: .month(.narrowName)), "D – J")
        XCTAssertEqual((a ..< b).format(using: .month(.naturalDigits)), "12 – 1")
        XCTAssertEqual((a ..< b).format(using: .month(.twoDigits)), "12 – 01")
        
        XCTAssertEqual((a ..< b).format(using: .year(.naturalDigits, month: .naturalName)), "December 2000 – January 2001")
        XCTAssertEqual((a ..< b).format(using: .year(.naturalDigits, month: .abbreviatedName)), "Dec 2000 – Jan 2001")
        XCTAssertEqual((a ..< b).format(using: .year(.naturalDigits, month: .narrowName)), "D 2000 – J 2001")
        XCTAssertEqual((a ..< b).format(using: .year(.naturalDigits, month: .naturalDigits)), "12/2000 – 1/2001")
        XCTAssertEqual((a ..< b).format(using: .year(.naturalDigits, month: .twoDigits)), "12/2000 – 01/2001")
        
        XCTAssertEqual((a ..< b).format(using: .era(.abbreviated, year: .naturalDigits, month: .naturalName)), "December 2000 – January 2001 AD")
        XCTAssertEqual((a ..< b).format(using: .era(.abbreviated, year: .naturalDigits, month: .abbreviatedName)), "Dec 2000 – Jan 2001 AD")
        XCTAssertEqual((a ..< b).format(using: .era(.abbreviated, year: .naturalDigits, month: .narrowName)), "D 2000 – J 2001 AD")
        XCTAssertEqual((a ..< b).format(using: .era(.abbreviated, year: .naturalDigits, month: .naturalDigits)), "12/2000 – 1/2001 AD")
        XCTAssertEqual((a ..< b).format(using: .era(.abbreviated, year: .naturalDigits, month: .twoDigits)), "12/2000 – 01/2001 AD")
    }
    
    func testDayFormatting() {
        let a = clock.previousDay
        let b = clock.currentDay
        
        XCTAssertEqual((a ..< b).format(using: .weekday(.naturalName)), "Sunday – Monday")
        XCTAssertEqual((a ..< b).format(using: .weekday(.abbreviatedName)), "Sun – Mon")
        XCTAssertEqual((a ..< b).format(using: .weekday(.shortName)), "Su – Mo")
        XCTAssertEqual((a ..< b).format(using: .weekday(.narrowName)), "S – M")
        
        XCTAssertEqual((a ..< b).format(using: .day(.naturalDigits)), "31 – 1")
        XCTAssertEqual((a ..< b).format(using: .day(.twoDigits)), "31 – 01")
        
        XCTAssertEqual((a ..< b).format(using: .month(.naturalName, day: .naturalDigits)), "December 31 – January 1")
        XCTAssertEqual((a ..< b).format(using: .month(.naturalName, day: .twoDigits)), "December 31 – January 01")
        
        XCTAssertEqual((a ..< b).format(using: .year(.naturalDigits, month: .naturalName, day: .naturalDigits)), "December 31, 2000 – January 1, 2001")
        XCTAssertEqual((a ..< b).format(using: .year(.naturalDigits, month: .naturalName, day: .twoDigits)), "December 31, 2000 – January 01, 2001")
        
        XCTAssertEqual((a ..< b).format(using: .era(.abbreviated, year: .naturalDigits, month: .naturalName, day: .naturalDigits)), "December 31, 2000 – January 1, 2001 AD")
        XCTAssertEqual((a ..< b).format(using: .era(.abbreviated, year: .naturalDigits, month: .naturalName, day: .twoDigits)), "December 31, 2000 – January 01, 2001 AD")
        
        XCTAssertEqual((a ..< b).format(using: .year(.naturalDigits, month: .naturalName, day: .naturalDigits, weekday: .naturalName)), "Sunday, December 31, 2000 – Monday, January 1, 2001")
        XCTAssertEqual((a ..< b).format(using: .year(.naturalDigits, month: .naturalName, day: .twoDigits, weekday: .naturalName)), "Sunday, December 31, 2000 – Monday, January 01, 2001")
        
        XCTAssertEqual((a ..< b).format(using: .date(.full)), "Sunday, December 31, 2000 – Monday, January 1, 2001")
    }
    
}
