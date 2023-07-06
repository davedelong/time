import XCTest
@testable import TimeTests

#if swift(<5.1)
XCTMain([
    testCase(AbsoluteFormattingTests.allTests),
    testCase(AbsoluteTests.allTests),
    testCase(ClockTests.allTests),
    testCase(ClockChimeTests.allTests),
    testCase(RegionTests.allTests),
    testCase(RelationTests.allTests),
    testCase(TimeTests.allTests),
    testCase(SerializationTests.allTests)
])
#endif
