# Gotchas

Many of the "gotchas" around calendrical calculations can be found at [https://yourcalendricalfallacyis.com](https://yourcalendricalfallacyis.com).

Many of these fallacies have been mitigated via the `Time` API, but many of them are still applicable.

## Addition is not commutative

We are used to a world where `1 + 2` produces the same result as `2 + 1`. This is not the case with calendars. Consider the following example:

```swift
let today: Absolute<Day> = ...

let answer1 = today + .days(1) + .months(1)
let answer2 = today + .months(1) + .days(1)
```

There are many situations where `answer1` will be identical to `answer2`. However, the are also specific scenarios in which it will not.

For example, if `today` is `February 29th, 2020`, then:
- `answer1` will produce `April 1st, 2020` (29 Feb + 1 day = 1 Mar; 1 Mar + 1 month = 1 Apr)
- `answer2` will product `Marth 30th, 2020` (29 Feb + 1 month = 29 Mar; 29 Mar + 1 day = 30 Mar)

## Iterative addition

Iterative mathematics also can produce issues in calendrical code. For example:

```swift
let today: Absolute<Day> = ...

let answer1 = today + .months(1) + .months(1)
let answer2 = today + .months(2)
```

If `today` is `January 31st, 2020`, then:
- `answer1` will produce `March 29th, 2020` (31 Jan + 1 month = 29 Feb; 29 Feb + 1 month = 29 Mar)
- `answer2` will produce `March 31st, 2020` (31 Jan + 2 months = 31 Mar)

In `Time`, iterative addition is handled by the `AbsoluteValueSequence` (and its underlying `AbsoluteValueIterator`). The implementation of this type uses the second approach, which involves *scaling* the "stride" value for each successive iteration, and always performing the offset calculation relative to the *start* value, and not the most-recently-calculated value.
