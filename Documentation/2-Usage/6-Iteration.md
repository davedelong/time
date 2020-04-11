# Iterating Over Values

Iterating over calendrical values is a common problem, especially when it comes to building a UI around calendars. Many developers want to iterate over every day in a month, or every month in a year. `Time` makes this easy:

```swift
let thisMonth = Clock.system.thisMonth()
let daysInThisMonth = thisMonth.days()

for day in daysInThisMonth {
    // day is an Absolute<Day>
}
```

By default, all absolute `TimePeriods` provide convenience methods for iterating over subcomponents:

- An `Absolute<Year>` provides `months()` and `days()` to iterate over the months in the year and the days in the year
- An `Absolute<Month>` provides `days()` and `hours()` to iterate over the days or hours in the month
- etc

However, you can *also* create your own value sequence, by using the `AbsoluteTimePeriodSequence` provided by `Time`:

```swift
let day1: Absolute<Day> = ...
let day2: Absolute<Day> = ...

let dayRange = day1 ..< day2

let everyOtherDay = AbsoluteTimePeriodSequence(range: dayRange, stride: .days(2))
for day in everyOtherDay {
    // ...
}
```

The `AbsoluteTimePeriodSequence` type provides several convenience constructors for performing different kinds of iterations.
