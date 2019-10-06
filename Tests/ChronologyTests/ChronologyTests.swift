import XCTest
@testable import Chronology

class ChronologyTests: XCTestCase {
    func testExample() {
        
        let c = Clock.system
        let this = c.thisMinute()
//        let s = this.months()
        
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .islamic)
        df.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMMd", options: 0, locale: .current)
        df.timeZone = .current
        
        let now = c.thisInstant()
        
        print(df.string(from: now.date))
        
        let t = c.today()
        let otherToday = t.convert(to: .init(identifier: .japanese))
        print("Converted: \(otherToday)")
        print(otherToday.format(era: .abbreviated, year: .full, month: .fullName, day: .full))
        
        let start = c.thisMinute()
        let end = start.nextHour()
        
        let seq = AbsoluteValueSequence<Minute>(range: start...end, stride: .minutes(3))
        
        for c in seq {
            print("\(c)")
        }
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
