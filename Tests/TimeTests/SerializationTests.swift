import XCTest
@testable import Time
import protocol Time.Unit

class SerializationTests: XCTestCase {

    static var allTests = [
        ("testCodableRegionRoundTrip", testCodableRegionRoundTrip),
        ("testCodableTimePeriodRoundTrip", testCodableTimePeriodRoundTrip),
    ]

    func testCodableRegionRoundTrip() throws {
        let thisRegion = Region.current
        let encodedThis = try JSONEncoder().encode(thisRegion)
        let decodedThis = try JSONDecoder().decode(Region.self, from: encodedThis)
        XCTAssertEqual(thisRegion, decodedThis)

        let explicitRegion = Region(calendar: Calendar(identifier: .gregorian),
                                    timeZone: TimeZone(identifier: "Europe/Paris")!,
                                    locale: Locale(identifier: "fr_FR"))

        let encodedExplicit = try JSONEncoder().encode(explicitRegion)
        let decodedExplicit = try JSONDecoder().decode(Region.self, from: encodedExplicit)
        XCTAssertEqual(explicitRegion, decodedExplicit)
    }

    func testCodableTimePeriodRoundTrip() throws {

        let clock = Clocks.system

        try testRoundTrip(of: clock.thisYear())
        try testRoundTrip(of: clock.thisMonth())
        try testRoundTrip(of: clock.thisDay())
        try testRoundTrip(of: clock.thisHour())
        try testRoundTrip(of: clock.thisMinute())
        try testRoundTrip(of: clock.thisSecond())
        try testRoundTrip(of: clock.thisNanosecond())
    }

    private func testRoundTrip<U: Unit>(of timePeriod: Absolute<U>) throws {
        let encoded = try JSONEncoder().encode(timePeriod)
        let decoded = try JSONDecoder().decode(Absolute<U>.self, from: encoded)
        XCTAssertEqual(timePeriod, decoded)
    }
}
