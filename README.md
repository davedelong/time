# Time

`Time` is a Swift package that makes dealing with calendar values a natural and straight-forward process.

Working with calendars can be extremely complicated and error-prone. `Time` solves these problems by clarifying concepts and restricting improper usage through type-safe APIs.

## Installing

`Time` can be installed like any other Swift package. Add this to the `dependencies` section of your Package.swift:

```swift
.package(url: "https://github.com/davedelong/time", from: "0.9.0")
```

## The Basics

Here's the TL;DR of the documentation:

- If you want to know what time it is, you need a `Clock`. You can get the device's clock by using `Clock.system`.

- A `Clock` can tell you the current time via some functions. For example, `.today()` will give you the current calendar day. `.thisMinute()` will give you the current time, accurate down to the _minute_ level.

- Each of these returned values has methods to retrieve more- and less- precise values. For example, `today.hours()` will give you a sequence of all the "Hour" values in the day.

- These values also are how you _format_ them into human-readable strings (via the `.format(...)` method)

### Some Small Examples

There are some examples below showing a sneak peek of what you can do with `Time`.

#### Fetching the Current Time

```swift
let clock = Clock.system

// retrieve the current instantaneous time from the clock
let now = clock.thisInstant()

// retrieve the current calendar day, as defined by the user's region
let today = clock.today()
```

More information in ["Clock"](Documentation/2-Usage/2-Clock.md).

#### Converting Between Regions

```swift
let nycTimeZone = TimeZone(identifier: "America/New_York")!

let myClock = Clock.system
let nycClock = myClock.converting(to: nycTimeZone)

let myLocalTime = myClock.thisMinute() // Ex: 28 Feb 2020 at 3:14 PM Pacific Time

let nycLocalTime = nycClock.thisMinute() // Ex: 28 Feb 2020 at 6:14 PM Eastern Time
```

More information in ["Clock"](Documentation/2-Usage/2-Clock.md).

#### Retrieving Components

```swift
let today: Absolute<Day> = myClock.today()
let year = today.year // Ex: 2020
let month = today.month // Ex: 2
let day = today.day // Ex: 28
```

More information in ["Value"](Documentation/2-Usage/3-Value.md).

#### Calculating Differences

```swift
let day1: Absolute<Day> = ...
let day2: Absolute<Day> = ...

// compute the difference in days, months, years, and eras
let difference: Difference<Day, Era> = day1.difference(to: day2)

// or conveniently the number of calendar days between the two values
let daysDifference = day1.differenceInDays(to: day2)
```

More information in ["Differences"](Documentation/2-Usage/5-Differences.md).

#### Iterating Over Values

```swift
let thisMonth = Clock.system.thisMonth()
let daysInThisMonth = thisMonth.days()

for day in daysInThisMonth {
    // …
}
```

More information in ["Iterating Over Values"](Documentation/2-Usage/6-Iteration.md).

#### Formatting Values

```swift
let today: Absolute<Day> = ...

let fullYearString = today.format(date: .full) // Ex: February 28, 2020
let shortYearString = today.format(year: .twoDigits, month: .full) // Ex: February '20
```

More information in ["Formatting Values"](Documentation/2-Usage/7-Formatting.md).

## Detailed Information

For more information, [please see the documentation](Documentation).
