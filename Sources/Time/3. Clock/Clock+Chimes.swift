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
    /// - Parameters:
    ///   - interval: The amount of time that should elapse before the next chime occurs.
    ///   - startTime: The time to start counting at before the first chime occurs.
    /// - Returns: A publisher which publishes absolute time values at the moment of each chime.
    public func chime<S, L>(every interval: Difference<S, L>,
                            startingFrom startTime: Absolute<S>? = nil) -> Clock.IntervalChime<S> where S: Unit, L: Unit {
        return Clock.IntervalChime<S>(clock: self)
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
    public func chime<U: Unit>(when matches: @escaping (_ time: Absolute<U>) -> Bool) -> AnyPublisher<Absolute<U>, Never> {
        let startTime: Absolute<U> = self.this()
        let interval = Difference<U, Era>(value: 1, unit: U.component)
        return chime(every: interval, startingFrom: startTime)
           .filter(matches)
           .eraseToAnyPublisher()
    }
    
    /// Sets up a single chime (ex: "at 12:00 PM").
    ///
    /// Useful, for example, when you want the `Clock` to "tell me when it's 3:00 PM."
    ///
    /// - Parameter time: The time at which the chime should occur.
    ///
    /// - Returns: A publisher which publishes the current absolute time and then completes.
    public func chime<U>(at time: Absolute<U>) -> Clock.AbsoluteChime<U> where U: Unit {
        return Clock.AbsoluteChime<U>(for: self, atFirstInstantOf: time)
    }
    
}

// MARK: - Interval Chime

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Clock {
    
    public struct IntervalChime<Unit>: Combine.Publisher where Unit: Time.Unit {
        
        public typealias Output = Absolute<Unit>
        public typealias Failure = Never
        
        /// The clock that the publisher watches for time events.
        public let clock: Clock
        
        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            _ = subscriber.receive(clock.this())
        }
        
    }
}

// MARK: - Absolute Chime

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Clock {
    
    public final class AbsoluteChimeSubscription<SubscriberType, SmallestUnit>: Combine.Subscription
        where SmallestUnit: Unit,
        SubscriberType: Subscriber,
        SubscriberType.Failure == Clock.AbsoluteChime<SmallestUnit>.Failure,
        SubscriberType.Input == Clock.AbsoluteChime<SmallestUnit>.Output {
        
        private var subscriber: SubscriberType?
        private let clock: Clock
        private let value: Absolute<SmallestUnit>
        private let timer: DispatchSourceTimer
        
        init(subscriber: SubscriberType, clock: Clock, value: Absolute<SmallestUnit>) {
            self.subscriber = subscriber
            self.clock = clock
            self.value = value
            
            // start waiting...
            self.timer = DispatchSource.makeTimerSource(flags: .strict)
            timer.setEventHandler(handler: performChime)
            let now: Absolute<SmallestUnit> = clock.this()
            let then = value
            let nowSeconds = now.firstInstant.intervalSinceEpoch.rawValue
            let thenSeconds = then.firstInstant.intervalSinceEpoch.rawValue
            
            let rate = clock.rate
            let difference = (thenSeconds - nowSeconds) / rate
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
    
    /// A publisher which fires exactly once and then completes.
    public struct AbsoluteChime<Unit>: Combine.Publisher where Unit: Time.Unit {
        
        public typealias Output = Absolute<Unit>
        public typealias Failure = Never
        
        /// The clock that the publisher watches for time events.
        public let clock: Clock
        public let value: Absolute<Unit>
        
        init(for clock: Clock, atFirstInstantOf value: Absolute<Unit>) {
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
