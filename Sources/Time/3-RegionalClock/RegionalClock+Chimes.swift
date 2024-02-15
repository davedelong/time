//
//  RegionalClock+Chimes.swift
//  Time
//

import Foundation
import Dispatch

extension RegionalClock {
    
    /// Sets up a repeating chime (ex: "every 5 minutes"), optionally starting at a time other than the present instant.
    ///
    /// - Note: The first "chime" will not occur until *after* `interval` has passed beyond `startTime` (or
    ///   the immediate present if `startTime` is `nil`).
    ///
    /// - Parameters:
    ///   - interval: The amount of time that should elapse before the next chime occurs.
    ///   - startTime: The time to start counting at before the first chime occurs.
    /// - Returns: A ``ClockChime`` which emits fixed time values at the moment of each chime.
    public func chime<U: Unit>(producing unit: U.Type = U.self,
                               every interval: TimeDifference<U, Era>,
                               startingFrom startTime: Fixed<U>? = nil) -> ClockChime<U> {
        return ClockChime(clock: self, interval: interval, startTime: startTime)
    }
    
    /// Sets up a repeating chime, optionally starting at a time other than the present instant.
    ///
    /// ```
    /// // Chime every minute
    /// clock.chime(every: Minute.self)
    /// ```
    ///
    /// - Parameters:
    ///   - every: The unit of time that should elapse before the next chime occurs.
    ///   - startTime: The time to start counting at before the first chime occurs.
    /// - Returns: A ``ClockChime`` which emits fixed time values at the moment of each chime.
    public func chime<U: Unit>(every unit: U.Type,
                               startingFrom startTime: Fixed<U>? = nil) -> ClockChime<U> {
        let interval = TimeDifference<U, Era>(value: 1, unit: U.component)
        return ClockChime(clock: self, interval: interval, startTime: startTime)
    }
    
    /// Sets up a repeating chime for each unit that matches the given closure.
    ///
    /// ```
    /// // Chimes every hour at *:00, *:13, *:26, *:39, *:52
    /// clock.chime(when: { (time: Fixed<Minute>) in
    ///     time.minute % 13 == 0
    /// })
    /// ```
    ///
    /// - Parameters:
    ///   - matches: A closure which is called when each prospective unit elapses to determine
    ///   whether it should be published.
    ///   - time: A prospective time value.
    ///
    /// - Returns: A ``ClockChime`` which emits fixed time values at the moment of each chime.
    public func chime<U: Unit>(producing unit: U.Type = U.self,
                               when matches: @escaping (_ time: Fixed<U>) -> Bool) -> ClockChime<U> {
        return ClockChime(clock: self, when: matches)
    }
    
    /// Sets up a single chime (ex: "at 12:00 PM").
    ///
    /// Useful, for example, when you want the `RegionalClock` to "tell me when it's 3:00 PM."
    /// If the time has already passed, then the `ClockChime` completes immediately without sending a value.
    ///
    /// - Parameter time: The time at which the chime should occur.
    ///
    /// - Returns: A ``ClockChime`` which emits the current fixed time and then completes.
    public func chime<U: Unit>(at time: Fixed<U>) -> ClockChime<U> {
        return ClockChime(clock: self, at: time)
    }
    
}

#warning("1.0: rename Chime -> Strike?")
#warning("1.0: conform Chime: Sequence?")

/// A type representing zero or more times at which a ``RegionalClock`` will "chime".
///
/// ``ClockChime`` conforms to the `AsyncSequence` protocol and can be used in async for loops:
///
/// ```
/// for try await nextMinute in someClock.chime(every: Minute.self) {
///    // one clock minute has passed since the previous chime
///    print("The time is now \(nextMinute)")
/// }
/// ```
///
/// On platforms where the Combine framework is available, ``ClockChime`` also conforms to the `Publisher` protocol:
///
/// ```
/// someClock.chime(every: Minute.self)
///          .sink { nextMinute in
///            print("The time is now \(nextMinute")
///          }
///          .store(in: &someCancellableSet)
/// ```
public struct ClockChime<U: Unit & LTOEEra> {
    
    fileprivate let clock: any RegionalClock
    fileprivate let values: AnyIterator<Fixed<U>>
    
    private init<I: IteratorProtocol>(clock: any RegionalClock, iterator: I) where I.Element == Fixed<U> {
        self.clock = clock
        self.values = AnyIterator(iterator)
    }
    
    /// Create a chime that will emit a value after a specified calendar interval,
    /// when that value matches the provided predicate.
    ///
    /// - Parameters:
    ///   - clock: The `RegionalClock` to use for producing calendar values
    ///   - interval: The calendar interval to wait between each subsequent value
    ///   - startTime: The first time at which a value should be emitted. If this value is `nil`, the clock's current time is used.
    ///   - predicate: Only values matching this predicate will be emitted. By default, all emitted values match.
    public init(clock: any RegionalClock,
                interval: TimeDifference<U, Era>,
                startTime: Fixed<U>?,
                predicate: @escaping (_ time: Fixed<U>) -> Bool = { _ in true }) {
        
        let start = startTime ?? clock.current()
        let i = FixedSequence(start: start, stride: interval).lazy.filter(predicate).makeIterator()
        self.init(clock: clock, iterator: i)
    }
    
