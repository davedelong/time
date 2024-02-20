# Basic Usage

An overview of **Time**'s basic features and common use-cases.

### Getting the current time

The current time is retrieved via the ``Clocks/system``, which provides the time based on the user's device and preferences:

```swift
let systemClock = Clocks.system
let thisMinute = systemClock.currentMinute
```

All ``RegionalClock`` values have many methods for getting [fixed values](<doc:Fixed>) of varying specificity.

### Finding future values

All fixed values have a wide array of methods for manipulating them. These methods can be used to *adjust* the value by a specific amount, or find the "next" value, and so on:

```swift
let systemClock = Clocks.system
let thisMinute = systemClock.currentMinute

// add one minute:
let nextMinute = thisMinute.nextMinute

// add one day:
let thisTimeTomorrow = thisMinute.nextDay

// subtract two years:
let twoYearsAgo = thisMinute.subtracting(years: 2)

// add three months:
let threeMonthsFromNow = thisMinute + .months(3)
```

### Showing time to users

While fixed values expose their numeric components via their [`.hour`](<doc:Fixed/hour>), [`.minute`](<doc:Fixed/minute>), etc properties, these best way to create a `String` to show to the user is using one of ``Fixed``'s many `.format(...)` methods.

```swift
let systemClock = Clocks.system
let thisMinute = systemClock.currentMinute
print("The time is currently \(thisMinute.format(time: .short))")
```

This formats the time (using a ``FixedFormatStyle``) according to the user's preferences.

If you need more flexibility around which units get displayed, you can use format templates:

```swift
let systemClock = Clocks.system
let thisMinute = systemClock.currentMinute

let formattedTime = thisMinute.format(year: .naturalDigits, month: .fullName, day: .naturalDigits, hour: .naturalDigits, minute: .twoDigits)
print("The time is currently \(formattedTime)")
```

This will print something similar to `The time is currently February 19, 2024 at 3:22 PM`.

### Reacting to changing time

One of the most fundamental use cases of **Time** is to be notified when the time on a clock is (or matches) a particular value. For example, you may want to know when it's 3:30 PM, or you may want to be notified at the top of an hour. This is easy in time using a ``ClockStrikes``.

A clock that notifies you about time changes is called a ["striking clock"](https://en.wikipedia.org/wiki/Striking_clock), and you recreate that behavior using the variou `.strike(...)` methods on a ``RegionalClock``:

```swift
for try await currentMinute in Clocks.system.strike(every: Minute.self).asyncValue {
    print("The time is now \(currentMinute.format(time: .long))")
}
```

The ``ClockStrikes`` value allows you to be notified asynchronously via its ``ClockStrikes/publisher-swift.property`` (a Combine `Publisher`) or ``ClockStrikes/asyncValues-swift.property`` (an `AsyncSequence`) properties. You can also retrieve a sequence of future values using its ``ClockStrikes/values-swift.property`` property.
