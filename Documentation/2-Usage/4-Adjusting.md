# Adjusting Values

"Adjusting" is the process of mutating a `Value` to form a new value. Simple adjustments would be things like:

```swift
let today: Absolute<Day> = ...
let tomorrow = today.adding(days: 1)
```

In this example, we have _adjusted_ the `today` value to get a new one that represents "tomorrow".

There are two fundamental categories of adjustments: Safe adjustments, and Strict adjustments.

## Safe Adjustments

Safe adjustments are *relative* adjustments. This means they typically involve starting with a known value, and then applying a relative difference. The example above is one such adjustment.

These adjustments are "safe", because there is no reasonable way in which they will fail. For example, if I have a value representing a "day", then it will always be possible to find the preceding or succeeding day.

`Value` includes many methods for performing safe adjustments (such as the `.adding(...)` and `.subtracting(...)` methods). As a convenience, it also includes overrides of the `+` and `-` operator for a more expressive syntax:

```swift
let today: Absolute<Day> = ...
let tomorrow = today + .days(1)
```

Other "safe" adjustments include:

- truncating a value to form a "less-precise" value:

        let today: Absolute<Day> = ...
        let thisMonth = today.absoluteMonth() // an Absolute<Month>

- finding the "next" or "previous" values:

        let today: Absolute<Day> = ...
        let tomorrow = today.next()
        let yesterday = today.previous()

## Strict Adjustments

Strict adjustments are ones where we cannot guarantee at compile time that the operation will be calendrically correct. For example, if I have a value that refers to "February 2020", we cannot guarantee that attempting to find a specific day will succeed:

```swift
let february: Absolute<Month> = ...
let feb30th = try february.setting(day: 30)
```

Strict adjustments are one of the ways in which you can find "more precise" values:

```swift
let today: Absolute<Day> = ...
let todayAt3PM = try today.setting(hour: 15, minute: 0)
```

When a strict adjustment fails, it throws an `AdjustmentError`.
