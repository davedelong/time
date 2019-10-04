import XCTest
@testable import Chronology

class ChronologyTests: XCTestCase {
    func testExample() {
        
        let c = Clock.system
        let this = c.thisDay()
        let tomorrow = this + .days(1)
        print(tomorrow)
//
//        let minutes = this.hours()
//        print(Array(minutes))
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
