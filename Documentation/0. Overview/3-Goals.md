# Goals

The goals of *Time* focus on:

- easier date/time arithmetic: doing "proper" arithmetic via the Foundation API requires a fair amount of domain knowledge. The goal here is to enable things like:

  ```swift
  let today = ...
  let tomorrow = today + .days(1)
  ```
  
- better/clearer names
- more extensibility
- better separation of responsibilities
- better conveyance of time zone/locale/calendar information
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

It is possible that a far future version of `Time` would include these enumerations to increase expressivity, but there are no plans to consider this anytime soon. 

### An English-like API

A common idiom seen in other date/time wrappers is expressing an interval as `2.days.ago`. This looks really appealing for everyone who speaks English, but requires an extra degree of grammatical understanding for non-English speakers that I believe is inappropriate.

It is unavoidable that we express the API using English words, but we can at least try to minimize the degree of comprehension required for non-native speakers.
