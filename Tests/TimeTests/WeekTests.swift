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
    
    func testWeekAdjustment() throws {
        let d1 = try Fixed<Day>(region: .posix, year: 2024, month: 1, day: 1)
        let c = Clocks.custom(startingFrom: d1.firstInstant)
        
        let w1 = c.currentWeek
        
        let w2 = w1 + .weeks(3)
        let w2Days = Array(w2.days)
        XCTAssertEqual(w2Days.count, 7)
        XCTAssertTime(w2Days[0], era: 1, year: 2024, month: 1, day: 21)
        XCTAssertTime(w2Days[1], era: 1, year: 2024, month: 1, day: 22)
        XCTAssertTime(w2Days[2], era: 1, year: 2024, month: 1, day: 23)
        XCTAssertTime(w2Days[3], era: 1, year: 2024, month: 1, day: 24)
        XCTAssertTime(w2Days[4], era: 1, year: 2024, month: 1, day: 25)
        XCTAssertTime(w2Days[5], era: 1, year: 2024, month: 1, day: 26)
        XCTAssertTime(w2Days[6], era: 1, year: 2024, month: 1, day: 27)
        
        let w3 = w2.offset(by: -1)
        let w3Days = Array(w3.days)
        XCTAssertEqual(w3Days.count, 7)
        XCTAssertTime(w3Days[0], era: 1, year: 2024, month: 1, day: 14)
        XCTAssertTime(w3Days[1], era: 1, year: 2024, month: 1, day: 15)
        XCTAssertTime(w3Days[2], era: 1, year: 2024, month: 1, day: 16)
        XCTAssertTime(w3Days[3], era: 1, year: 2024, month: 1, day: 17)
        XCTAssertTime(w3Days[4], era: 1, year: 2024, month: 1, day: 18)
        XCTAssertTime(w3Days[5], era: 1, year: 2024, month: 1, day: 19)
        XCTAssertTime(w3Days[6], era: 1, year: 2024, month: 1, day: 20)
    }
    
    func testFirstAndLastDays() throws {
        let d1 = try Fixed<Day>(region: .posix, year: 2024, month: 1, day: 1)
        let c = Clocks.custom(startingFrom: d1.firstInstant)
        
        let w1 = c.currentWeek
        
        XCTAssertTime(w1.firstDay, era: 1, year: 2023, month: 12, day: 31)
        XCTAssertTime(w1.lastDay, era: 1, year: 2024, month: 1, day: 6)
    }
    
    func testWeeksOfMonth() throws {
        let m1 = try Fixed<Month>(region: .posix, year: 2024, month: 1)
        XCTAssertThrowsError(try m1.nthWeek(0))
        
        let w1 = try m1.nthWeek(1)
        XCTAssertTime(w1.firstDay, era: 1, year: 2023, month: 12, day: 31)
        XCTAssertTime(w1.lastDay, era: 1, year: 2024, month: 1, day: 6)
        
        let w2 = try m1.nthWeek(2)
        XCTAssertTime(w2.firstDay, era: 1, year: 2024, month: 1, day: 7)
        XCTAssertTime(w2.lastDay, era: 1, year: 2024, month: 1, day: 13)
        
        let w3 = try m1.nthWeek(3)
        XCTAssertTime(w3.firstDay, era: 1, year: 2024, month: 1, day: 14)
        XCTAssertTime(w3.lastDay, era: 1, year: 2024, month: 1, day: 20)
        
        let w4 = try m1.nthWeek(4)
        XCTAssertTime(w4.firstDay, era: 1, year: 2024, month: 1, day: 21)
        XCTAssertTime(w4.lastDay, era: 1, year: 2024, month: 1, day: 27)
        
        let w5 = try m1.nthWeek(5)
        XCTAssertTime(w5.firstDay, era: 1, year: 2024, month: 1, day: 28)
        XCTAssertTime(w5.lastDay, era: 1, year: 2024, month: 2, day: 3)
        
        XCTAssertThrowsError(try m1.nthWeek(6))
    }
    
    func testWeeksOfYear() throws {
        let y1 = try Fixed<Year>(region: .posix, year: 2024)
        let yearWeeks = Array(y1.weeks)
        XCTAssertEqual(yearWeeks.count, 52)
        
        let w1 = yearWeeks[0]
        XCTAssertTime(w1.firstDay, era: 1, year: 2023, month: 12, day: 31)
    }
    
    func testWeekRounding() throws {
        let d1 = try Fixed<Day>(region: .posix, year: 2024, month: 1, day: 1)
        
        let startOfNearestWeek = d1.roundedToNearestWeek()
        XCTAssertTime(startOfNearestWeek, era: 1, year: 2023, month: 12, day: 31)
        
        let startOfWeekRoundedDown = d1.roundedToWeek(direction: .backward)
        XCTAssertTime(startOfWeekRoundedDown, era: 1, year: 2023, month: 12, day: 31)
        
        let startOfWeekRoundedUp = d1.roundedToWeek(direction: .forward)
        XCTAssertTime(startOfWeekRoundedUp, era: 1, year: 2024, month: 1, day: 7)
    }
    
    func testFullWeeks() throws {
        let m1 = try Fixed<Month>(region: .posix, year: 2024, month: 1)
        
        let ffw1 = try XCTUnwrap(m1.firstFullWeek)
        // the first week of January 2024 begins on 31 Dec 2023; it's not a full week
        XCTAssertTime(ffw1.firstDay, era: 1, year: 2024, month: 1, day: 7)
        
        let lfw1 = try XCTUnwrap(m1.lastFullWeek)
        // the last week of January 2024 starts on 28 Jan; it's not a full week
        XCTAssertTime(lfw1.firstDay, era: 1, year: 2024, month: 1, day: 21)
        
        // september 2024's first full week should also be its first week
        let m2 = try Fixed<Month>(region: .posix, year: 2024, month: 9)
        let ffw2 = try XCTUnwrap(m2.firstFullWeek)
        XCTAssertTime(ffw2.firstDay, era: 1, year: 2024, month: 9, day: 1)
        XCTAssertEqual(m2.firstWeek, ffw2)
        
        // november 2024's last full week should also be its last week
        let m3 = m2.adding(months: 2)
        let lfw3 = try XCTUnwrap(m3.lastFullWeek)
        XCTAssertTime(lfw3.firstDay, era: 1, year: 2024, month: 11, day: 24)
        XCTAssertEqual(m3.lastWeek, lfw3)
        
        // The coptic calendar has an intercalary month of 5 or 6 days
        // that means it's never long enough to contain an entire full week
        // this tests that we can retrieve the weeks that contain its start and end days,
        // but the month itself has no full weeks
        let copticRegion = Region.posix.setCalendar(Calendar(identifier: .coptic))
        let piKogiEnavot = try Fixed<Month>(region: copticRegion, year: 1740, month: 13)
        let w1 = piKogiEnavot.firstWeek
        XCTAssertEqual(piKogiEnavot.relation(to: w1), .isOverlappedBy)
        
        let w2 = piKogiEnavot.lastWeek
        XCTAssertEqual(piKogiEnavot.relation(to: w2), .overlaps)
        
        XCTAssertNil(piKogiEnavot.firstFullWeek)
        XCTAssertNil(piKogiEnavot.lastFullWeek)
    }
}
