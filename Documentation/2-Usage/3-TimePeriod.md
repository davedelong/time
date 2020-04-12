# TimePeriod

`TimePeriod` is perhaps the complicated part of the `Time` package. It represents "a value that can be understood as being calendrically significant".

A more colloquial definition might be: "If you can point to it on a calendar or clock, it's a `TimePeriod`".

In order to accomplish this, `TimePeriod` defines two generic parameters, called `Smallest` and `Largest`. These parameters must be `Unit`-conforming types, of which there are currently 8: `Era`, `Year`, `Month`, `Day`, `Hour`, `Minute`, `Second`, `Nanosecond`.

For example, a `TimePeriod<Day, Era>` is value that represents *all calendar components* in the `Day ... Era` range, namely `Day`, `Month`, `Year`, and `Era`.

All calendar values that refer to "concrete" dates as humans understand them have an "upper bound" of `Era`. Thus, `Time` also defines a convenient `typealias` to make working with these "absolutely defined" values a bit easier:

```swift
public typealias Absolute<U> = TimePeriod<U, Era>
```

When working with the `Time` API, you will frequently encounter "Absolute" periods. These values simply correspond to *one and only one* possible position on a calendar. For example, there is one and only one "28 February 2020 CE".

## Creating TimePeriods

The "best" way to create `TimePeriods` is via your `Clock`. However, apps frequently deal with timestamp values that come from serialized data, such as via a network request or in `UserDefaults` and so on.

So, `TimePeriods` can also be created using certain initializers:

```swift
let aDate: Date = ...

// this will create a value representing the "day that contains aDate, according to the provided region"
// in essence, the time components of the Date are discarded
let dayValue = Absolute<Day>(region: .current, date: aDate)
```

`TimePeriods` can also be created using `DateComponents`, or via individual calendar values:
```swift
let components: DateComponents = ...

let dayValue = try Absolute<Day>(region: .current, strictDateComponents: components)
```

This sort of initialization performs a *strict* initialization. If it is passed `DateComponents` of `{year: 2020, month: 2, day: 31}`, it will throw an error indicating the date components do not represent a "real" calendar value.

## Retrieving Components

With an `Absolute` period, you can retrieve its constituent parts, such as:

```swift
let today: Absolute<Day> = myClock.today()
let year = today.year // ex: 2020
let month = today.month // ex: 2
let day = today.day // ex: 28
```

The generic parameters prevent you from retrieving *unrepresented* components:

```swift
let today: Absolute<Day> = myClock.today()
// will not compile, because "today" does not represent hours
let hour = today.hour
```

## Adjusting TimePeriods

`TimePeriods` can be mutated to form new values using the [adjustment API](4-Adjusting.md).

## Differences

You can find the difference between two `TimePeriods` using the [difference API](5-Differences.md).

## Iteration

You can iterate over sub-values using the [iteration API](6-Iteration.md).

## Formatting

You can turn a `TimePeriod` into a human-readable string using the [formatting API](7-Formatting.md).

## Observing

You can observe changes to the current `TimePeriod` using the [observation API](8-Observation.md).
