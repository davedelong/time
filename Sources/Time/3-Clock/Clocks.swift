//
//  File.swift
//  
//
//  Created by Dave DeLong on 4/17/21.
//

import Foundation

public enum Clocks {
    
    /// The system clock. This `Clock` uses the current `Region` and follows the current device time.
    public static let system: Clock = _SystemClock(region: .autoupdatingCurrent)
    
    /// A POSIX clock. This `Clock` uses the POSIX `Region` and follows the current device time.
    public static let posix: Clock = _SystemClock(region: .posix)
    
    /// Create a clock that follows the current device time,
    /// but produces calendar values according to the specified `Region`.
    public static func system(in region: Region) -> Clock {
        return _SystemClock(region: region)
    }
    
    /// Create a clock with a custom start time and flow rate.
    ///
    /// - Parameters:
    ///   - referenceDate: The instantaneous "now" from which the clock will start counting.
    ///   - rate: The rate at which time progresses in the clock, relative to the supplied calendar.
    ///     - `1.0` (the default) means one second on the system clock correlates to a second passing in the clock.
    ///     - `2.0` would mean that every second elapsing on the system clock would be 2 seconds on this clock (ie, time progresses twice as fast).
    ///   - region: The Region in which calendar values are produced.
    public static func custom(startingFrom referenceInstant: Instant, rate: Double = 1.0, region: Region = .autoupdatingCurrent) -> Clock {
        guard rate > 0 else {
            fatalError("You cannot create a clock where time has stopped or flows backwards")
        }
        
        return _CustomClock(referenceInstant: referenceInstant,
                           rate: rate,
                           region: region)
    }
    
    /// Create a clock with a custom start time and flow rate.
    ///
    /// - Parameters:
    ///   - referenceEpoch: The instantaneous "now" from which the clock will start counting.
    ///   - rate: The rate at which time progresses in the clock.
    ///     - `1.0` (the default) means one second on the system clock correlates to a second passing in the clock.
    ///     - `2.0` would mean that every second elapsing on the system clock would be 2 seconds on this clock (ie, time progresses twice as fast).
    ///   - region: The `Region` in which calendar values are produced.
    public static func custom(startingFrom referenceEpoch: Epoch, rate: Double = 1.0, region: Region = .autoupdatingCurrent) -> Clock {
        let referenceInstant = Instant(interval: 0, since: referenceEpoch)
        return self.custom(startingFrom: referenceInstant, rate: rate, region: region)
    }
}

#if swift(>=5.5)
extension Clock where Self == _CustomClock {
  /// Create a clock with a custom start time and flow rate.
  ///
  /// - Parameters:
  ///   - referenceDate: The instantaneous "now" from which the clock will start counting.
  ///   - rate: The rate at which time progresses in the clock, relative to the supplied calendar.
  ///     - `1.0` (the default) means one second on the system clock correlates to a second passing in the clock.
  ///     - `2.0` would mean that every second elapsing on the system clock would be 2 seconds on this clock (ie, time progresses twice as fast).
  ///   - region: The Region in which calendar values are produced.
  public static func custom(startingFrom referenceInstant: Instant, rate: Double = 1.0, region: Region = .autoupdatingCurrent) -> Clock {
    return Clocks.custom(startingFrom: referenceInstant, rate: rate, region: region)
  }

  /// Create a clock with a custom start time and flow rate.
  ///
  /// - Parameters:
  ///   - referenceEpoch: The instantaneous "now" from which the clock will start counting.
  ///   - rate: The rate at which time progresses in the clock.
  ///     - `1.0` (the default) means one second on the system clock correlates to a second passing in the clock.
  ///     - `2.0` would mean that every second elapsing on the system clock would be 2 seconds on this clock (ie, time progresses twice as fast).
  ///   - region: The `Region` in which calendar values are produced.
  public static func custom(startingFrom referenceEpoch: Epoch, rate: Double = 1.0, region: Region = .autoupdatingCurrent) -> Clock {
    return Clocks.custom(startingFrom: referenceEpoch, rate: rate, region: region)
  }
}

extension Clock where Self == _SystemClock {
  /// The system clock. This `Clock` uses the current `Region` and follows the current device time.
  public static var system: Clock { Clocks.system }

  /// A POSIX clock. This `Clock` uses the POSIX `Region` and follows the current device time.
  public static var posix: Clock { Clocks.posix }

  /// Create a clock that follows the current device time,
  /// but produces calendar values according to the specified `Region`.
  public static func system(in region: Region) -> Clock {
    return Clocks.system(in: region)
  }
}
#endif
