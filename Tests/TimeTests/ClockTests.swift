import XCTest
@testable import Time

extension Collection {
    func slice(between: (Element, Element) -> Bool) -> Array<SubSequence> {
        var slices = Array<SubSequence>()
        
        var startOfCurrentSlice = startIndex
        
        var previousIndex = startOfCurrentSlice
        var currentIndex = index(after: startOfCurrentSlice)
        
        while currentIndex < endIndex {
            let p = self[previousIndex]
            let c = self[currentIndex]
            
            if between(p, c) {
                slices.append(self[startOfCurrentSlice..<currentIndex])
                startOfCurrentSlice = currentIndex
            }
            
            previousIndex = currentIndex
            currentIndex = index(after: currentIndex)
        }
        
        if currentIndex > startOfCurrentSlice {
            slices.append(self[startOfCurrentSlice ..< currentIndex])
        }
        
        return slices
    }
}

class ClockTests: XCTestCase {
    
    static var allTests = [
        ("testSystem", testSystem),
        ("testExplicit", testExplicit),
        ("testAccelerated_2x", testAccelerated_2x),
        ("testAccelerated_10x", testAccelerated_10x),
        ("testDecelerated_2x", testDecelerated_2x),
        ("testDecelerated_10x", testDecelerated_10x),
        ("testNextDSTTransitionForTimeZoneWithDST", testNextDSTTransitionForTimeZoneWithDST),
        ("testNextDSTTransitionNextYearForTimeZoneWithDST", testNextDSTTransitionNextYearForTimeZoneWithDST),
        ("testNextDSTTransitionForTimeZoneWithoutDST", testNextDSTTransitionForTimeZoneWithoutDST),
        ("testNextDSTTransitionNextYearForTimeZoneWithoutDST", testNextDSTTransitionNextYearForTimeZoneWithoutDST)
    ]
    
    func testWeeksInYear() {
        let thisYear = Clocks.system.currentYear
        let daysInTheYear = Array(thisYear.days)
        
        let weeks = daysInTheYear.slice(between: { $0.weekOfYear != $1.weekOfYear })
        let weekLengths = weeks.map(\.count)
        XCTAssertTrue(weekLengths.allSatisfy({ $0 > 0 && $0 <= 7 }))        
    }
    
    func testSystem() {
        
        let c = Clocks.system
        let now = c.now
        
        XCTAssertEqual(now.intervalSinceEpoch.timeInterval, Date.timeIntervalSinceReferenceDate, accuracy: 0.001)
    }
    
    func testExplicit() {
        let c = Clocks.posix
        
        let now = c.now
        XCTAssertEqual(now.intervalSinceEpoch.timeInterval, Date.timeIntervalSinceReferenceDate, accuracy: 0.001)
        
        let today = c.today
        XCTAssertEqual(today.region, c.region)
    }
    
    func testAccelerated_2x() {
        let now = Clocks.system.now
        let c = Clocks.custom(startingFrom: now, rate: 2.0, region: Region.current)
        
        let thisSecond = c.now
        wait(1)
        let nextSecond = c.now
        
        let elapsedTime = nextSecond - thisSecond
        
        XCTAssertEqual(elapsedTime.timeInterval, 2.0, accuracy: 0.2) // 10% margin for error
    }
    
    func testAccelerated_10x() {
        let now = Clocks.system.now
        let c = Clocks.custom(startingFrom: now, rate: 10.0, region: Region.current)
        
        let thisSecond = c.now
        wait(1)
        let nextSecond = c.now
        
        let elapsedTime = nextSecond - thisSecond
        
        // we need a larger margin for error here so the CI tests can handle this
        XCTAssertEqual(elapsedTime.timeInterval, 10.0, accuracy: 1.5) // 15% margin for error
    }
    
    func testDecelerated_2x() {
        let now = Clocks.system.now
        let c = Clocks.custom(startingFrom: now, rate: 0.5, region: Region.current)
        
        let thisSecond = c.now
        wait(1)
        let nextSecond = c.now
        
        let elapsedTime = nextSecond - thisSecond
        
        XCTAssertEqual(elapsedTime.timeInterval, 0.5, accuracy: 0.075) // 15% margin for error
    }
    
