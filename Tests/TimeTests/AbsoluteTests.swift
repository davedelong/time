import XCTest
@testable import Time

class AbsoluteTests: XCTestCase {

    static var allTests = [
        ("testInitializingGregorianDateWithoutEraSucceeds", testInitializingGregorianDateWithoutEraSucceeds),
        ("testInitializingGregorianDateWithEraSucceeds", testInitializingGregorianDateWithEraSucceeds),
        ("testInitializingJapaneseDateWithoutEraFails", testInitializingJapaneseDateWithoutEraFails),
        ("testInitializingJapaneseDateWithEraSucceeds", testInitializingJapaneseDateWithEraSucceeds),
        ("testLastMonthOfYear", testLastMonthOfYear),
        ("testLastDayOfMonth", testLastDayOfMonth),
        ("testLastHourOfDay", testLastHourOfDay),
        ("testLastMinuteOfHour", testLastMinuteOfHour),
        ("testLastSecondOfMinute", testLastSecondOfMinute),
    ]
    
    func testInitializingGregorianDateWithoutEraSucceeds() {
        XCTAssertNoThrow(try Absolute<Day>(region: .posix, year: 1970, month: 4, day: 1))
    }
    
    func testInitializingGregorianDateWithEraSucceeds() {
        XCTAssertNoThrow(try Absolute<Day>(region: .posix, era: 1, year: 1970, month: 4, day: 1))
    }
    
    func testInitializingJapaneseDateWithoutEraFails() {
        let japaneseRegion = Region(calendar: Calendar(identifier: .japanese), timeZone: Region.posix.timeZone, locale: Region.posix.locale)
        XCTAssertThrowsError(try Absolute<Day>(region: japaneseRegion, year: 2, month: 3, day: 6))
    }
    
    func testInitializingJapaneseDateWithEraSucceeds() {
        let japaneseRegion = Region(calendar: Calendar(identifier: .japanese), timeZone: Region.posix.timeZone, locale: Region.posix.locale)
        // March 6, Reiwa 2
        XCTAssertNoThrow(try Absolute<Day>(region: japaneseRegion, era: 236, year: 2, month: 3, day: 6))
    }
    
    func testLastMonthOfYear() {
        
        let year = try! Absolute<Year>(region: .posix, era: 1, year: 2020)
        let lastMonth = year.lastMonth()
        let expectedlastMonth = try! Absolute<Month>(region: .posix, era:1, year: 2020, month: 12)

        XCTAssertEqual(lastMonth, expectedlastMonth)
    }

    func testLastDayOfMonth() {
        
        let month = try! Absolute<Month>(region: .posix, era: 1, year: 2020, month: 2)
        let lastDay = month.lastDay()
        let expectedLastDay = try! Absolute<Day>(region: .posix, era:1, year: 2020, month: 2, day: 29)

        XCTAssertEqual(lastDay, expectedLastDay)
    }

    func testLastHourOfDay() {
        
        let day = try! Absolute<Day>(region: .posix, era: 1, year: 2020, month: 2, day: 29)
        let lastHour = day.lastHour()
        let expectedlastHour = try! Absolute<Hour>(region: .posix, era:1, year: 2020, month: 2, day: 29, hour: 23)

        XCTAssertEqual(lastHour, expectedlastHour)
    }

    func testLastMinuteOfHour() {
        
        let hour = try! Absolute<Hour>(region: .posix, era: 1, year: 2020, month: 2, day: 29, hour: 13)
        let lastMinute = hour.lastMinute()
        let expectedlastMinute = try! Absolute<Minute>(region: .posix, era:1, year: 2020, month: 2, day: 29, hour: 13, minute: 59)

        XCTAssertEqual(lastMinute, expectedlastMinute)
    }

    func testLastSecondOfMinute() {
        
        let minute = try! Absolute<Minute>(region: .posix, era: 1, year: 2020, month: 2, day: 29, hour: 13, minute: 31)
        let lastSecond = minute.lastSecond()
        let expectedlastSecond = try! Absolute<Second>(region: .posix, era:1, year: 2020, month: 2, day: 29, hour: 13, minute: 31, second: 59)

        XCTAssertEqual(lastSecond, expectedlastSecond)
    }
}
