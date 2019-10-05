import XCTest
@testable import Chronology

class ChronologyTests: XCTestCase {
    func testExample() {
        
        let c = Clock.system
        let this = c.thisMinute()
//        let s = this.months()
        
        let e = c.thisYear()
        
        let days = AbsoluteValueSequence<Minute>.init(parent: c.thisHour(), stride: DateComponents(minute: 5))
        for d in days {
            print(d.format(year: .full, month: .fullName, day: .full, hour: .full(), minute: .full, timeZone: .shortSpecific))
        }
        
        
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
