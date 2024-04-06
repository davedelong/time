import Foundation
import XCTest
import Time

class WeekTests: XCTestCase {
    
    func testWeekContainingDay() throws {
        let d1 = try Fixed<Day>(region: .posix, year: 2024, month: 1, day: 1)
        let w1 = d1.fixedWeek
        let w1Days = Array(w1.days)
        XCTAssertEqual(w1Days.count, 7)
        XCTAssertTime(w1Days[0], era: 1, year: 2023, month: 12, day: 31)
        XCTAssertTime(w1Days[1], era: 1, year: 2024, month: 1, day: 1)
        XCTAssertTime(w1Days[2], era: 1, year: 2024, month: 1, day: 2)
        XCTAssertTime(w1Days[3], era: 1, year: 2024, month: 1, day: 3)
        XCTAssertTime(w1Days[4], era: 1, year: 2024, month: 1, day: 4)
        XCTAssertTime(w1Days[5], era: 1, year: 2024, month: 1, day: 5)
        XCTAssertTime(w1Days[6], era: 1, year: 2024, month: 1, day: 6)
    }
    
    func testCurrentWeek() throws {
        let d1 = try Fixed<Day>(region: .posix, year: 2024, month: 1, day: 1)
        let c = Clocks.custom(startingFrom: d1.firstInstant)
        let w1 = c.currentWeek
        let w1Days = Array(w1.days)
        XCTAssertEqual(w1Days.count, 7)
        XCTAssertTime(w1Days[0], era: 1, year: 2023, month: 12, day: 31)
        XCTAssertTime(w1Days[1], era: 1, year: 2024, month: 1, day: 1)
        XCTAssertTime(w1Days[2], era: 1, year: 2024, month: 1, day: 2)
        XCTAssertTime(w1Days[3], era: 1, year: 2024, month: 1, day: 3)
        XCTAssertTime(w1Days[4], era: 1, year: 2024, month: 1, day: 4)
        XCTAssertTime(w1Days[5], era: 1, year: 2024, month: 1, day: 5)
        XCTAssertTime(w1Days[6], era: 1, year: 2024, month: 1, day: 6)
    }
    
}
