//
//  File.swift
//
import XCTest
import Time

class RegionTests: XCTestCase {

    static var allTests = [
        ("test24HourPreference", test24HourPreference),
    ]
    
    func test24HourPreference() {
        
        XCTAssertFalse(Region.posix.wants24HourTime)
        
        let france = Region(calendar: .current, timeZone: .current, locale: Locale(identifier: "fr_FR"))
        XCTAssertTrue(france.wants24HourTime)
        
    }

}
