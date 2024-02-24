import Foundation

extension RegionalClock {
    
    /// Sets up a repeating strike (ex: "every 5 minutes"), optionally starting at a time other than the present instant.
    ///
    /// - Note: The first "strike" will not occur until *after* `interval` has passed beyond `startTime` (or
    ///   the immediate present if `startTime` is `nil`).
    ///
    /// - Parameters:
    ///   - interval: The amount of time that should elapse before the next strike occurs.
    ///   - startTime: The time to start counting at before the first strike occurs.
    /// - Returns: A ``ClockStrikes`` which emits fixed time values at the moment of each strike.
    public func strike<U: Unit>(producing unit: U.Type = U.self,
                                every interval: TimeDifference<U, Era>,
                                startingFrom startTime: Fixed<U>? = nil) -> ClockStrikes<U> {
        return ClockStrikes(clock: self, interval: interval, startTime: startTime)
    }
    
    /// Sets up a repeating strike, optionally starting at a time other than the present instant.
    ///
    /// ```
    /// // Strike every minute
    /// clock.strike(every: Minute.self)
    /// ```
    ///
    /// - Parameters:
    ///   - every: The unit of time that should elapse before the next strike occurs.
    ///   - startTime: The time to start counting at before the first strike occurs.
    /// - Returns: A ``ClockStrikes`` which emits fixed time values at the moment of each strike.
    public func strike<U: Unit>(every unit: U.Type,
                                startingFrom startTime: Fixed<U>? = nil) -> ClockStrikes<U> {
        let interval = TimeDifference<U, Era>(value: 1, unit: U.component)
        return ClockStrikes(clock: self, interval: interval, startTime: startTime)
    }
    
    /// Sets up a repeating strike for each unit that matches the given closure.
    ///
    /// ```
    /// // Strike every hour at *:00, *:13, *:26, *:39, *:52
    /// clock.strike(when: { (time: Fixed<Minute>) in
    ///     time.minute % 13 == 0
    /// })
    /// ```
    ///
    /// - Parameters:
    ///   - matches: A closure which is called when each prospective unit elapses to determine
    ///   whether it should be published.
    ///   - time: A prospective time value.
    ///
    /// - Returns: A ``ClockStrikes`` which emits fixed time values at the moment of each strike.
    public func strike<U: Unit>(producing unit: U.Type = U.self,
                                when matches: @escaping (_ time: Fixed<U>) -> Bool) -> ClockStrikes<U> {
        return ClockStrikes(clock: self, when: matches)
    }
    
    /// Sets up a single strike (ex: "at 12:00 PM").
    ///
    /// Useful, for example, when you want the `RegionalClock` to "tell me when it's 3:00 PM."
    /// If the time has already passed, then the `ClockStrikes` completes immediately without sending a value.
    ///
    /// - Parameter time: The time at which the strike should occur.
    ///
    /// - Returns: A ``ClockStrikes`` which emits the current fixed time and then completes.
    public func strike<U: Unit>(at time: Fixed<U>) -> ClockStrikes<U> {
        return ClockStrikes(clock: self, at: time)
    }
    
}

/// A type representing zero or more times at which a ``RegionalClock`` will "strike".
///
/// ``ClockStrikes`` provides a value that conforms to the `AsyncSequence` protocol and can be used in for loops:
///
/// ```swift
/// for try await nextMinute in someClock.strike(every: Minute.self).asyncValues {
///    // one clock minute has passed since the previous strike
///    print("The time is now \(nextMinute)")
/// }
/// ```
///
/// On platforms where the Combine framework is available, ``ClockStrikes`` also provides a `Publisher`:
///
/// ```swift
/// someClock.strike(every: Minute.self)
///          .publisher
///          .sink { nextMinute in
///            print("The time is now \(nextMinute)")
///          }
///          .store(in: &someCancellableSet)
/// ```
///
/// - SeeAlso: [Striking Clocks (Wikipedia)](https://en.wikipedia.org/wiki/Striking_clock)
public struct ClockStrikes<U: Unit & LTOEEra> {
    
    fileprivate let clock: any RegionalClock
    fileprivate let iterator: AnyIterator<Fixed<U>>
    
    private init<I: IteratorProtocol>(clock: any RegionalClock, iterator: I) where I.Element == Fixed<U> {
        self.clock = clock
        self.iterator = AnyIterator(iterator)
    }
    
    /// Create a `ClockStrikes` that will emit a value after a specified calendar interval,
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
    
    /// Create a `ClockStrikes` that emits values that match a provided predicate.
    /// - Parameters:
    ///   - clock: The `RegionalClock` to use for producing calendar values
    ///   - matches: Only values matching this predicate will be emitted.
    public init(clock: any RegionalClock, when matches: @escaping (Fixed<U>) -> Bool) {
        let interval = TimeDifference<U, Era>(value: 1, unit: U.component)
        self.init(clock: clock, interval: interval, startTime: nil, predicate: matches)
    }
    
