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
    
    func testValuesWithDifferentInstantsAreStillEqual() throws {
        let thisMinute = Clocks.system.thisMinute
        
        let firstSecond = thisMinute.firstSecond
        let secondSecond = firstSecond.nextSecond
        
        XCTAssertNotEqual(firstSecond, secondSecond)
        
        let minuteOfFirstSecond = firstSecond.fixedMinute
        let minuteOfSecondSecond = secondSecond.fixedMinute
        XCTAssertEqual(minuteOfFirstSecond, minuteOfSecondSecond)
    }
    
    func testRounding() throws {
        let t = try! Fixed<Nanosecond>(region: .posix, era: 1, year: 2024, month: 2, day: 3, hour: 14, minute: 27, second: 43, nanosecond: 499_000_000)
        
        XCTAssertEqual(t.nearestEra.era, 1)
        XCTAssertEqual(t.nearestYear.year, 2024)
        XCTAssertEqual(t.nearestMonth.month, 2)
        XCTAssertEqual(t.nearestDay.day, 4)
        XCTAssertEqual(t.nearestHour.hour, 14)
        XCTAssertEqual(t.nearestMinute.minute, 28)
        XCTAssertEqual(t.nearestSecond.second, 43)
        
        XCTAssertEqual(t.roundedToEra(direction: .forward).era, 1)
        XCTAssertEqual(t.roundedToYear(direction: .forward).year, 2025)
        XCTAssertEqual(t.roundedToMonth(direction: .forward).month, 3)
        XCTAssertEqual(t.roundedToDay(direction: .forward).day, 4)
        XCTAssertEqual(t.roundedToHour(direction: .forward).hour, 15)
        XCTAssertEqual(t.roundedToMinute(direction: .forward).minute, 28)
        XCTAssertEqual(t.roundedToSecond(direction: .forward).second, 44)
        
        XCTAssertEqual(t.roundedToEra(direction: .backward).era, 1)
        XCTAssertEqual(t.roundedToYear(direction: .backward).year, 2024)
        XCTAssertEqual(t.roundedToMonth(direction: .backward).month, 2)
        XCTAssertEqual(t.roundedToDay(direction: .backward).day, 3)
        XCTAssertEqual(t.roundedToHour(direction: .backward).hour, 14)
        XCTAssertEqual(t.roundedToMinute(direction: .backward).minute, 27)
        XCTAssertEqual(t.roundedToSecond(direction: .backward).second, 43)
    }
    
    func testSimpleMultipleRounding() throws {
        let t = try! Fixed(region: .posix, year: 2024, month: 2, day: 10, hour: 18, minute: 52, second: 13)
        
        let r1 = t.roundedToNearestMultiple(of: .minutes(15))
        XCTAssertTime(r1, era: 1, year: 2024, month: 2, day: 10, hour: 18, minute: 45, second: 0)
        
        let r2 = t.roundedToNearestMultiple(of: .hours(3))
        XCTAssertTime(r2, era: 1, year: 2024, month: 2, day: 10, hour: 18, minute: 0, second: 0)
        
        let r3 = t.roundedToNearestMultiple(of: .minutes(29))
        XCTAssertTime(r3, era: 1, year: 2024, month: 2, day: 10, hour: 18, minute: 58, second: 0)
    }
    
    func testBoundarySequence() {
        let start = try! Fixed(region: .posix, year: 2024, month: 2, day: 1, hour: 0, minute: 0, second: 0)
        let s = BoundaryAlignedSequence(start: start, stride: .minutes(29), boundaryStride: .hours(1))
        
        let values = Array(s.prefix(6))
        
        XCTAssertEqual(values.count, 6)
        XCTAssertTime(values[0], era: 1, year: 2024, month: 2, day: 1, hour: 0, minute: 0, second: 0)
        XCTAssertTime(values[1], era: 1, year: 2024, month: 2, day: 1, hour: 0, minute: 29, second: 0)
        XCTAssertTime(values[2], era: 1, year: 2024, month: 2, day: 1, hour: 0, minute: 58, second: 0)
        XCTAssertTime(values[3], era: 1, year: 2024, month: 2, day: 1, hour: 1, minute: 0, second: 0)
        XCTAssertTime(values[4], era: 1, year: 2024, month: 2, day: 1, hour: 1, minute: 29, second: 0)
        XCTAssertTime(values[5], era: 1, year: 2024, month: 2, day: 1, hour: 1, minute: 58, second: 0)
    }
}
