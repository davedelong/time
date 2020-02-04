import XCTest
@testable import Time

class TimeTests: XCTestCase {
    func testExample() {
        
        let c = Clock.system
        let nextYear = c.nextYear()
        let months = nextYear.months()
        
        for month in months {
            let days = Array(month.days())
            print("\(month.format(year: .full, month: .fullName)) - \(days.count) days")
        }
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
