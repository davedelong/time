# Time

**Time** is a Swift package that makes it easy to perform robust and type-safe date and time calculations.

Working with calendars can be extremely complicated and error-prone. **Time** solves these problems by clarifying concepts and restricting improper usage through type-safe APIs.

## Installing

**Time** can be installed like any other Swift package. Add this to the `dependencies` section of your Package.swift:

```swift
.package(url: "https://github.com/davedelong/time", from: "1.0.0")
```

## Platform Support

**Time** requires Swift 5.7 or later, as well as macOS 13/iOS 16 (or equivalent) or later. Core parts of the library are built on Swift's `Duration` type, which was introduced in macOS 13/iOS 16.

## Documentation

**Time**'s extensive documentation is hosted at the [Swift Package Index][spi].

Additionally, an "Examples" folder in this repository contains code illustrating how to use core parts of the library.

## The Basics

Here's the TL;DR of the documentation:

- If you want to know what time it is, you need the device's `RegionalClock`, which you get by using `Clocks.system`.

- A `RegionalClock` tells you the current time. For example, `.today` will give you the current calendar day. `.currentMinute` will give you the current time, accurate down to the _minute_ level.

- Each of these returned values has methods to retrieve more- and less- precise values. For example, `today.hours` will give you a sequence of all the "Hour" values in the day.

- These values can be _formatted_ into human-readable strings via their `.format(...)` methods.

For additional information, refer to [the documentation][spi] and included examples.

## Contributing

**Time** is fully open source, available at [https://github.com/davedelong/time][gh]. If you have feature requests, suggestions, or have discovered a bug, please open a [new issue][ghi].

[spi]: https://swiftpackageindex.com/davedelong/time
[gh]: https://github.com/davedelong/time
[ghi]: https://github.com/davedelong/time/issues

## License

**Time** is licensed under the MIT License. For more information, see the `LICENSE  ` file.
