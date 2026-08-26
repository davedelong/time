import XCTest
@testable import Time

class RegionTests: XCTestCase {

    static let allTests = [
        ("test24HourPreference", test24HourPreference),
        ("testCannotCreateAutoupdatingRegion", testCannotCreateAutoupdatingRegion),
        ("testTimezoneForcedCopy", testTimezoneForcedCopy)
    ]
    
    func test24HourPreference() {
        
        XCTAssertFalse(Region.posix.wants24HourTime)
        
        let france = Region(calendar: .current, timeZone: .current, locale: Locale(identifier: "fr_FR"))
        XCTAssertTrue(france.wants24HourTime)
        
    }
    
    func testCannotCreateAutoupdatingRegion() {
        let auto = Region.autoupdatingCurrent
        XCTAssertTrue(auto.isAutoupdating)
        XCTAssertTrue(auto.calendar.isLikelyAutoupdating)
        XCTAssertTrue(auto.timeZone.isLikelyAutoupdating)
        XCTAssertTrue(auto.locale.isLikelyAutoupdating)
        
        let autoAttempt = Region(calendar: .autoupdatingCurrent,
                                 timeZone: .autoupdatingCurrent,
                                 locale: .autoupdatingCurrent)
        
        XCTAssertEqual(auto, autoAttempt)
        XCTAssertFalse(autoAttempt.isAutoupdating)        
        XCTAssertFalse(autoAttempt.calendar.isLikelyAutoupdating)
        XCTAssertFalse(autoAttempt.timeZone.isLikelyAutoupdating)
        XCTAssertFalse(autoAttempt.locale.isLikelyAutoupdating)
    }
    
    func testTimezoneForcedCopy() throws {
        let etcGMTm6 = Region(calendar: Calendar(identifier: .gregorian),
                              timeZone: TimeZone(identifier: "Etc/GMT-6")!,
                              locale: Locale(identifier: "en_US"))
        
        let copy = etcGMTm6._forcedCopy()
        
        XCTAssertEqual(etcGMTm6.timeZone, copy.timeZone)
    }

}