    /// Create a `ClockStrikes` that emits at most one value at the specified time.
    /// - Parameters:
    ///   - clock: The `RegionalClock` to use for producing calendar values.
    ///   - time: The time at which to emit the value. If this value is in the past, then the `ClockStrikes` emits no values.
    public init(clock: any RegionalClock, at time: Fixed<U>) {
        let current = clock.current(U.self)
        var values = Array<Fixed<U>>()
        if time >= current {
            values = [time]
        }
        self.init(clock: clock, iterator: values.makeIterator())
    }
    
}

extension ClockStrikes {
    
    /// The values at which the clock will strike, as a synchronous sequence
    public struct Values: Sequence {
        public typealias Element = Fixed<U>
        
        let strikes: ClockStrikes
        
        public func makeIterator() -> AnyIterator<Fixed<U>> {
            return strikes.iterator
        }
        
    }
    
    /// Retrieve the values at which the clock will strike
    public var values: Values {
        Values(strikes: self)
    }
    
}

extension ClockStrikes {

    /// The values at which the clock will strikes, as an asynchronous sequence
    public struct AsyncValues: AsyncSequence {
        
        public typealias Element = Fixed<U>
        
        internal let strikes: ClockStrikes
        
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
            return AsyncIterator(clock: self.strikes.clock, baseIterator: self.strikes.iterator)
        }
        
    }
    
    /// Retrieve the asynchronous values at which the clock will strike
    ///
    /// This value can be used in an async loop, such as:
    ///
    /// ```swift
    /// let strikes = someClock.strike(every: Minute.self)
    ///
    /// for try await currentTime in strikes.asyncValues {
    ///      print("The time is now \(currentTime)")
    /// }
    /// ```
    public var asyncValues: AsyncValues {
        return AsyncValues(strikes: self)
    }
    
}

#if canImport(Combine)

import Combine
import Dispatch

extension ClockStrikes {
    
    /// The values at which the clock will strikes, as a Combine publisher
    ///
    /// - Warning: This publisher produces values on an undefined scheduler. If you need to receive
    /// updates on a particular Scheduler, use the `.receive(on:)` operator. 
    public struct Publisher: Combine.Publisher {
        
        internal let strikes: ClockStrikes
        
        public typealias Output = Fixed<U>
        public typealias Failure = Never
        
        /// Set up a new Combine subscription for this `ClockStrikes`
        /// - Parameter subscriber: The subscriber that receives strike events
        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = StrikesSubscription<S, U>(subscriber: subscriber,
                                                         clock: strikes.clock,
                                                         iterator: strikes.iterator)
            subscriber.receive(subscription: subscription)
        }
    }
    
    /// Retrieve the publisher which emits the values at which the clock will strike
    ///
    /// - Warning: This publisher produces values on an undefined scheduler. If you need to receive
    /// updates on a particular Scheduler, use the `.receive(on:)` operator.
    public var publisher: Publisher {
        return Publisher(strikes: self)
    }
    
}

private class StrikesSubscription<SubscriberType, U>: Subscription
    where U: Unit,
          SubscriberType: Subscriber,
          SubscriberType.Failure == ClockStrikes<U>.Publisher.Failure,
          SubscriberType.Input == ClockStrikes<U>.Publisher.Output {
    
    private var subscriber: SubscriberType?
    private let clock: any RegionalClock
    private var timeIterator: AnyIterator<Fixed<U>>
    private var nextStrike: CancellationToken?
    
    init(subscriber: SubscriberType, clock: any RegionalClock, iterator: AnyIterator<Fixed<U>>) {
        self.subscriber = subscriber
        self.clock = clock
        self.timeIterator = iterator
        
        scheduleNextStrike()
    }
    
    private func scheduleNextStrike() {
        var nextTime: Fixed<U>? = timeIterator.next()
        let now = clock.current(U.self)
        while let next = nextTime, next < now {
            // make sure we never strike anything in the past
            nextTime = timeIterator.next()
        }
        
        guard let nextStrikeTime = nextTime else {
            subscriber?.receive(completion: .finished)
            cancel()
            return
        }
        
        let strikeInstant = nextStrikeTime.firstInstant
        self.nextStrike = clock.wait(until: strikeInstant, tolerance: nil, strike: { [weak self] in
            self?.performStrike(at: nextStrikeTime)
        })
    }
    
    private func performStrike(at time: Fixed<U>) {
        nextStrike = nil
        _ = subscriber?.receive(time)
        scheduleNextStrike()
    }
    
    public func request(_ demand: Subscribers.Demand) {
        // We ignore this, since time doesn't care when we're looking.
    }
    
    public func cancel() {
        nextStrike?.cancel()
        nextStrike = nil
        subscriber = nil
    }
}
#endif
