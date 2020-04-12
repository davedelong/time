import XCTest
@testable import TimeTests

XCTMain([
    testCase(AbsoluteFormattingTests.allTests),
    testCase(AbsoluteTests.allTests),
    testCase(ClockTests.allTests),
    testCase(RegionTests.allTests),
    testCase(RelationTests.allTests),
    testCase(TimeTests.allTests),
    #if canImport(Combine)
    testCase(ClockChimeTests.allTests)
    #endif
])
