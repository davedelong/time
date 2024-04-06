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
        
        let prevWeek = c.previousWeek
        let prevDays = Array(prevWeek.days)
        XCTAssertEqual(prevDays.count, 7)
        XCTAssertTime(prevDays[0], era: 1, year: 2023, month: 12, day: 24)
        XCTAssertTime(prevDays[1], era: 1, year: 2023, month: 12, day: 25)
        XCTAssertTime(prevDays[2], era: 1, year: 2023, month: 12, day: 26)
        XCTAssertTime(prevDays[3], era: 1, year: 2023, month: 12, day: 27)
        XCTAssertTime(prevDays[4], era: 1, year: 2023, month: 12, day: 28)
        XCTAssertTime(prevDays[5], era: 1, year: 2023, month: 12, day: 29)
        XCTAssertTime(prevDays[6], era: 1, year: 2023, month: 12, day: 30)
        
        let w1 = c.currentWeek
        let currDays = Array(w1.days)
        XCTAssertEqual(currDays.count, 7)
        XCTAssertTime(currDays[0], era: 1, year: 2023, month: 12, day: 31)
        XCTAssertTime(currDays[1], era: 1, year: 2024, month: 1, day: 1)
        XCTAssertTime(currDays[2], era: 1, year: 2024, month: 1, day: 2)
        XCTAssertTime(currDays[3], era: 1, year: 2024, month: 1, day: 3)
        XCTAssertTime(currDays[4], era: 1, year: 2024, month: 1, day: 4)
        XCTAssertTime(currDays[5], era: 1, year: 2024, month: 1, day: 5)
        XCTAssertTime(currDays[6], era: 1, year: 2024, month: 1, day: 6)
        
        let nextWeek = c.nextWeek
        let nextDays = Array(nextWeek.days)
        XCTAssertEqual(nextDays.count, 7)
        XCTAssertTime(nextDays[0], era: 1, year: 2024, month: 1, day: 7)
        XCTAssertTime(nextDays[1], era: 1, year: 2024, month: 1, day: 8)
        XCTAssertTime(nextDays[2], era: 1, year: 2024, month: 1, day: 9)
        XCTAssertTime(nextDays[3], era: 1, year: 2024, month: 1, day: 10)
        XCTAssertTime(nextDays[4], era: 1, year: 2024, month: 1, day: 11)
        XCTAssertTime(nextDays[5], era: 1, year: 2024, month: 1, day: 12)
        XCTAssertTime(nextDays[6], era: 1, year: 2024, month: 1, day: 13)
    }
    
}