import XCTest
@testable import Chronology

class ChronologyTests: XCTestCase {
    func testExample() {
        
        let c = Clock.system
        let today = c.thisNanosecond()
        let v = today + .nanoseconds(2)
        XCTAssertNotNil(v)
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
