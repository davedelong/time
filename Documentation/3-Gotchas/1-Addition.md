# Gotchas

Many of the "gotchas" around calendrical calculations can be found at [https://yourcalendricalfallacyis.com](https://yourcalendricalfallacyis.com).

Many of these fallacies have been mitigated via the `Time` API, but many of them are still applicable.

## Addition is not commutative

```swift
let today: Absolute<Day> = ...

let answer1 = today + .days(1) + .months(1)
let answer2 = today + .months(1) + .days(1)
```

## Iterative addition

```swift
let today: Absolute<Day> = ...

let answer1 = today + .months(1) + .months(1)
let answer2 = today + .months(2)
```
