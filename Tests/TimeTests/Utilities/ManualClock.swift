import Foundation
import Time

final class ManualClock: RegionalClock, @unchecked Sendable {
    
    private struct SleepingTask {
        let deadline: Instant
        let tolerance: SISeconds?
        let handler: UnsafeContinuation<Void, Error>
    }
    
    private let lock = NSLock()
    
    private var underlyingClock: any RegionalClock
    private var pendingSleeps = Array<SleepingTask>()
    
    public var now: Instant {
        get {
            lock.withLock { self.underlyingClock.now }
        }
        set {
            self._updateClock(newValue, region: nil, rate: nil)
        }
    }
    
    /// The clock's `Region`, used for creating calendrical values.
    var region: Region {
        get {
            lock.withLock { self.underlyingClock.region }
        }
        set {
            self._updateClock(nil, region: newValue, rate: nil)
        }
    }
    
    var SISecondsPerClockSecond: Double {
        get {
            lock.withLock { self.underlyingClock.SISecondsPerClockSecond }
        }
        set {
            self._updateClock(nil, region: nil, rate: newValue)
        }
    }
    
    init(now: Instant? = nil, region: Region = .current, rate: Double = 1.0) {
        let base = Clocks.system(in: region)
        
        if let now {
            self.underlyingClock = Clocks.custom(startingFrom: now, rate: rate, region: region)
        } else {
            self.underlyingClock = Clocks.system(in: region).scaled(by: rate)
        }
    }
    
    private func _updateClock(_ now: Instant?, region: Region?, rate: Double?) {
        let tasks: Array<SleepingTask> = lock.withLock {
            let newNow: Instant
            let newRegion: Region
            let newRate: Double
            
            if let now {
                newNow = now
                newRegion = underlyingClock.region
                newRate = underlyingClock.SISecondsPerClockSecond
            } else if let region {
                newNow = underlyingClock.now
                newRegion = region
                newRate = underlyingClock.SISecondsPerClockSecond
                
            } else if let rate {
                newNow = underlyingClock.now
                newRegion = underlyingClock.region
                newRate = rate
            } else {
                return []
            }
            
            self.underlyingClock = Clocks.custom(startingFrom: newNow,
                                                 rate: newRate,
                                                 region: newRegion)
            
            var tasksToExecute = Array<SleepingTask>()
            var tasksToKeepWaiting = Array<SleepingTask>()
            
            for task in self.pendingSleeps {
                if task.deadline <= newNow {
                    tasksToExecute.append(task)
                } else {
                    tasksToKeepWaiting.append(task)
                }
            }
            
            self.pendingSleeps = tasksToKeepWaiting
            return tasksToExecute
        }
        
        for task in tasks {
            task.handler.resume(returning: ())
        }
    }
    
    func sleep(until deadline: Instant, tolerance: SISeconds?) async throws {
        try await withUnsafeThrowingContinuation { continuation in
            let shouldInvoke = lock.withLock {
                let now = self.underlyingClock.now
                guard deadline > now else {
                    return true
                }
                
                let task = SleepingTask(deadline: deadline, tolerance: tolerance, handler: continuation)
                pendingSleeps.append(task)
                return false
            }
            
            if shouldInvoke {
                continuation.resume(returning: ())
            }
        }
    }
    
}
