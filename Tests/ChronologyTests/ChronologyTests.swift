import XCTest
@testable import Chronology

class ChronologyTests: XCTestCase {
    func testExample() {
        
        let c = Clock.system
        let this = c.thisYear()
        let s = this.months()
        print(Array(s))
//
//        let minutes = this.hours()
//        print(Array(minutes))
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
