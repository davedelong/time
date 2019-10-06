import XCTest
@testable import Chronology

class ChronologyTests: XCTestCase {
    func testExample() {
        
        let c = Clock.system
        
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .japanese)
        df.dateFormat = DateFormatter.dateFormat(fromTemplate: "GyMMMMd", options: 0, locale: .current)
        df.timeZone = .current
        
        let now = c.thisInstant()
        
        let mon = c.today().relativeMonthDay
        print("\(mon)")
        
        print(df.string(from: now.date))
        
        let t = c.today()
        let otherToday = t.converting(to: .init(identifier: .japanese))
        print("\(otherToday.calendar)")
        print("Converted: \(otherToday)")
        
        let start = c.thisMinute()
        let end = start.adding(hours: 1)
        
        let seq = AbsoluteValueSequence<Minute>(range: start...end, stride: .minutes(3))
        
        for c in seq {
            print("\(c)")
        }
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
