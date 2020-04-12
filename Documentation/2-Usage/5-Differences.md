# Differences

In `Time`, the calendrical interval between two `TimePeriods` is expressed via the `TimeDifference` type. Like `TimePeriod`, it also has two generic parameters that define the range of represented units. The generic parameters *usually* match the parameters of the two `TimePeriods`, but you can explicitly request different kinds of differences.

```swift

let day1: Absolute<Day> = ...
let day2: Absolute<Day> = ...

// compute the difference in days, months, years, and eras
let difference: TimeDifference<Day, Era> = day1.difference(to: day2)
```

There are convenience methods for requesting differences in other units such as:

```swift
let day1: Absolute<Day> = ...
let day2: Absolute<Day> = ...

// the number of calendar days between the two values
let difference = day1.differenceInDays(to: day2)
```

And if your situation merits it, you can request a set of custom unit differences by providing an explicit type for the return value:

```swift
let day1: Absolute<Day> = ...
let day2: Absolute<Day> = ...

// compute the difference in days and months
let difference: TimeDifference<Day, Month> = day1 - day2
```

`TimeDifferences` can be used to [adjust values](4-Adjusting.md) by using the `.applying(difference:)` method.