    /// Create a chime that emits values that match a provided predicate.
    /// - Parameters:
    ///   - clock: The `RegionalClock` to use for producing calendar values
    ///   - matches: Only values matching this predicate will be emitted.
    public init(clock: any RegionalClock, when matches: @escaping (Fixed<U>) -> Bool) {
        let interval = TimeDifference<U, Era>(value: 1, unit: U.component)
        self.init(clock: clock, interval: interval, startTime: nil, predicate: matches)
    }
    
    /// Create a chime that emits at most one value at the specified time.
    /// - Parameters:
    ///   - clock: The `RegionalClock` to use for producing calendar values.
    ///   - time: The time at which to emit the value. If this value is in the past, then the `ClockChime` emits no values.
    public init(clock: any RegionalClock, at time: Fixed<U>) {
        let current = clock.current(U.self)
        var values = Array<Fixed<U>>()
        if time >= current {
            values = [time]
        }
        self.init(clock: clock, iterator: values.makeIterator())
    }
    
}

extension ClockChime: AsyncSequence {
    
    public typealias Element = Fixed<U>
    
    public struct AsyncIterator: AsyncIteratorProtocol {
        public typealias Element = Fixed<U>
        
        fileprivate let clock: any RegionalClock
        fileprivate var baseIterator: AnyIterator<Element>
        
        public mutating func next() async throws -> Fixed<U>? {
            var nextTime: Fixed<U>? = baseIterator.next()
            let now = clock.current(U.self)
            while let next = nextTime, next < now {
                nextTime = baseIterator.next()
            }
            
            guard let next = nextTime else { return nil }
            
            try await clock.sleep(until: next.firstInstant, tolerance: nil)
            return next
        }
        
    }
    
    public func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator(clock: self.clock, baseIterator: self.values)
    }
    
}

#if canImport(Combine)

import Combine

extension ClockChime: Combine.Publisher {
    
    public typealias Output = Fixed<U>
    public typealias Failure = Never
    
    /// Set up a new Combine subscription for this `ClockChime`
    /// - Parameter subscriber: The subscriber that receives chime events
    public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = ChimeSubscription(subscriber: subscriber,
                                             clock: clock,
                                             iterator: values)
        subscriber.receive(subscription: subscription)
    }
    
}

private class ChimeSubscription<SubscriberType, U>: Subscription
    where U: Unit,
          SubscriberType: Subscriber,
          SubscriberType.Failure == ClockChime<U>.Failure,
          SubscriberType.Input == ClockChime<U>.Output {
    
    private var subscriber: SubscriberType?
    private let clock: any RegionalClock
    private var timeIterator: AnyIterator<Fixed<U>>
    private var nextChime: DispatchWorkItem?
    
    init(subscriber: SubscriberType, clock: any RegionalClock, iterator: AnyIterator<Fixed<U>>) {
        self.subscriber = subscriber
        self.clock = clock
        self.timeIterator = iterator
        
        scheduleNextChime()
    }
    
    private func scheduleNextChime() {
        var nextTime: Fixed<U>? = timeIterator.next()
        let now = clock.current(U.self)
        while let next = nextTime, next < now {
            // make sure we never chime anything in the past
            nextTime = timeIterator.next()
        }
        
        guard let nextChimeTime = nextTime else {
            subscriber?.receive(completion: .finished)
            cancel()
            return
        }
        
        let clockNow = clock.now
        let chimeInstant = nextChimeTime.firstInstant
        
        let realSecondsUntilChime: TimeInterval
        
        if chimeInstant <= clockNow {
            // chime already passed
            // chime immediately
            realSecondsUntilChime = 0
        } else {
            let clockSecondsUntilChime = chimeInstant - clockNow
            realSecondsUntilChime = (clockSecondsUntilChime / clock.SISecondsPerClockSecond).timeInterval
        }
        let chime = DispatchWorkItem { [weak self] in
            self?.performChime(at: nextChimeTime)
        }
        nextChime = chime
        DispatchQueue.main.asyncAfter(deadline: .now() + realSecondsUntilChime, execute: chime)
    }
    
    private func performChime(at time: Fixed<U>) {
        nextChime = nil
        _ = subscriber?.receive(time)
        scheduleNextChime()
    }
    
    public func request(_ demand: Subscribers.Demand) {
        // We ignore this, since time doesn't care when we're looking.
    }
    
    public func cancel() {
        nextChime?.cancel()
        nextChime = nil
        subscriber = nil
    }
}
#endif
