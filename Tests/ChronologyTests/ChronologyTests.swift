import XCTest
@testable import Chronology

class ChronologyTests: XCTestCase {
    func testExample() {
        
        let c = Clock.system
        let this = c.thisMinute()
//        let s = this.months()
        
        
        
        let recurringHoliday: Relative<Second, Day>
        
        let d = this.day
        d.dayValue
//        print(Array(s))
//
//        let minutes = this.hours()
//        print(Array(minutes))
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
