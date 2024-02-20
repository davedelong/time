import XCTest
@testable import Time

class RegionTests: XCTestCase {

    static var allTests = [
        ("test24HourPreference", test24HourPreference),
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

}
