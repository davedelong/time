# Chronology

*Chronology* is an attempt to build a better date and time API for Swift on top of the constructs provided by Foundation.

## Motivation

Foundation.framework has one of the absolute best and most capable APIs available to any developer on any platform. However, it comes with a heavy price in the form of cognitive load. Too many developers do too many incorrect things. Over the years, Foundation has gained more and more convenience methods via the `Calendar` type, but fundamental issues remain.

## Inspiration

There are myriads of date/time convenience methods available on Github. *Chronology* will draw on them for inspiration. In no particular order, these include:

- https://github.com/instacart/TrueTime.swift
- https://github.com/naoty/Timepiece
- https://github.com/dreymonde/Time
- https://github.com/akosma/SwiftMoment
- https://github.com/malcommac/SwiftDate
- https://github.com/harlanhaskins/Punctual.swift
- https://github.com/erica/SwiftDates
- https://github.com/hemangshah/Datify
- https://github.com/SwiftKitz/Datez
- https://github.com/melvitax/DateHelper
- https://github.com/Kawoou/AnyDate

(Other suggested repos are welcomed via pull requests)

## Goals

The goals of *Chronology* include:

- easier date/time arithmetic: doing "proper" arithmetic via the Foundation API requires a fair amount of domain knowledge. The goal here is to enable things like:

  ```swift
  let today = ...
  let tomorrow = today + .days(1)
  ```
  
- better names: for example, `NSDate`/`Date` is incorrectly named
- more extensibility: Foundation does not allow you to provide your own calendar implementation
- better separation of responsibilities: `NSDateComponents` should not be used for both calendrical components and calendrical intervals
- better conveyance of time zone information
- better ISO8601 support
- easier formatting
- support for the Julian calendar
- recurrence rules and calculating recurrences
- easily convertible back to the Foundation API

## Non-Goals

### Strongly-typed Dates

While at first glance having `Date<Gregorian>` or `Date<IslamicCivil>` types seems appealing (especially in the strongly-typed world of Swift), this is ultimately extremely impractical. Strongly-typed dates are great at compile time, but an app cannot know the user's calendar until runtime, at which point it is too late to deal with these sorts of constructs.

There *is* a possibility to have strongly-typed dates, but they would only exist as convenience API to use when converting from one date to an explicit date type. (For example, your app is only relevant if the dates are in the Gregorian calendar) However, such use-cases are extremely rare, and this sort of support would not rank well on a list of priorities.

### Enumerating All The Things

Given a `GregorianCalendar`, it at first sounds appealing to allow for the existence of a `GregorianMonth` enum, like so:

```swift
enum GregorianMonth {
    case january, february, march, april, may, june, july, august, september, october, november, december
}
```

However, this sort of enumeration explosion becomes quickly tedious as you consider the lengths to which this might extend. Should this enumerations include the days of the week? What about the eras? If it includes the eras, how do we handle yet-to-be-created eras for the Japanese calendar? etc.

## Implementation

See [Implementation.md](Implementation.md).
