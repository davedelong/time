import XCTest
@testable import Time

class WeekdayAdjustmentTests: XCTestCase {
    func testNextSaturday() throws {
        let thursday = try Fixed(region: .posix, year: 2024, month: 2, day: 29)
        let saturday = try Fixed(region: .posix, year: 2024, month: 3, day: 2)

        XCTAssertEqual(thursday.next(dayOfWeek: 7), saturday)
        XCTAssertEqual(saturday.next(dayOfWeek: 7), saturday.adding(days: 7))
    }

    func testNextWeekdayAcrossWeekBoundary() throws {
        let saturday = try Fixed(region: .posix, year: 2024, month: 3, day: 2)

        XCTAssertEqual(saturday.next(dayOfWeek: 1), saturday.nextDay)
        XCTAssertEqual(saturday.next(dayOfWeek: 6), saturday.adding(days: 6))
    }
}
