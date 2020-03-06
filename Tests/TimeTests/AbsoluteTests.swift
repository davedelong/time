import XCTest
@testable import Time

class AbsoluteTests: XCTestCase {
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

    static var allTests = [
        ("testLastMonthOfYear", testLastMonthOfYear),
        ("testLastDayOfMonth", testLastDayOfMonth),
        ("testLastHourOfDay", testLastHourOfDay),
        ("testLastMinuteOfHour", testLastMinuteOfHour),
        ("testLastSecondOfMinute", testLastSecondOfMinute),
    ]
}
