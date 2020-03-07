import XCTest
@testable import Time

class RelationTests: XCTestCase {
    
    func testBeforeAndAfter() {
        let a = try! Absolute<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let b = try! Absolute<Day>(region: .posix, year: 2020, month: 2, day: 1)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .before)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .after)
    }
    
    func testMeetsAndIsMetBy() {
        let a = try! Absolute<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let b = try! Absolute<Day>(region: .posix, year: 2020, month: 1, day: 2)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .meets)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .isMetBy)
    }
    
    func testOverlapsAndIsOverlappedBy() {
        // you can't have overlapping values of the 8 base units within a single calendaring system
        // because the point of a calendaring system is to represent sequences of discrete values,
        // all subdivided by the same boundaries.
        
        // therefore in order to test overlapping, we have to resort to comparing values
        // BETWEEN calendaring systems
        
        // Jumada al-Awwal 1441 overlaps with January 2020
        let islamicRegion = Region.posix.converting(to: Calendar(identifier: .islamic))
        let a = try! Absolute<Month>(region: islamicRegion, year: 1441, month: 5)
        
        let b = try! Absolute<Month>(region: .posix, year: 2020, month: 1)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .overlaps)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .isOverlappedBy)
    }
    
    func testStartsAndIsStartedBy() {
        let a = try! Absolute<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let b = try! Absolute<Month>(region: .posix, year: 2020, month: 1)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .starts)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .isStartedBy)
    }
    
    func testDuringAndContains() {
        let a = try! Absolute<Day>(region: .posix, year: 2020, month: 1, day: 2)
        let b = try! Absolute<Month>(region: .posix, year: 2020, month: 1)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .during)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .contains)
    }
    
    func testFinishesAndIsFinishedBy() {
        let a = try! Absolute<Day>(region: .posix, year: 2020, month: 1, day: 31)
        let b = try! Absolute<Month>(region: .posix, year: 2020, month: 1)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .finishes)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .isFinishedBy)
    }
    
    func testEqual() {
        let a = try! Absolute<Day>(region: .posix, year: 2020, month: 1, day: 31)
        let b = try! Absolute<Day>(region: .posix, year: 2020, month: 1, day: 31)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .equal)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .equal)
    }
    
    static var allTests = [
        ("testBeforeAndAfter", testBeforeAndAfter),
        ("testMeetsAndIsMetBy", testMeetsAndIsMetBy),
        ("testOverlapsAndIsOverlappedBy", testOverlapsAndIsOverlappedBy),
        ("testStartsAndIsStartedBy", testStartsAndIsStartedBy),
        ("testDuringAndContains", testDuringAndContains),
        ("testFinishesAndIsFinishedBy", testFinishesAndIsFinishedBy),
        ("testEqual", testEqual),
    ]
}
