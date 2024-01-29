import XCTest
@testable import Time

class FixedTests: XCTestCase {

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
        ("testAddingComponents", testAddingComponents),
    ]
    
    func testInitializingGregorianDateWithoutEraSucceeds() {
        XCTAssertNoThrow(try Fixed<Day>(region: .posix, year: 1970, month: 4, day: 1))
    }
    
    func testInitializingGregorianDateWithEraSucceeds() {
        XCTAssertNoThrow(try Fixed<Day>(region: .posix, era: 1, year: 1970, month: 4, day: 1))
    }
    
    func testInitializingJapaneseDateWithoutEraFails() {
        let japaneseRegion = Region(calendar: Calendar(identifier: .japanese), timeZone: Region.posix.timeZone, locale: Region.posix.locale)
        XCTAssertThrowsError(try Fixed<Day>(region: japaneseRegion, year: 2, month: 3, day: 6))
    }
    
    func testInitializingJapaneseDateWithEraSucceeds() {
        let japaneseRegion = Region(calendar: Calendar(identifier: .japanese), timeZone: Region.posix.timeZone, locale: Region.posix.locale)
        // March 6, Reiwa 2
        XCTAssertNoThrow(try Fixed<Day>(region: japaneseRegion, era: 236, year: 2, month: 3, day: 6))
    }
    
    func testLastMonthOfYear() {
        
        let year = try! Fixed<Year>(region: .posix, era: 1, year: 2020)
        let lastMonth = year.lastMonth
        let expectedlastMonth = try! Fixed<Month>(region: .posix, era:1, year: 2020, month: 12)

        XCTAssertEqual(lastMonth, expectedlastMonth)
    }

    func testLastDayOfMonth() {
        
        let month = try! Fixed<Month>(region: .posix, era: 1, year: 2020, month: 2)
        let lastDay = month.lastDay
        let expectedLastDay = try! Fixed<Day>(region: .posix, era:1, year: 2020, month: 2, day: 29)

        XCTAssertEqual(lastDay, expectedLastDay)
    }

    func testLastHourOfDay() {
        
        let day = try! Fixed<Day>(region: .posix, era: 1, year: 2020, month: 2, day: 29)
        let lastHour = day.lastHour
        let expectedlastHour = try! Fixed<Hour>(region: .posix, era:1, year: 2020, month: 2, day: 29, hour: 23)

        XCTAssertEqual(lastHour, expectedlastHour)
    }

    func testLastMinuteOfHour() {
        
        let hour = try! Fixed<Hour>(region: .posix, era: 1, year: 2020, month: 2, day: 29, hour: 13)
        let lastMinute = hour.lastMinute
        let expectedlastMinute = try! Fixed<Minute>(region: .posix, era:1, year: 2020, month: 2, day: 29, hour: 13, minute: 59)

        XCTAssertEqual(lastMinute, expectedlastMinute)
    }

    func testLastSecondOfMinute() {
        
        let minute = try! Fixed<Minute>(region: .posix, era: 1, year: 2020, month: 2, day: 29, hour: 13, minute: 31)
        let lastSecond = minute.lastSecond
        let expectedlastSecond = try! Fixed<Second>(region: .posix, era:1, year: 2020, month: 2, day: 29, hour: 13, minute: 31, second: 59)

        XCTAssertEqual(lastSecond, expectedlastSecond)
    }
    
    func testAddingComponents() throws {
        let today: Fixed<Day> = Clocks.system.today
        let todayAt12: Fixed<Minute> = try today.setting(hour: 12, minute: 00)
        
        XCTAssertEqual(todayAt12.fixedDay, today)
        XCTAssertEqual(todayAt12.hour, 12)
        XCTAssertEqual(todayAt12.minute, 0)
    }
}
