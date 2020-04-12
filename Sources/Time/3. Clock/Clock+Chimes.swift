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
    public func chime<U>(every interval: Difference<U, Era>,
                         startingFrom startTime: Absolute<U>? = nil) -> Clock.IntervalChime<U> where U: Unit {
        return Clock.IntervalChime(for: self,
                                   interval: interval,
                                   startTime: startTime)
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
    ///   - time: A propspective time value.
    ///
    /// - Returns: A publisher which publishes absolute time values at the moment of each chime.
    public func chime<U>(when matches: @escaping (_ time: Absolute<U>) -> Bool) -> Clock.IntervalChime<U> where U: Unit {
        let interval = Difference<U, Era>(value: 1, unit: U.component)
        return Clock.IntervalChime(for: self,
                                   interval: interval,
                                   startTime: self.this(),
                                   predicate: matches)
    }
    
    /// Sets up a single chime (ex: "at 12:00 PM").
    ///
    /// Useful, for example, when you want the `Clock` to "tell me when it's 3:00 PM."
    ///
    /// - Parameter time: The time at which the chime should occur.
    ///
    /// - Returns: A publisher which publishes the current absolute time and then completes.
    public func chime<U>(at time: Absolute<U>) -> Clock.AbsoluteChime<U> where U: Unit {
        return Clock.AbsoluteChime(for: self, firstInstantOf: time)
    }
    
}

private extension Value {
    
    /// Returns the `TimeInterval` (number of seconds) from this `Value` to the `next`.
    ///
    /// For example, May 5 at 3:02:26 and May 5 at 3:02:30 are 4 seconds apart. The opposite
    /// would return a negative value.
    func seconds(to next: Self) -> TimeInterval {
        let now = self
        let then = next
        let nowSeconds = now.firstInstant.intervalSinceEpoch.rawValue
        let thenSeconds = then.firstInstant.intervalSinceEpoch.rawValue
        
        return thenSeconds - nowSeconds
    }
    
}

// MARK: - Interval Chime

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Clock {
    
    public final class IntervalChimeSubscription<SubscriberType, Unit>: Subscription
        where Unit: Time.Unit,
        SubscriberType: Subscriber,
        SubscriberType.Failure == Clock.IntervalChime<Unit>.Failure,
        SubscriberType.Input == Clock.IntervalChime<Unit>.Output {
        
        private var subscriber: SubscriberType?
        private let clock: Clock
        private let predicate: (Absolute<Unit>) -> Bool
        private let timer: DispatchSourceTimer
        
        init(subscriber: SubscriberType,
             clock: Clock,
             interval: Difference<Unit, Era>,
             startingAt startTime: Absolute<Unit>?,
             predicate: @escaping (_ time: Absolute<Unit>) -> Bool) {
            self.subscriber = subscriber
            self.clock = clock
            self.predicate = predicate
            
            // start waiting...
            self.timer = DispatchSource.makeTimerSource(flags: .strict)
            timer.setEventHandler(handler: performChime)
            let now: Absolute<Unit> = clock.this()
            let start = startTime ?? now
            
            let secondsToStart = now.seconds(to: start)
            let firstTick = start.applying(difference: interval)
            let repeatInterval = start.seconds(to: firstTick)
            
            let rate = clock.rate
            // First chime (deadline) happens after delay and first elapsed interval
            timer.schedule(deadline: .now() + (secondsToStart / rate) + (repeatInterval / rate),
                           repeating: (repeatInterval / rate))
            timer.activate()
        }
        
        private func performChime() {
            let value: Absolute<Unit> = clock.this()
            guard predicate(value) else { return }
            _ = subscriber?.receive(value)
        }
        
        public func request(_ demand: Subscribers.Demand) {
            // We ignore this, since time doesn't care when we're looking.
        }
        
        public func cancel() {
            timer.cancel()
            subscriber = nil
        }
    }
    
    /// A publisher which publishes repeatedly—each time a given `Clock` reads that a specified time interval
    /// has elapsed.
    public struct IntervalChime<Unit>: Combine.Publisher where Unit: Time.Unit {
        
        public typealias Output = Absolute<Unit>
        public typealias Failure = Never
        
        /// The clock that the publisher watches for time events.
        public var clock: Clock
        
        /// The time interval between chimes.
        public var interval: Difference<Unit, Era>
        
        /// The time at which to start chiming.
        ///
        /// If found to be `nil` when a subscriber requests values, then the present time is assumed.
        public var startTime: Absolute<Unit>?
        
        /// A predicate to use which determines whether a time value will be published.
        ///
        /// Defaults to a closure that always returns `true`.
        public var predicate: (Absolute<Unit>) -> Bool
        
        public init(for clock: Clock,
                    interval: Difference<Unit, Era>,
                    startTime: Absolute<Unit>?,
                    predicate: @escaping (_ time: Absolute<Unit>) -> Bool = { _ in true }) {
            self.clock = clock
            self.interval = interval
            self.startTime = startTime
            self.predicate = predicate
        }
        
        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription =
                IntervalChimeSubscription(subscriber: subscriber,
                                          clock: clock,
                                          interval: interval,
                                          startingAt: startTime,
                                          predicate: predicate)
            subscriber.receive(subscription: subscription)
        }
        
    }
}

// MARK: - Absolute Chime

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Clock {
    
    /// A subscription to a `Clock.AbsoluteChime`.
    public final class AbsoluteChimeSubscription<SubscriberType, Unit>: Subscription
        where Unit: Time.Unit,
        SubscriberType: Subscriber,
        SubscriberType.Failure == Clock.AbsoluteChime<Unit>.Failure,
        SubscriberType.Input == Clock.AbsoluteChime<Unit>.Output {
        
        private var subscriber: SubscriberType?
        private let clock: Clock
        private let timer: DispatchSourceTimer
        
        init(subscriber: SubscriberType, clock: Clock, value: Absolute<Unit>) {
            self.subscriber = subscriber
            self.clock = clock
            
            // start waiting...
            self.timer = DispatchSource.makeTimerSource(flags: .strict)
            timer.setEventHandler(handler: performChime)
            let now: Absolute<Unit> = clock.this()
            let then = value
            let normalInterval = now.seconds(to: then)
            
            let rate = clock.rate
            let difference = (normalInterval) / rate
            // Chime (deadline) happens after first elapsed interval
            timer.schedule(deadline: .now() + difference)
            timer.activate()
        }
        
        private func performChime() {
            _ = subscriber?.receive(clock.this())
            subscriber?.receive(completion: .finished)
            subscriber = nil
        }
        
        public func request(_ demand: Subscribers.Demand) {
            // We ignore this, since time doesn't care when we're looking.
        }
        
        public func cancel() {
            timer.cancel()
            subscriber = nil
        }
    }
    
    /// A publisher which publishes exactly once—when a given `Clock` reads a specified time—and then completes.
    public struct AbsoluteChime<Unit>: Publisher where Unit: Time.Unit {
        
        public typealias Output = Absolute<Unit>
        public typealias Failure = Never
        
        /// The clock that the publisher watches for time events.
        public var clock: Clock
        
        /// The time at which to chime.
        public var value: Absolute<Unit>
        
        public init(for clock: Clock, firstInstantOf value: Absolute<Unit>) {
            self.clock = clock
            self.value = value
        }
        
        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription =
                AbsoluteChimeSubscription(
                    subscriber: subscriber,
                    clock: clock,
                    value: value)
            subscriber.receive(subscription: subscription)
        }
        
    }
    
}
#endif
