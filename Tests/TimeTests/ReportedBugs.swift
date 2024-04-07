import XCTest
import Time

class ReportedBugs: XCTestCase {
    
    func testSwedenRangeCrashAroundDST() throws {
        let sweden = Region(calendar: Calendar(identifier: .gregorian),
                            timeZone: TimeZone(identifier: "Europe/Stockholm")!,
                              locale: Locale(identifier: "en_US"))

        let start = try Fixed<Second>(region: sweden, year: 2023, month: 10, day: 29, hour: 02, minute: 30, second: 00)
        let end = start.adding(minutes: 30)
        let range = start ..< end
        
        XCTAssertTrue(range.upperBound > range.lowerBound)
    }
    
    func testSwedenRepeatedOffsettingAroundDST() throws {
        let sweden = Region(calendar: Calendar(identifier: .gregorian),
                            timeZone: TimeZone(identifier: "Europe/Stockholm")!,
                              locale: Locale(identifier: "en_US"))

        let start = try Fixed<Second>(region: sweden, year: 2023, month: 10, day: 29, hour: 02, minute: 30, second: 00)
        let target = start.adding(hours: 10)
        var step = start

        while step.isBefore(target) {
            step = step.adding(minutes: 30)
        }
        
        XCTAssertTrue(step >= target)
    }
    
    func testISO8601WeekdayNumber_GH75() throws {
        /*
         The ISO8601 calendar uses different weekday numberings than the
         gregorian calendar. On the gregorian calendar, 1 = Sunday. On the
         ISO8601 calendar, 1 = Monday.
         
         This test makes sure that the numeric value from `.dayOfWeek` and
         the Locale.Weekday value from `.weekday` is consistent between
         calendars, even if they *format* differently.
         */
        
        let iso8601 = Calendar(identifier: .iso8601)
        let iso8601Region = Region(calendar: iso8601,
                                   timeZone: TimeZone(secondsFromGMT: 0)!,
                                   locale: .current)
        
        let mar3Gregorian = try Fixed(region: .posix, year: 2024, month: 3, day: 3)
        let mar3ISO8601 = try Fixed(region: iso8601Region, year: 2024, month: 3, day: 3)
        
        XCTAssertEqual(mar3Gregorian.dayOfWeek, 1)
        XCTAssertEqual(mar3ISO8601.dayOfWeek, 1)
        
        #if !os(Linux)
        XCTAssertEqual(mar3Gregorian.weekday, .sunday)
        XCTAssertEqual(mar3ISO8601.weekday, .sunday)
        #endif
        
        let formattedGregorian = mar3Gregorian.format(weekday: .naturalDigits)
        let formattedISO8601 = mar3ISO8601.format(weekday: .naturalDigits)
        
        XCTAssertEqual(formattedGregorian, "1")
        XCTAssertEqual(formattedISO8601, "7")
    }
    
    func testValuesWithoutErasStillHaveThem_GH82() throws {
        let day = try Fixed(region: .posix, year: 2024, month: 4, day: 7)
        XCTAssertEqual(day.era, 1)
    }
}
