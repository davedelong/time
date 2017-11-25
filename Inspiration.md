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
- https://docs.oracle.com/javase/8/docs/api/java/time/package-summary.html
  - Does not appear to support non-Gregorian calendars (everything is ISO8601)
  - Nice: separation of `Date`, `Time`, and `DateTime` types
  - (will require deeper examination)

(Other suggested repos are welcomed via pull requests)
