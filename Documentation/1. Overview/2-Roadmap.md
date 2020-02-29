# Roadmap

`Time` 

## Version 1.0

1.0 will focus on properly using `Absolute` values:

- [x] defining relative and absolute values
- [x] formatting absolute values
- [x] safe absolute value adjustment
- [x] unsafe absolute value adjustment
- [x] initializing absolute values from a `Foundation.Date`
- [x] initializing absolute values from components
- [x] differences between absolute values
- [x] enumerating absolute values
- [x] parsing absolute values from strings
- [x] Rename `Delta`. Possible candidates:
    - `Difference` (This was chosen)
    - `Interval`
- [ ] Rename `Value`. Possible candidates:
    - `TimeSlice`
    - `Period`
    - `TemporalRange`
    - `Components`
    - `Measurement`
    - `Quantum`
    - `Quantity`
- [ ] documentation
- [x] Project organization

## Short-term Features

Fill out base functionality and fully implement `Relative` values:

- [ ] Format `Difference` values using `DateComponentsFormatter`
- [ ] simple relative comparisons (`isBefore`, `isAfter`, etc)
- [ ] rounding absolute values (adjust to the nearst 7 minutes, for example)
- [ ] public adjustment api (currently internal)
- [x] formatting relative values
- [x] initializing relative values from a `Foundation.Date`
- [ ] initializing relative values from components
- [ ] safe relative value adjustment
- [ ] unsafe relative value adjustment
- [ ] differences between relative values
- [ ] enumerating relative values
- [ ] parsing relative values from strings
- [ ] rounding relative values
- [ ] library with system shims (`Timer`, GCD, UIKit, UserNotifications, etc)
- [ ] pseudo-units (`Week` and `Quarter`)
- [ ] library with an NTP `Clock` using [`TrueTime.swift`](https://github.com/instacart/TrueTime.swift/issues/82) or [`Kronos`](https://github.com/Lyft/Kronos)

## Long-term Features

- lenient parsing
    - Ex: provide "January 31st", without any format information, and have it figure it out
- robust adjustment and recurrence API
    - including serialized representations
- Celestial event calculations
    - useful in certain kinds of calculations
- Turn `Calendar` into a protocol
    - The ISO8601 ("year for week of year") calendar should ideally be a separate calendar
    - This would enable:
        - extraterrestrial calendars, such as the [Darian calendar](https://en.wikipedia.org/wiki/Darian_calendar)
        - [specialized historical calendars](https://en.wikipedia.org/wiki/Maya_calendar)
        - [fictional calendars](https://en.wikipedia.org/wiki/Stardate)
- Linux support

## Working Notes

This information is included for future reference when implementing the corresponding features.

### Pseudo-Units

- Weeks and Quarters are "pseudo units", because they're not intrinsic to the definition of a calendar. They're a level of information that's layered on top of the base calendar.

### Adjustments

- When adjusting values, you either:
1. stay at the same unit ("the day after this day")
2. go to the next-most-specific unit ("the *nth* day of this month")
3. go to the next-less-specific unit ("the month containing this day")

### Calculating Holidays

There are various kinds of holiday calculations. In rough order of complexity (least to most), they are:

- A known day in a known month ("December 25th")
- An ordinal weekday in a known month ("fourth Thursday of November")
- An ordinal day of a year ("The 256th day of the year")
- A day before/after a known day ("the day after Cyber Monday", "The day before Canadian Thanksgiving")
- A weekday before/after a known day ("the monday after Thanksgiving")
- A weekday of a specific week ("tuesday of the first full week of May")
- A weekday before/after a relative event ("the monday after the DST jump")
- A weekday before/after a celestial event ("the friday before the vernal equinox")
- Easter ("the sunday following the Paschal full moon, on or after March 21")

Questions...
- Should any `Holiday` type be calendar-specific? "Christmas" is only ever interpreted relative to the Gregorian calendar.
