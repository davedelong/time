import XCTest
@testable import Chronology

class ChronologyTests: XCTestCase {
    func testExample() {
        
        let c = Clock.system
        let this = c.thisMinute()
//        let s = this.months()
        
        let e = c.thisEra()
        print(e.era)
        let n = e + .init(value: 1, unit: .era)
        print(n.era)
        
        
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
