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

## Detailed Information

For more information, [please see the documentation](Documentation).
