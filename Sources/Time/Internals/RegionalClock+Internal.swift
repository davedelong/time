import Foundation
import Dispatch

internal class CancellationToken {
    
    private let lock = NSLock()
    private var _isCancelled = false
    
    var isCancelled: Bool {
        lock.withLock { self._isCancelled }
    }
    
    func cancel() {
        lock.withLock { self._isCancelled = true }
    }
    
}

extension RegionalClock {
    
    internal func sleep(until deadline: Instant, tolerance: Instant.Duration?, token: CancellationToken?) async throws {
        // this is in an infinite loop to account for the tolerance causing the clock to wake up
        // BEFORE the desired time has been hit on the clock
        repeat {
            let clockNow = self.now
            let timeUntilInstant = deadline - clockNow

            // timeUntilInstant is how long we need to wait relative to the passed-in clock
            // however, that clock may have a different flow-rate of time relative to the system clock
            // and we need to reconcile the two
            
            let realTimeToWait = timeUntilInstant / self.SISecondsPerClockSecond
            let realTolerance = tolerance.map { $0 / self.SISecondsPerClockSecond }
            
            if realTimeToWait <= .zero {
                return
            }
            
            // we care about the passage of real time, which happens regardless of whether the process is suspended or not
            // therefore we calculate the REAL time to wait based on a continuous clock
            try await Task.sleep(for: realTimeToWait.rawValue, tolerance: realTolerance?.rawValue, clock: .continuous)
            
        } while token?.isCancelled != true
    }
    
    @discardableResult
    internal func wait(until instant: Instant, tolerance: Instant.Duration?, strike: @escaping () -> Void) -> CancellationToken {
        let token = CancellationToken()
        Task {
            do {
                try await self.sleep(until: instant, tolerance: tolerance, token: token)
            } catch { }
            if token.isCancelled == false { strike() }
        }
        return token
    }
    
}
