import XCTest
@testable import Time

class NumberedValueTests: XCTestCase {
    func testFirstNumberedValues() throws {
        let year = try Fixed(region: .posix, year: 2024)
        let month = try Fixed(region: .posix, year: 2024, month: 2)
        let day = try Fixed(region: .posix, year: 2024, month: 2, day: 29)
        let hour = try Fixed(region: .posix, year: 2024, month: 2, day: 29, hour: 12)
        let minute = try Fixed(region: .posix, year: 2024, month: 2, day: 29, hour: 12, minute: 30)

        XCTAssertEqual(year.month(1), year.firstMonth)
        XCTAssertEqual(month.day(1), month.firstDay)
        XCTAssertEqual(day.hour(0), day.firstHour)
        XCTAssertEqual(day.hour(1)?.hour, 1)
        XCTAssertEqual(hour.minute(0), hour.firstMinute)
        XCTAssertEqual(minute.second(0), minute.firstSecond)
    }

    func testMissingNumberedValuesStayWithinParent() throws {
        let month = try Fixed(region: .posix, year: 2024, month: 2)
        let day = try Fixed(region: .posix, year: 2024, month: 2, day: 29)

        XCTAssertNil(month.day(0))
        XCTAssertNil(month.day(30))
        XCTAssertNil(day.hour(24))
    }

    func testNumberedHoursAcrossDST() throws {
        let region = Region.posix.setTimeZone(TimeZone(identifier: "America/Los_Angeles")!)
        let spring = try Fixed(region: region, year: 2024, month: 3, day: 10)
        let fall = try Fixed(region: region, year: 2024, month: 11, day: 3)

        XCTAssertEqual(spring.hour(0), spring.firstHour)
        XCTAssertNil(spring.hour(2))
        XCTAssertEqual(spring.hour(3)?.hour, 3)
        XCTAssertEqual(spring.hour(23), spring.lastHour)
        XCTAssertEqual(fall.hour(0), fall.firstHour)
        XCTAssertEqual(fall.hour(1)?.hour, 1)
        XCTAssertEqual(fall.hour(23), fall.lastHour)
    }
}
