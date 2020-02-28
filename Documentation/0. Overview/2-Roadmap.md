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
