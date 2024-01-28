import XCTest
@testable import Time

class RelationTests: XCTestCase {
    
    static var allTests = [
        ("testBeforeAndAfter", testBeforeAndAfter),
        ("testMeetsAndIsMetBy", testMeetsAndIsMetBy),
        ("testOverlapsAndIsOverlappedBy", testOverlapsAndIsOverlappedBy),
        ("testStartsAndIsStartedBy", testStartsAndIsStartedBy),
        ("testDuringAndContains", testDuringAndContains),
        ("testFinishesAndIsFinishedBy", testFinishesAndIsFinishedBy),
        ("testEqual", testEqual),
        
        ("testRangeBeforeAndAfter", testRangeBeforeAndAfter),
        ("testRangeMeetsAndIsMetBy", testRangeMeetsAndIsMetBy),
        ("testRangeOverlapsAndIsOverlappedBy", testRangeOverlapsAndIsOverlappedBy),
        ("testRangeStartsAndIsStartedBy", testRangeStartsAndIsStartedBy),
        ("testRangeDuringAndContains", testRangeDuringAndContains),
        ("testRangeFinishesAndIsFinishedBy", testRangeFinishesAndIsFinishedBy),
        ("testRangeEqual", testRangeEqual),
    ]
    
    func testBeforeAndAfter() {
        let a = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let b = try! Fixed<Day>(region: .posix, year: 2020, month: 2, day: 1)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .before)
        XCTAssertTrue(a.isBefore(b))
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .after)
        XCTAssertTrue(b.isAfter(a))
    }
    
    func testMeetsAndIsMetBy() {
        let a = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let b = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 2)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .meets)
        XCTAssertTrue(a.isBefore(b))
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .isMetBy)
        XCTAssertTrue(b.isAfter(a))
        
    }
    
    func testOverlapsAndIsOverlappedBy() {
        // you can't have overlapping values of the 8 base units within a single calendaring system
        // because the point of a calendaring system is to represent sequences of discrete values,
        // all subdivided by the same boundaries.
        
        // therefore in order to test overlapping, we have to resort to comparing values
        // BETWEEN calendaring systems
        
        // Jumada al-Awwal 1441 overlaps with January 2020
        let islamicRegion = Region.posix.setCalendar(Calendar(identifier: .islamic))
        let a = try! Fixed<Month>(region: islamicRegion, year: 1441, month: 5)
        
        let b = try! Fixed<Month>(region: .posix, year: 2020, month: 1)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .overlaps)
        XCTAssertTrue(a.overlaps(b))
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .isOverlappedBy)
        XCTAssertTrue(b.overlaps(a))
    }
    
    func testStartsAndIsStartedBy() {
        let a = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let b = try! Fixed<Month>(region: .posix, year: 2020, month: 1)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .starts)
        XCTAssertTrue(a.isDuring(b))
        XCTAssertFalse(b.isDuring(a))
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .isStartedBy)
        XCTAssertTrue(b.contains(a))
        XCTAssertFalse(a.contains(b))
    }
    
    func testDuringAndContains() {
        let a = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 2)
        let b = try! Fixed<Month>(region: .posix, year: 2020, month: 1)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .during)
        XCTAssertTrue(a.isDuring(b))
        XCTAssertFalse(b.isDuring(a))
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .contains)
        XCTAssertTrue(b.contains(a))
        XCTAssertFalse(a.contains(b))
    }
    
    func testFinishesAndIsFinishedBy() {
        let a = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 31)
        let b = try! Fixed<Month>(region: .posix, year: 2020, month: 1)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .finishes)
        XCTAssertTrue(a.isDuring(b))
        XCTAssertFalse(b.isDuring(a))
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .isFinishedBy)
        XCTAssertTrue(b.contains(a))
        XCTAssertFalse(a.contains(b))
    }
    
    func testEqual() {
        let a = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 31)
        let b = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 31)
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .equal)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .equal)
    }
    
    func testRangeBeforeAndAfter() {
        let a1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let a2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 2)
        
        let b1 = try! Fixed<Day>(region: .posix, year: 2020, month: 2, day: 1)
        let b2 = try! Fixed<Day>(region: .posix, year: 2020, month: 2, day: 2)
        
        let a = a1 ..< a2
        let b = b1 ..< b2
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .before)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .after)
    }
    
    func testRangeMeetsAndIsMetBy() {
        let a1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let a2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 2)
        
        let b1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 2)
        let b2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 3)
        
        let a = a1 ..< a2
        let b = b1 ..< b2
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .meets)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .isMetBy)
    }
    
    func testRangeOverlapsAndIsOverlappedBy() {
        let a1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let a2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 10)
        
        let b1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 5)
        let b2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 15)
        
        let a = a1 ..< a2
        let b = b1 ..< b2
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .overlaps)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .isOverlappedBy)
    }
    
    func testRangeStartsAndIsStartedBy() {
        let a1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let a2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 2)
        
        let b1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let b2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 5)
        
        let a = a1 ..< a2
        let b = b1 ..< b2
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .starts)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .isStartedBy)
    }
    
    func testRangeDuringAndContains() {
        let a1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 2)
        let a2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 3)
        
        let b1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let b2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 5)
        
        let a = a1 ..< a2
        let b = b1 ..< b2
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .during)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .contains)
    }
    
    func testRangeFinishesAndIsFinishedBy() {
        let a1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 4)
        let a2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 5)
        
        let b1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let b2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 5)
        
        let a = a1 ..< a2
        let b = b1 ..< b2
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .finishes)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .isFinishedBy)
    }
    
    func testRangeEqual() {
        let a1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let a2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 10)
        
        let b1 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 1)
        let b2 = try! Fixed<Day>(region: .posix, year: 2020, month: 1, day: 10)
        
        let a = a1 ..< a2
        let b = b1 ..< b2
        
        let aToB = a.relation(to: b)
        XCTAssertEqual(aToB, .equal)
        
        let bToA = b.relation(to: a)
        XCTAssertEqual(bToA, .equal)
    }
}
