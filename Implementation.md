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
