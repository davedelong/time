import XCTest
@testable import TimeTests

XCTMain([
    testCase(AbsoluteFormattingTests.allTests),
    testCase(AbsoluteTests.allTests),
    testCase(ClockTests.allTests),
    testCase(RegionTests.allTests),
    testCase(TimeTests.allTests),
])
