import XCTest
@testable import Chronology

class ChronologyTests: XCTestCase {
    func testExample() {
        
        let c = Clock.system
        let this = c.thisMinute()
//        let s = this.months()
        
        
        
        let d = this.absoluteDay
        print(d.day)
//        print(Array(s))
//
//        let minutes = this.hours()
//        print(Array(minutes))
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
