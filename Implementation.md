# Implementation Observations

This is a scattered list of observations and principles to guide implementation

- `NSDate` is mis-named, and that mis-nomer is the fundamental cause of most misconceptions about date/time manipulation. It needs to be `Instant` or `Moment`. For consistency, we'll call it an `Instant` for now.
- All concrete calendrical types *must* include:
  - the relative calendar
  - the timezone
  - (potentially) the locale
  
  Time zones are the second major source of developer confusion. Explicitly surfacing the timezone and calendar in the type(s) will reinforce their importance.
  
  "Converting" from one timezone to another, or one calendar to another, should ideally just be re-initializing the type with the same `Instant`, but a different timezone/calendar.
  
- `NSDateComponents` will be replaced. It is flexible, but it is overloaded. As a simple example, there is a *major* semantic difference between "March" and the interval "3 months", yet the are represented via identical `NSDateComponents`.
- A calendar should be described via a protocol. This should ideally make adding a Julian calendar easier.
- Quarters and Weeks are difficult units to support. They do not fit in nicely with the Era/Year/Month/Day/Hour/Minute/Second/Subsecond units.
- An `Instant` can *not* be used for arithmetic, because it exists independently of a calendar. If you want to "add one day" to an `Instant`, you'll first have to convert it into a calendar-relative value.
- All types should be value types, because time isn't mutable. Thank goodness.
- Provide a `Clock` type. `Date()` is one of the great hidden dependencies on global state in code and makes testing extremely difficult. A `Clock` would provide a `.now()` function that would give you the current `Instant`. It could also potentially have a `.today()` method for the calendar-relative value.
- The calendar-relative values will need a way to describe (ideally through the type system) what their components include. This would make it easier to prevent non-sensical manipulations, such as "add 3 hours to June".
- Let's try really hard to not `throw` just because we're trying to deal with "February 30th". Handling thrown errors is a pain.
- Any calendar relative value that has a year (and/or an era) can be converted in to a `Range<Instant>`. A missing era would be assumed to be the current era. 
- Abstract interface for manipulating dates and times: `TemporalAdjustment`
- Unit names should be fully qualified. ie, not "weekday" and "day", but `dayOfWeek`, `dayOfMonth`, `dayOfYear`, `monthOfYear`, etc. The lone exception to this *might* be `yearOfEra`. Maybe also the time units, since times can be used independent of a date. `hourOfDay` is redundant, because you don't really use hours in terms of any larger units (`hourOfWeek`, `hourOfMonth`, etc). Ditto minutes with respect to hours, and seconds with respect to minutes.

## Concrete "Must-haves"

### Terms

- "Calendar-relative": a value that has a timezone, a calendar, and a locale.
- "TCL": abbreviation for "timezone/calendar/locale"

### Must-haves

- A "date" that is calendar-relative. Ex: "Today" is relative to a user's TCL
- A "date" that is *not* calendar-relative. Ex: "Oct 31" is non-relative until it is explicitly related to a TCL
- A "time" that is calendar-relative must also have a "date". 
- A "time" that is *not* calendar-relative does not require a date. Ex: "3:30 PM" 
- Calendar-relative values can be converted in to a `Range<Instant>`.
