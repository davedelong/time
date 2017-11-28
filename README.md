# Chronology

*Chronology* is an attempt to build a better date and time API for Swift on top of the constructs provided by Foundation.

## Motivation

Foundation.framework has one of the absolute best and most capable APIs available to any developer on any platform. However, it comes with a heavy price in the form of cognitive load. Too many developers do too many incorrect things. Over the years, Foundation has gained more and more convenience methods via the `Calendar` type, but fundamental issues remain.

## Inspiration

See [Inspiration.md](Inspiration.md).

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

### An English-like API

A common idiom seen in other date/time wrappers is expressing an interval as `2.days.ago`. This looks really appealing for everyone who speaks English, but requires an extra degree of grammatical understanding for non-English speakers that I believe is inappropriate.

It is unavoidable that we express the API using English words, but we can at least try to minimize the degree of comprehension required for non-native speakers.

### An NTP Clock

There are a couple of great NTP libraries out there (see [Inspiration.md](Inspiration.md)), but NTP clocks are typically used for applications that have definitive real-time business needs. Your typical iOS app does not have such needs.

An NTP Clock may *eventually* make its way in to this library, but it would be an extremely low priority and would need significant justification.

## Implementation

See [Implementation.md](Implementation.md).
