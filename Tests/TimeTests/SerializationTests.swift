import XCTest
@testable import Time
import protocol Time.Unit

class SerializationTests: XCTestCase {

    static var allTests = [
        ("testCodableRegionRoundTrip", testCodableRegionRoundTrip),
        ("testCodableTimePeriodRoundTrip", testCodableTimePeriodRoundTrip),
        ("testMaliciousPayload", testMaliciousPayload),
        ("testNonEraTimePeriod", testMaliciousPayload),
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

    func testNonEraTimePeriod() throws {
        try testRoundTripOfNonEraPeriod(of: TimePeriod<Year, Year>(region: .current, instant: Clocks.system.thisInstant()))
        try testRoundTripOfNonEraPeriod(of: TimePeriod<Month, Month>(region: .current, instant: Clocks.system.thisInstant()))
        try testRoundTripOfNonEraPeriod(of: TimePeriod<Day, Day>(region: .current, instant: Clocks.system.thisInstant()))
        try testRoundTripOfNonEraPeriod(of: TimePeriod<Hour, Hour>(region: .current, instant: Clocks.system.thisInstant()))
        try testRoundTripOfNonEraPeriod(of: TimePeriod<Minute, Minute>(region: .current, instant: Clocks.system.thisInstant()))
        try testRoundTripOfNonEraPeriod(of: TimePeriod<Second, Second>(region: .current, instant: Clocks.system.thisInstant()))
        try testRoundTripOfNonEraPeriod(of: TimePeriod<Nanosecond, Nanosecond>(region: .current, instant: Clocks.system.thisInstant()))

    }

    private func testRoundTripOfNonEraPeriod<U: Unit>(of timePeriod: TimePeriod<U, U>) throws {
        let encodedValue = try JSONEncoder().encode(timePeriod)
        let decodedValue = try JSONDecoder().decode(TimePeriod<U, U>.self, from: encodedValue)
        XCTAssertEqual(timePeriod, decodedValue)
    }

#if swift(>=5.5)
    // Test resources were added in a Swift version later than 5.0, which this library supports.

    func testMaliciousPayload() throws {
        let decoder = JSONDecoder()

        let validPayload = generatePayloadFor(year: 2023, month: 01, day: 01, hour: 11, minute: 00, second: 00)
        let _ = try decoder.decode(Absolute<Second>.self, from: validPayload)

        let invalidMonthPayload = generatePayloadFor(year: 2023, month: -4, day: 01, hour: 11, minute: 00, second: 00)
        let _ = try decoder.decode(Absolute<Second>.self, from: invalidMonthPayload)
        // TODO: Should this be valid? It spits out August 2022.

        let invalidHourPayload = generatePayloadFor(year: 2023, month: 01, day: 01, hour: 27, minute: 00, second: 00)
        let _ = try decoder.decode(Absolute<Second>.self, from: invalidHourPayload)
        // TODO: Should this be valid? It spits out 2nd January at 3am.

        let invalidDayPayload = generatePayloadFor(year: 2023, month: 01, day: 00, hour: 01, minute: 00, second: 00)
        let _ = try decoder.decode(Absolute<Second>.self, from: invalidDayPayload)
        // TODO: Should this be valid? It spits out 31st December 2022.

        let payloadMissingPayload = generatePayloadFor(year: 2023, month: 01, day: 01, hour: 01, minute: 00, second: 00)
        let _ = try decoder.decode(Absolute<Nanosecond>.self, from: payloadMissingPayload)
        // TODO: This payload is missing the nanoseconds component, which gets intepreted as "zero". Should this be valid?
    }

    private func generatePayloadFor(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Data {
        // This is very crude.
        let payloadUrl = Bundle.module.url(forResource: "CodablePayload", withExtension: "json")!
        var payloadString = String(data: try! Data(contentsOf: payloadUrl), encoding: .utf8)!
        payloadString = payloadString.replacingCharacters(in: payloadString.range(of: "%ERA%")!, with: "\(1)")
        payloadString = payloadString.replacingCharacters(in: payloadString.range(of: "%YEAR%")!, with: "\(year)")
        payloadString = payloadString.replacingCharacters(in: payloadString.range(of: "%MONTH%")!, with: "\(month)")
        payloadString = payloadString.replacingCharacters(in: payloadString.range(of: "%DAY%")!, with: "\(day)")
        payloadString = payloadString.replacingCharacters(in: payloadString.range(of: "%HOUR%")!, with: "\(hour)")
        payloadString = payloadString.replacingCharacters(in: payloadString.range(of: "%MINUTE%")!, with: "\(minute)")
        payloadString = payloadString.replacingCharacters(in: payloadString.range(of: "%SECOND%")!, with: "\(second)")
        return payloadString.data(using: .utf8)!
    }
#else

    func testMaliciousPayload() throws {
        print("WARNING: Skipping testMaliciousPayload() since it requires Swift >= 5.5.")
    }
#endif

}