    func testDecelerated_10x() {
        let now = Clocks.system.now
        let c = Clocks.custom(startingFrom: now, rate: 0.1, region: Region.current)
        
        let thisSecond = c.now
        wait(1)
        let nextSecond = c.now
        
        let elapsedTime = nextSecond - thisSecond
        
        XCTAssertEqual(elapsedTime.timeInterval, 0.1, accuracy: 0.015) // 15% margin for error
    }
}

// MARK: - Next Daylight Saving Time Transition

extension ClockTests {
    
    func testNextDSTTransitionForTimeZoneWithDST() {
        let timeZone = TimeZone(identifier: "Europe/London")!
        
        let region = Region(
            calendar: .autoupdatingCurrent,
            timeZone: timeZone,
            locale: .autoupdatingCurrent)
        
        let clock = Clocks.system(in: region)
        
        let instant = clock.nextDaylightSavingTimeTransition()
        XCTAssertNotNil(instant)
        
        guard let instant else { return }
        
        let accuracy = 0.000001
        if #available(macOS 14, iOS 17, watchOS 11, tvOS 17, *) {
            XCTAssertEqualWithAccuracyWorkaround(
                instant.intervalSinceReferenceEpoch.timeInterval,
                timeZone.nextDaylightSavingTimeTransition?.timeIntervalSinceReferenceDate ?? 0,
                accuracy: accuracy
            )
        } else {
            // https://github.com/apple/swift/pull/66111
            XCTAssertEqual(
                instant.intervalSinceReferenceEpoch.timeInterval,
                timeZone.nextDaylightSavingTimeTransition!.timeIntervalSinceReferenceDate,
                accuracy: accuracy
            )
        }
    }
    
    func testNextDSTTransitionNextYearForTimeZoneWithDST() {
        let timeZone = TimeZone(identifier: "Europe/London")!
        
        let region = Region(
            calendar: .autoupdatingCurrent,
            timeZone: timeZone,
            locale: .autoupdatingCurrent)
        
        let clock = Clocks.system(in: region)
        let instantNextYear = (clock.currentDay + .years(1)).firstInstant
        
        let nextDSTSeconds = clock
            .nextDaylightSavingTimeTransition(after: instantNextYear)?.intervalSinceEpoch.timeInterval
        
        let expectedDSTSeconds = timeZone
            .nextDaylightSavingTimeTransition(after: instantNextYear.date)?.timeIntervalSinceReferenceDate
        
        XCTAssertNotNil(nextDSTSeconds)
        XCTAssertEqual(nextDSTSeconds, expectedDSTSeconds)
    }
    
    func testNextDSTTransitionForTimeZoneWithoutDST() {
        let timeZone = TimeZone(identifier: "Europe/Moscow")!

        let region = Region(
            calendar: .autoupdatingCurrent,
            timeZone: timeZone,
            locale: .autoupdatingCurrent)

        let clock = Clocks.system(in: region)
        
        XCTAssertNil(clock.nextDaylightSavingTimeTransition())
    }
    
    func testNextDSTTransitionNextYearForTimeZoneWithoutDST() {
        let timeZone = TimeZone(identifier: "Europe/Moscow")!

        let region = Region(
            calendar: .autoupdatingCurrent,
            timeZone: timeZone,
            locale: .autoupdatingCurrent)

        let clock = Clocks.system(in: region)
        let instantNextYear = (clock.currentDay + .years(1)).firstInstant
        
        let nextDSTSeconds = clock
            .nextDaylightSavingTimeTransition(after: instantNextYear)?.intervalSinceEpoch.rawValue
        
        XCTAssertNil(nextDSTSeconds)
    }
    
}

// MARK: Autoupdating Clocks

extension ClockTests {
    
    func testAutoupdatingCalendarProducesStaticCalendar() {
        let calendar = Calendar.autoupdatingCurrent
        let r = Region(calendar: calendar, timeZone: .current, locale: .current)
        let c = Clocks.system(in: r)
        
        let now = c.currentSecond
        
        XCTAssertNotEqual(now.calendar, calendar)
    }
    
    func testAutoupdatingRegionProducesStaticRegion() {
        let r = Region.autoupdatingCurrent
        XCTAssertTrue(r.isAutoupdating)
        
        let c = Clocks.system(in: r)
        XCTAssertTrue(c.region.isAutoupdating)
        
        let now = c.currentSecond
        XCTAssertFalse(now.region.isAutoupdating)
    }
    
}
