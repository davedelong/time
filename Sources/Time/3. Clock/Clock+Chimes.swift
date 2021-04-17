//
//  Clock+Chimes.swift
//  Time
//
//  Created by James Robinson on 4/11/20.
//

#if canImport(Combine)
import Foundation
import Dispatch
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Clock {
    
    /// Sets up a repeating chime (ex: "every 5 minutes"), optionally starting at a time other than the present instant.
    ///
    /// - Note: The first "chime" will not occur until *after* `interval` has passed beyond `startTime` (or
    ///   the immediate present if `startTime` is `nil`).
    ///
    /// - Parameters:
    ///   - interval: The amount of time that should elapse before the next chime occurs.
    ///   - startTime: The time to start counting at before the first chime occurs.
    /// - Returns: A publisher which publishes absolute time values at the moment of each chime.
    public func chime<U: Unit>(every interval: TimeDifference<U, Era>,
                               startingFrom startTime: Absolute<U>? = nil) -> ClockChime<U> {
        return ClockChime(clock: self, interval: interval, startTime: startTime)
    }
    
    /// Sets up a repeating chime for each unit that matches the given closure.
    ///
    /// For example:
    /// ```
    /// // Chimes every hour at *:00, *:13, *:26, *:39, *:52
    /// clock.chime(when: { (time: Absolute<Minute>) in
    ///     time.minute % 13 == 0
    /// })
    /// ```
    ///
    /// - Parameters:
    ///   - matches: A closure which is called when each prospective unit elapses to determine
    ///   whether it should be published.
    ///   - time: A prospective time value.
    ///
    /// - Returns: A publisher which publishes absolute time values at the moment of each chime.
    public func chime<U: Unit>(when matches: @escaping (_ time: Absolute<U>) -> Bool) -> ClockChime<U> {
        return ClockChime(clock: self, when: matches)
    }
    
    /// Sets up a single chime (ex: "at 12:00 PM").
    ///
    /// Useful, for example, when you want the `Clock` to "tell me when it's 3:00 PM."
    /// If the time has already passed, then the publisher completes immediately without sending a value.
    ///
    /// - Parameter time: The time at which the chime should occur.
    ///
    /// - Returns: A publisher which publishes the current absolute time and then completes.
    public func chime<U: Unit>(at time: Absolute<U>) -> ClockChime<U> {
        return ClockChime(clock: self, at: time)
    }
    
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct ClockChime<U: Unit>: Combine.Publisher {
    
    public typealias Output = Absolute<U>
    public typealias Failure = Never
    
    private let clock: Clock
    private let values: AnyIterator<Absolute<U>>
    
    private init<I: IteratorProtocol>(clock: Clock, iterator: I) where I.Element == Absolute<U> {
        self.clock = clock
        self.values = AnyIterator(iterator)
    }
    
    /// Create a publisher that will emit a value after a specified calendar interval,
    /// when that value matches the provided predicate.
    ///
    /// - Parameters:
    ///   - clock: The `Clock` to use for producing calendar values
    ///   - interval: The calendar interval to wait between each subsequent value
    ///   - startTime: The first time at which a value should be emitted. If this value is `nil`, the clock's current time is used.
    ///   - predicate: Only values matching this predicate will be emitted. By default, all emitted values match.
    public init(clock: Clock,
                interval: TimeDifference<U, Era>,
                startTime: Absolute<U>?,
                predicate: @escaping (_ time: Absolute<U>) -> Bool = { _ in true }) {
        
        let start = startTime ?? clock.this()
        let i = AbsoluteTimePeriodSequence(start: start, stride: interval).lazy.filter(predicate).makeIterator()
        self.init(clock: clock, iterator: i)
    }
    
    /// Create a publisher that emits values that match a provided predicate.
    /// - Parameters:
    ///   - clock: The `Clock` to use for producing calendar values
    ///   - matches: Only values matching this predicate will be emitted.
    public init(clock: Clock, when matches: @escaping (Absolute<U>) -> Bool) {
        let interval = TimeDifference<U, Era>(value: 1, unit: U.component)
        self.init(clock: clock, interval: interval, startTime: nil, predicate: matches)
    }
    
    /// Create a publisher that emits at most one value at the specified time.
    /// - Parameters:
    ///   - clock: The `Clock` to use for producing calendar values.
    ///   - time: The time at which to emit the value. If this value is in the past, then the publisher immediately completes.
    public init(clock: Clock, at time: Absolute<U>) {
        let current: Absolute<U> = clock.this()
        var values = Array<Absolute<U>>()
        if time >= current {
            values = [time]
        }
        self.init(clock: clock, iterator: values.makeIterator())
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = ChimeSubscription(subscriber: subscriber,
                                             clock: clock,
                                             iterator: values)
        subscriber.receive(subscription: subscription)
    }
    
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
private class ChimeSubscription<SubscriberType, U>: Subscription
    where U: Unit,
    SubscriberType: Subscriber,
    SubscriberType.Failure == ClockChime<U>.Failure,
SubscriberType.Input == ClockChime<U>.Output {
    
    private var subscriber: SubscriberType?
    private let clock: Clock
    private var timeIterator: AnyIterator<Absolute<U>>
    private var nextChime: DispatchWorkItem?
    
    init(subscriber: SubscriberType, clock: Clock, iterator: AnyIterator<Absolute<U>>) {
        self.subscriber = subscriber
        self.clock = clock
        self.timeIterator = iterator
        
        scheduleNextChime()
    }
    
    private func scheduleNextChime() {
        var nextTime: Absolute<U>? = timeIterator.next()
        let now: Absolute<U> = clock.this()
        while let next = nextTime, next < now {
            nextTime = timeIterator.next()
        }
        
        guard let nextChimeTime = nextTime else {
            subscriber?.receive(completion: .finished)
            cancel()
            return
        }
        
        let clockNow = clock.now()
        let chimeInstant = nextChimeTime.firstInstant
        
        let realSecondsUntilChime: TimeInterval
        
        if chimeInstant <= clockNow {
            // chime already passed
            // chime immediately
            realSecondsUntilChime = 0
        } else {
            let clockSecondsUntilChime = chimeInstant - clockNow
            realSecondsUntilChime = (clockSecondsUntilChime / clock.SISecondsPerRealSecond).rawValue
        }
        let chime = DispatchWorkItem { [weak self] in
            self?.performChime(at: nextChimeTime)
        }
        nextChime = chime
        DispatchQueue.main.asyncAfter(deadline: .now() + realSecondsUntilChime, execute: chime)
    }
    
    private func performChime(at time: Absolute<U>) {
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
