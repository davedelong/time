import XCTest

extension XCTestCase {
    
    func wait(_ delay: TimeInterval) {
        let e = self.expectation(description: "Wait for \(delay)s")
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { e.fulfill() }
        self.wait(for: [e], timeout: delay + 0.1)
    }
    
}
