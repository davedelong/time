# Implementation

## Terms

- "TCL": abbreviation for "timezone/calendar/locale"
- "Calendar-relative": a value that has a TCL
- "Anchored": a value that has a timezone, a calendar, and a locale.
- "Floating": a value that is not anchored with all of its requisite larger units

## Must-Haves

- A `Clock` type. `Date()` is one of the great hidden dependencies on global state in code and makes testing extremely difficult. A `Clock` would provide a `.now()` function that would give you the current `Instant`. It could also potentially have a `.today()` method for the calendar-relative value.
- The `Clock` is the entry point for all calendrical values. From the `Clock` you'll be able to get "now", today, etc.
- An `Epoch` type. An epoch represents an era in time, or rather a fixed point in time relative from which other instances are described.
- An `Instant` type. `Instant` is roughly equivalent to the current `NSDate`, in that it represents a point in time relative to an `Epoch`.
- A "date" that is anchored. Ex: "Today" is relative to a user's TCL
- A "date" that is *not* anchored (ie, it's floating). Ex: "Oct 31" is floating until a year is known.
- A "time" that is anchored must also have a "date". 
- A "time" that is *not* anchored (ie, it's floating) does not require a date. Ex: "3:30 PM" 
- Anchored values can be converted in to a `Range<Instant>`.
- All types should be value types, because time isn't mutable. Thank goodness.


## Semi-concrete Ideas

- A calendar should be described via a protocol. This should ideally make adding a Julian calendar easier.

- Supporting non-terrestrial calendars (like Martian calendars) would be very nice.

- An `Instant` can *not* be used for arithmetic, because it exists independently of a calendar. If you want to "add one day" to an `Instant`, you'll first have to convert it into a calendar-relative value.

- The calendar values will need a way to describe (ideally through the type system) what their components include. This would make it easier to prevent non-sensical manipulations, such as "add 3 hours to June".
	- Using the type system means fewer errors at runtime
	
- Abstract interface for manipulating dates and times: `TemporalAdjustment`
	
- Floating times should still be manipulateable. I should be able to temporally adjust a floating time and get a new floating time. Times that roll over would reset back to 00:00 (ie, 23:00:00 + 2:00:00 = 01:00:00). This arithmetic would operate on the default range of the HMS units defined by the calendar. 

## Things to think about some more

- Quarters and Weeks are difficult units to support. They do not fit in nicely with the Era/Year/Month/Day/Hour/Minute/Second/Subsecond units.
    - Quarters and Weeks are "synthetic" units

- Things need to be built in such a way that adding new kinds of calendar-significant events (especially celestial events like "full moon", "sunrise", "sunset", etc) are feasible.

- Let's try really hard to not `throw` just because we're trying to deal with "February 30th". Handling thrown errors is a pain.

- Unit names should be fully qualified. ie, not "weekday" and "day", but `dayOfWeek`, `dayOfMonth`, `dayOfYear`, `monthOfYear`, etc. The lone exception to this *might* be `yearOfEra`. Maybe also the time units, since times can be used independent of a date. `hourOfDay` is redundant, because you don't really use hours in terms of any larger units (`hourOfWeek`, `hourOfMonth`, etc). Ditto minutes with respect to hours, and seconds with respect to minutes.

- Where does Linux support fall in all of this?

## Observations

- `NSDate` is mis-named. It should be `Instant` or `Moment`

- `NSDateComponents` is over-loaded
	- As a simple example, there is a *major* semantic difference between "March" and the interval "3 months", yet the are represented via identical `NSDateComponents`.

