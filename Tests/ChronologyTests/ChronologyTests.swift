import XCTest
@testable import Chronology

class ChronologyTests: XCTestCase {
    func testExample() {
        
        let c = Clock.system
        let today = c.thisYearMonthDay()
        
        let v = today + .nanoseconds(2)
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
