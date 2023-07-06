import XCTest
@testable import TimeTests

XCTMain([
    testCase(AbsoluteFormattingTests.allTests),
    testCase(AbsoluteTests.allTests),
    testCase(ClockTests.allTests),
    testCase(ClockChimeTests.allTests),
    testCase(RegionTests.allTests),
    testCase(RelationTests.allTests),
    testCase(TimeTests.allTests),
    testCase(SerializationTests.allTests),
    testCase(ThreadingTests.allTests)
])
