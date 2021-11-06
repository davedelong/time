# Differences

An overview of calendrical arithmetic using two ``TimePeriod`` instances.

In **Time**, the calendrical interval between two `TimePeriod` values is expressed via the ``TimeDifference`` type.
Like `TimePeriod`, it also has two generic parameters that define the range of represented units.

The generic parameters *usually* match the parameters of the two `TimePeriod` values,
but you can explicitly request different kinds of differences.

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

`TimeDifference` can be used to adjust values by using the `applying(difference:)` method.

> Important: Be aware of the <doc:Common-Mistakes> made with calculating differences between two `TimePeriod` values.

## Topics

### Representing Differences

- ``TimeDifference``
