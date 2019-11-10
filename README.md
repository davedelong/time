# Chronology

*Chronology* is an attempt to build a better date and time API for Swift on top of the constructs provided by Foundation.

For more information, please see the wiki:

- [Motivation](https://github.com/davedelong/chronology/wiki/Foundation's-API)
- [Inspiration](https://github.com/davedelong/chronology/wiki/Inspiration)
- [Goals](https://github.com/davedelong/chronology/wiki/Goals)
- [Implementation](https://github.com/davedelong/chronology/wiki/Implementation)

## General Overview

- An `Instant` represents a singular point in time, independent of any calendaring system.
- A `Clock` lets you get the current `Instant`, but can also give you calendrical representations.
- A `Value<...>` represents a calendrical value, such as "October 6, 2019".
- `Value` has a whole bunch of methods to perform "adjustments", such as finding the next largest/smallest value, etc
- `Value` also has methods to do type-safe formatting.

### General 1.0 Goals

These are the things I would like to get done before a 1.0 launch

- [x] defining relative and absolute values
- [x] formatting absolute values
- [x] formatting relative values
- [x] safe absolute value adjustment
- [ ] safe relative value adjustment
- [ ] unsafe absolute value adjustment
- [ ] unsafe relative value adjustment
- [ ] initializing absolute values from a `Foundation.Date`
- [ ] initializing relative values from a `Foundation.Date`
- [ ] initializing absolute values from components
- [ ] initializing relative values from components
- [ ] differences between absolute values
- [ ] differences between relative values
- [x] enumerating absolute values
- [ ] enumerating relative values
- [ ] parsing absolute values from strings
- [ ] parsing relative values from strings
- [ ] documentation
- [ ] unit tests (😣)

### Short-term Goals

- [ ] Second library with system shims (`Timer`, GCD, UIKit, UserNotifications, etc)
- [ ] pseudo-units (`Week` and `Quarter`)

### Long-term Goals

- robust adjustment and recurrence API
- celestial event calculations
- Figure out what I'd need in order to turn `Calendar` into a protocol
- abstract out the need for Foundation

## Working Notes

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
