#  Clocks

As the core concept of how to tell time, clocks are the primary way to get started with **Time**.

## Overview

The fundamental entry point for retrieving calendrical values is via a ``RegionalClock``.

In the real world, whenever we want to know what time it is, we look at a clock on a wall or on a wrist.

The simplest way to retrieve a `RegionalClock` in the package is to ask for the system clock:

```swift
let clock = Clocks.system
```

The ``Clocks/system`` clock follows the user-visible time on the current device.
It is automatically initialized with the user's current locale, calendar, and time zone.

With the `RegionalClock` instance in-hand, you can begin asking it for the current time values:

```swift
// retrieve the current instantaneous time from the clock
let now = clock.now
```

Since the `RegionalClock` is initialized with the user's current ``Region``, you can also use it to retrieve region-specific values:

```swift
// retrieve the current calendar day, as defined by the user's region
// this represents the range of Instants in "today"
let today = clock.today()
```

With these values in-hand, you can begin using them as the basis for performing calculations or generating UI values to show to the user.

## Injecting Time

By defining the concept of a "clock" as the way to retrieve calendrical values,
we allow for much easier dependency injection of value generation.

Imagine an app that's meant to be used in conjunction with a specific event,
or an app that otherwise alters its behavior depending on the time of day (such as "make this functionality available after 3pm").

If an app is using `Date()` or `[NSDate new]` as the mechanism for knowing what time it is "now",
then validating behavioral changes based on that time becomes very difficult.

By instead relying on a ``Clock``, altering the current notion of "time" becomes much simpler.
Simply provide a `Clock` instance to the parts of your app that determine behavior,
and then you have a way to _change the clock_.

Just like you can walk over to a clock on the wall and manually change where its hands are pointing,
you can do the same to a `Clock` instance.

`Clock` provides several methods for constructing new or derivative clocks with altered time:

```swift
// this creates a Clock that is always 42 seconds ahead of the system clock
let offsetClock = aClock.offset(by: 42.0)
```
```swift
let now = Clocks.system.now

// this creates a clock that, from this point onwards, pretends that 2 seconds have passed for every second that has passed in real time 
let fastClock = Clocks.custom(startingFrom: now, rate: 2.0, region: .current)
```

So if you wanted to see how your app behaves as it approaches 3 PM,
you can construct a custom clock to start counting time from "today at 3 PM" and provide it to your code.

## Converting Between Regions

``Clock`` also has methods for building clocks in regions that are different from the current region.

For example, if you have the current system clock, but you _also_ want to know what the "current time" is in another part of the world,
**Time** makes this trivially easy:

```swift
let nycTimeZone = TimeZone(identifier: "America/New_York")!

let myClock = Clocks.system
let nycClock = myClock.converting(to: nycTimeZone)

let myLocalTime = myClock.thisMinute() // ex: 28 Feb 2020 at 3:14 PM Pacific Time

let nycLocalTime = nycClock.thisMinute() // ex: 28 Feb 2020 at 6:14 PM Eastern Time
```

## Custom Clocks

The `Clock` type is a protocol, and **Time** provides several different implementations to account for varying regions,
scaled time, and offset time.

You are welcome to create your own `Clock`-conforming types.

Having a custom clock can make unit testing and debugging extremely easy,
as a proper implementation would allow you to instanteously jump forwards or backwards through time,
or explicitly set what "now" is, and so on.

## Topics

### Core Concepts

- ``RegionalClock``
- ``Region``

### Converting Between Regions

- ``RegionalClock/converting(to:)-8ulrf``
- ``RegionalClock/converting(to:)-3fvlr``
- ``RegionalClock/converting(to:)-4u0r9``
- ``RegionalClock/converting(to:)-1h63g``

### Custom Clocks

- ``Clocks``
- ``RegionalClock/scaled(by:)``
- ``RegionalClock/offset(by:)``

### Subscribing to Changing Time

- <doc:Observation>
- ``ClockChime``
- ``RegionalClock/chime(at:)``
- ``RegionalClock/chime(when:)``
- ``RegionalClock/chime(every:startingFrom:)``


