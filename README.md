# Time

`Time` is a Swift package that makes dealing with calendar values a natural and straight-forward process.

Working with calendars can be extremely complicated and error-prone. `Time` solves these problems by clarifying concepts and restricting improper usage through type-safe APIs.

## Installing

`Time` can be installed like any other Swift package. Add this to the `dependencies` section of your Package.swift:

```swift
.package(url: "https://github.com/davedelong/time", from: "1.0.0")
```

## The Basics

Here's the TL;DR of the documentation:

- If you want to know what time it is, you need a `Clock`. You can get the device's clock by using `Clock.system`.

- A `Clock` can tell you the current time via some functions. For example, `.today()` will give you the current calendar day. `.thisMinute()` will give you the current time, accurate down to the _minute_ level.

- Each of these returned values has methods to retrieve more- and less- precise values. For example, `today.hours()` will give you a sequence of all the "Hour" values in the day.

- These values also are how you _format_ them into human-readable strings (via the `.format(...)` method)

## Detailed Information

For more information, please see the following documents:

- [Motivation](Documentation/Motivation.md)
- [Inspiration](Documentation/Inspiration.md)
- [Goals](Documentation/Goals.md)

### Version 1.0 Goals

1.0 will focus on properly using `Absolute` values:

- [x] defining relative and absolute values
- [x] formatting absolute values
- [x] safe absolute value adjustment
- [x] unsafe absolute value adjustment
- [x] initializing absolute values from a `Foundation.Date`
- [x] initializing absolute values from components
- [x] differences between absolute values
- [x] enumerating absolute values
- [x] parsing absolute values from strings
- [ ] simple relative comparisons (`isBefore`, `isAfter`, etc)
- [ ] rounding absolute values
- [ ] documentation
- [ ] unit tests (😣)
- [ ] Rename `Value` → `Components`? `TimeSlice`?
- [x] Rename `Delta` → ~`Interval`~ `Difference`?
- [ ] Format `Delta` values using `DateComponentsFormatter`

### Short-term Goals

1.x will focus on properly using `Relative` values:

- [ ] public adjustment api (currently internal)
- [x] formatting relative values
- [x] initializing relative values from a `Foundation.Date`
- [ ] initializing relative values from components
- [ ] safe relative value adjustment
- [ ] unsafe relative value adjustment
- [ ] differences between relative values
- [ ] enumerating relative values
- [ ] parsing relative values from strings
- [ ] rounding relative values
- [ ] library with system shims (`Timer`, GCD, UIKit, UserNotifications, etc)
- [ ] pseudo-units (`Week` and `Quarter`)
- [ ] library with an NTP `Clock` using [`TrueTime.swift`](https://github.com/instacart/TrueTime.swift/issues/82)

### Long-term Goals

- lenient parsing
    - Ex: provide "January 31st", without any format information, and have it figure it out
- robust adjustment and recurrence API
    - including serialized representations
- Celestial event calculations
    - useful in certain kinds of calculations
- Figure out what I'd need in order to turn `Calendar` into a protocol
    - The ISO8601 ("year for week of year") calendar should ideally be a separate calendar
- Linux support

## Working Notes

### Pseudo-Units

- Weeks and Quarters are "pseudo units", because they're not intrinsic to the definition of a calendar. They're a level of information that's layered on top of the base calendar.

### Adjustments

- When adjusting values, you either:
1. stay at the same unit ("the day after this day")
2. go to the next-most-specific unit ("the *nth* day of this month")
3. go to the next-less-specific unit ("the month containing this day")

### Calculating Holidays

There are various kinds of holiday calculations. In rough order of complexity (least to most), they are:

- A known day in a known month ("December 25th")
- An ordinal weekday in a known month ("fourth Thursday of November")
- An ordinal day of a year ("The 256th day of the year")
- A day before/after a known day ("the day after Cyber Monday", "The day before Canadian Thanksgiving")
- A weekday before/after a known day ("the monday after Thanksgiving")
- A weekday of a specific week ("tuesday of the first full week of May")
- A weekday before/after a relative event ("the monday after the DST jump")
- A weekday before/after a celestial event ("the friday before the vernal equinox")
- Easter ("the sunday following the Paschal full moon, on or after March 21")

Questions...
- Should any `Holiday` type be calendar-specific? "Christmas" is only ever interpreted relative to the Gregorian calendar.
