//
//  File.swift
//  
//
//  Created by Dave DeLong on 4/11/20.
//

import XCTest
import Time

class RegionTests: XCTestCase {
    
    func test24HourPreference() {
        
        XCTAssertFalse(Region.posix.wants24HourTime)
        
        let france = Region(calendar: .current, timeZone: .current, locale: Locale(identifier: "fr_FR"))
        XCTAssertTrue(france.wants24HourTime)
        
    }

}
