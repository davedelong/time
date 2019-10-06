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