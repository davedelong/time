# Observing Time Changes

Overview on how to receive notifications when significant time events occur with **Combine**.

On platforms that have the [`Combine` framework](https://developer.apple.com/documentation/combine),
**Time** provides a way for ``Clock`` instances to notify when significant time events occur.

There are three main waits to observe time changes.

### Observing Intervals

The ``Clock/chime(every:startingFrom:)`` method allows you to create a publisher ``ClockChime``
that will emit events after a particular calendrical interval has elapsed.

A simple example of this would be to be notified when every 2 seconds have passed:

```swift
clock
    .chime(every: .seconds(2))
    .sink { (value: Absolute<Second>) in
        print("Another 2 seconds have passed. It is now \(value)")
    }
    .store(in: &cancellables)
```

By default, the `chime(every:)` method starts counting from the current time shown on the clock.

However, if you'd like to start counting for a particular point (such as the beginning of the next minute or at the start of the next hour),
you may also optionally specify the `startingFrom:` parameter:

```swift
let startOfNextHour = clock.nextHour().firstMinute
clock
    .chime(every: .minutes(5), startingFrom: startOfNextHour)
    .sink { value in
        print("The time is now \(value)")
    }
    .store(in: &cancellables)
```

### Observing Arbitrary Values

Sometimes you want to be notified when the time on a clock matches some indetermine set of requirements,
such as "The minute must be evenly divisible by 7".

To do this, use the ``Clock/chime(when:)`` method:

```swift
clock
    .chime(when: { $0.minute.isMultiple(of: 7) })
    .sink { (value: Absolute<Minute>) in
        print("The time is now \(value)")
    }
    .store(in: &cancellables)
```

### Observing Once

**Time** also makes it easy to be notified when the time on a clock is a certain value with the ``Clock/chime(at:)`` method. 

```swift
let startOfNextHour = clock.nextHour()
clock
    .chime(at: startOfNextHour)
    .sink { value in
        print("The time is now \(value)")
    }
    .store(in: &cancellables)
```

This publisher will fire at most one time.

If the specified time is in the past, then the publisher will complete immediately without emitting any values. 

## Notes

The ability to be notified about time changes can be incredibly useful. As you use this feature, please keep in mind these points:

### Clock rate

The "chiming" of the clock factors in the *rate* at which time passes on the clock.

If you have created a custom ``Clock`` where every second "in real life" means that a minute has passed on the clock,
then the `Clock` would notify you every second that one minute has passed.

You can see an example of this in the unit tests.

### Precision

Even though **Time** _technically_ supports precision down to the ``Nanosecond``,
it is very difficult to get notifications timed to be more accurate than about every 2 milliseconds.

Thus, it is possible that you may see slight inaccuracies if you're asking for nanosecond intervals between chime times,
or if you're working with a ``Clock`` that are scaled to run faster than about 500 times real speed.

### Performance

When using the ``Clock/chime(every:startingFrom:)`` method,
avoid choosing start times that are "far away" from your desired next chime time.

In order to correctly determine chime times,
the underlying code must iterate through *every possible value* between the start time and "now" to make sure that it stays calendrically accurate.

For example, if you're wanting to receive a chime every minute, but your start date is a month ago,
the publisher must first calculate *every minute in the past month* in order to figure out the next matching time.

Wisely choosing a start time can drastically affect the accuracy of delivering the first chime.
