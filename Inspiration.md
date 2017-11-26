# Inspiration

There are myriads of date/time convenience methods available on Github. *Chronology* will draw on them for inspiration. In no particular order, these include:

- https://github.com/instacart/TrueTime.swift
- https://github.com/naoty/Timepiece
  - Nice formatting methods
  - Interesting: "truncation" methods to drop HMS off a datetime
  - Makes `DateComponents` addable and negatable
- https://github.com/dreymonde/Time
  - Interesting: Strongly typed `Interval<T: TimeUnit>`
- https://github.com/akosma/SwiftMoment
  - Uses sparse `Dictionary<String, Double>` in place of `DateComponents`
  - Like `dreymonde/Time`, has a `Duration` type (although it's not generic)
  - Seems focused on Gregorian calendar
- https://github.com/malcommac/SwiftDate
  - (Quite large; will require deeper examination)
- https://github.com/harlanhaskins/Punctual.swift
  - [Nice trick](https://github.com/harlanhaskins/Punctual.swift/blob/master/Sources/Punctual.swift#L195) for adding two `DateComponents`
- https://github.com/erica/SwiftDates
  - (will require deeper examination)
- https://github.com/hemangshah/Datify
  - Standard sort of `3.days.ago`-style syntax
- https://github.com/SwiftKitz/Datez
  - Interesting: Given a `Date`, get a "view" of the date via `.gregorian`, `.islamic`
  - Relative accessors on a `Date`: `.beginningOfDay`, etc
- https://github.com/melvitax/DateHelper
  - Nice `.toString()`-style formatting
  - Interesting: comparison happens via matchers: `date.compare(.isSameDay(as: other))`
  - Nice: adjustment to nearest interval: `date.dateFor(.nearestHour(hour:5))`
- https://github.com/Kawoou/AnyDate
  - Based on Java 8 API
  - Seems focused on Gregorian calendar
  - Awesome: has a `Clock` type
  - (will require deeper examination)
  
## Java 8 API
  
- [`java.time`](https://docs.oracle.com/javase/8/docs/api/java/time/package-summary.html)
  - Does not appear to support non-Gregorian calendars (everything is ISO8601)
  - Nice: separation of `Date`, `Time`, and `DateTime` types
  - (will require deeper examination)
- [`java.time.chrono`](https://docs.oracle.com/javase/8/docs/api/java/time/chrono/package-summary.html)
  - The basis of the Java 8 API. Allows for non-Gregorian calendars
- [`java.time.temporal`](https://docs.oracle.com/javase/8/docs/api/java/time/temporal/package-summary.html)
  - The package that allows access to fields of a temporal object
  - Interesting: defines temporal adjusters
  - Interesting: defines a `TemporalQuery<T>` type for querying a temporal value (ie, get the timezone, get the dayOfMonth, etc)
- [`java.time.zone`](https://docs.oracle.com/javase/8/docs/api/java/time/zone/package-summary.html)
  - Contains the definition of timezones, etc.
  - Probably not necessary, since there isn't an obvious need to replace `Foundation.TimeZone`
- [`java.time.format`](https://docs.oracle.com/javase/8/docs/api/java/time/format/package-summary.html)
  - Formating temporal objects into human-readable forms
  - Probably not necessary, since the Foundation-provided formatters are excellent in-and-of themselves

(Other suggested repos are welcomed via pull requests)
