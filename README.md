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

## Calculating Holidays

There are various kinds of holiday calculations. In general order of complexity, they are:

- A known day in a known month ("December 25th")
- An ordinal weekday in a known month ("fourth Thursday of November")
- A day before/after a known day ("the day after Cyber Monday", "The day before Canadian Thanksgiving")
- A weekday before/after a known day ("the monday after Thanksgiving")
- A weekday of a specific week ("tuesday of the first full week of May")
- An ordinal day of a day ("The 256th day of the year")
- A weekday before/after a relative event ("the monday after the DST jump")
- A weekday before/after a celestial event ("the friday before the vernal equinox")
- Easter ("the sunday following the Paschal full moon, on or after March 21")
