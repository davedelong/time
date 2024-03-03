import XCTest
@testable import Time

class FixedFormattingTests: XCTestCase {
    
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
        let v = clock.currentEra
        
        XCTAssertEqual(v.format(era: .wide), "Anno Domini")
        XCTAssertEqual(v.format(era: .abbreviated), "AD")
        XCTAssertEqual(v.format(era: .narrow), "A")
    }
    
    func testYearFormatting() {
        let v = clock.currentYear
        
        XCTAssertEqual(v.format(year: .naturalDigits), "2001")
        XCTAssertEqual(v.format(year: .twoDigits), "01")
        XCTAssertEqual(v.format(year: .digits(paddedToLength: 5)), "02001")
        
        XCTAssertEqual(v.format(era: .abbreviated, year: .naturalDigits), "2001 AD")
        XCTAssertEqual(v.format(era: .abbreviated, year: .twoDigits), "01 AD")
        XCTAssertEqual(v.format(era: .wide, year: .digits(paddedToLength: 5)), "02001 Anno Domini")
    }
    
    func testMonthFormatting() {
        let v = clock.currentMonth
        
        XCTAssertEqual(v.format(month: .naturalName), "January")
        XCTAssertEqual(v.format(month: .abbreviatedName), "Jan")
        XCTAssertEqual(v.format(month: .narrowName), "J")
        XCTAssertEqual(v.format(month: .naturalDigits), "1")
        XCTAssertEqual(v.format(month: .twoDigits), "01")
        
        XCTAssertEqual(v.format(year: .naturalDigits, month: .naturalName), "January 2001")
        XCTAssertEqual(v.format(year: .naturalDigits, month: .abbreviatedName), "Jan 2001")
        XCTAssertEqual(v.format(year: .naturalDigits, month: .narrowName), "J 2001")
        XCTAssertEqual(v.format(year: .naturalDigits, month: .naturalDigits), "1/2001")
        XCTAssertEqual(v.format(year: .naturalDigits, month: .twoDigits), "01/2001")
        
        XCTAssertEqual(v.format(era: .abbreviated, year: .naturalDigits, month: .naturalName), "January 2001 AD")
        XCTAssertEqual(v.format(era: .abbreviated, year: .naturalDigits, month: .abbreviatedName), "Jan 2001 AD")
        XCTAssertEqual(v.format(era: .abbreviated, year: .naturalDigits, month: .narrowName), "J 2001 AD")
        XCTAssertEqual(v.format(era: .abbreviated, year: .naturalDigits, month: .naturalDigits), "1 2001 AD")
        XCTAssertEqual(v.format(era: .abbreviated, year: .naturalDigits, month: .twoDigits), "01 2001 AD")
    }
    
    func testDayFormatting() {
        let v = clock.currentDay
        
        XCTAssertEqual(v.format(weekday: .naturalName), "Monday")
        XCTAssertEqual(v.format(weekday: .abbreviatedName), "Mon")
        XCTAssertEqual(v.format(weekday: .shortName), "Mo")
        XCTAssertEqual(v.format(weekday: .narrowName), "M")
        
        XCTAssertEqual(v.format(day: .naturalDigits), "1")
        XCTAssertEqual(v.format(day: .twoDigits), "01")
        
        XCTAssertEqual(v.format(month: .naturalName, day: .naturalDigits), "January 1")
        XCTAssertEqual(v.format(month: .naturalName, day: .twoDigits), "January 01")
        
        XCTAssertEqual(v.format(year: .naturalDigits, month: .naturalName, day: .naturalDigits), "January 1, 2001")
        XCTAssertEqual(v.format(year: .naturalDigits, month: .naturalName, day: .twoDigits), "January 01, 2001")
        
        XCTAssertEqual(v.format(era: .abbreviated, year: .naturalDigits, month: .naturalName, day: .naturalDigits), "January 1, 2001 AD")
        XCTAssertEqual(v.format(era: .abbreviated, year: .naturalDigits, month: .naturalName, day: .twoDigits), "January 01, 2001 AD")
        
        XCTAssertEqual(v.format(year: .naturalDigits, month: .naturalName, day: .naturalDigits, weekday: .naturalName), "Monday, January 1, 2001")
        XCTAssertEqual(v.format(year: .naturalDigits, month: .naturalName, day: .twoDigits, weekday: .naturalName), "Monday, January 01, 2001")
        
        XCTAssertEqual(v.format(date: .full), "Monday, January 1, 2001")
    }
    
    func testRawFormatting_Strict() {
        let v = clock.currentMonth
        
        XCTAssertNoThrow(try v.format(raw: "yyyy"), "This should not throw")
        XCTAssertNoThrow(try v.format(raw: "y-MM"), "This should not throw")
        XCTAssertNoThrow(try v.format(raw: "y-MM Q"), "This should not throw")
        XCTAssertNoThrow(try v.format(raw: "y-MM 'some literal stuff'"), "This should not throw")
        
        XCTAssertThrowsError(try v.format(raw: "y-MM-dd"), "This should have thrown")
        XCTAssertThrowsError(try v.format(raw: "y-MM HH"), "This should have thrown")
        XCTAssertThrowsError(try v.format(raw: "y-MM mm"), "This should have thrown")
        XCTAssertThrowsError(try v.format(raw: "y-MM ss"), "This should have thrown")
        XCTAssertThrowsError(try v.format(raw: "y-MM SSSSSS"), "This should have thrown")
        
        XCTAssertThrowsError(try v.format(raw: "y-MM 't"), "This should have thrown")
    }
    
    func testRawFormatting_Lenient() {
        let v = clock.currentMonth
        
        XCTAssertEqual(try v.format(raw: "y-MM-dd", strict: false), "2001-01-01")
        XCTAssertEqual(try v.format(raw: "y-MM-dd 'at' HH:mm:ss", strict: false), "2001-01-01 at 00:00:00")
    }
    
    func testOmittedTimeZoneInDescription() throws {
        let fixedNano = try Fixed(region: .posix,
                                  year: 2024, month: 3, day: 3,
                                  hour: 10, minute: 12, second: 24, nanosecond: 500_000_000)
        
        // these values have time of day components,
        // therefore they should show the time zone
        let fixedSecond = fixedNano.fixedSecond
        let fixedMinute = fixedNano.fixedMinute
        let fixedHour = fixedNano.fixedHour
        
        XCTAssertTrue(fixedNano.description.hasSuffix(" GMT"))
        XCTAssertTrue(fixedSecond.description.hasSuffix(" GMT"))
        XCTAssertTrue(fixedMinute.description.hasSuffix(" GMT"))
        XCTAssertTrue(fixedHour.description.hasSuffix(" GMT"))
        
        // these values do not have time of day components,
        // therefore they should not show the time zone
        let fixedDay = fixedNano.fixedDay
        let fixedMonth = fixedNano.fixedMonth
        let fixedYear = fixedNano.fixedYear
        let fixedEra = fixedNano.fixedEra
        
        XCTAssertFalse(fixedDay.description.hasSuffix(" GMT"))
        XCTAssertFalse(fixedMonth.description.hasSuffix(" GMT"))
        XCTAssertFalse(fixedYear.description.hasSuffix(" GMT"))
        XCTAssertFalse(fixedEra.description.hasSuffix(" GMT"))
    }
    
}
