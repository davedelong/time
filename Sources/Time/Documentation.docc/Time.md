# ``Time``

**Time** a Swift Package for conveniently and easily performing calendrically correct date-and-time calculations.

## Overview

In order to properly use this package, it's helpful to understand some underlying concepts about measuring and representing time.

### There is only a single unit of time

When it comes to the physical world around us, there is one (and only one) measurement of "physical" time,
and that is the [SI Second](https://en.wikipedia.org/wiki/SI_base_unit),
which is represented in this package via the ``SISeconds`` type.

An SI Second is defined a "the length of time it takes for a particular kind of atom to perform a specific number of state transitions."

All other measurements of time (calendrical seconds, minutes, days, years, etc) are completely arbitrary and made up.
They are often based on naturally occurring periods (such as "how long it takes the moon to orbit the earth"
or "how long it takes the earth to orbit the sun"),
but there is not a strict relationship between those "natural" periods and the calendar units with which we're familiar.

### Convenience, not precision

Humans use calendars because talking about time and durations in terms of SI Seconds is incomprehensible.
Thus, it's appropriate to think about calendars as an abstraction that exists on top of physical time.

As with most abstractions, we gain convenience at the expense of precision.
There's no good way to consistently define the length of a "month",
but it is convenient to define it (for most calendars) as approximately 30 days, or a "week" as approximately 7 days.

### Calendar values are ranges

We are used to thinking about calendar values as single, discrete measurements.
"February 28th, 2020" is a single, discrete value on a calendar. This is one (and only one) such day.

However, it is better to think of calendar values as ranges.

"February 28th, 2020" represents "the range of all the possible instants between the first instant of this day and the first instant of the next day."
We are used to having "discrete value" checks such as "is the value equal to another value" or "is this value less than another value".

While this is possible to do (and indeed, **Time** allows this),
it is more correct to think of it in terms of overlapping ranges: does this range of instants overlap this other range of instants?

### Calendar values are location-specific

When we look at a value like "February 28th, 2020", we interpret it according to our personal and local conventions.

Inherent in every calendar value are three pieces of information:

- the calendaring system used for subdividing time
- the set of area-specific conventions for reading and writing time
- the timezone in which the value exists

Thus, a person in London who looks at "February 28th, 2020" will interpret that value to mean a different range of contained instants than someone who looks at that value, but is located in Los Angeles.
Meanwhile, a person in certain portions of the Middle East may not understand the date at all,
because their calendaring system has no notion of "February".

### Calendar values represent ranges of units

If you have a value that has a "month" and a "day", then you cannot create a calendrically significant value that "skips" other units.

In other words, there is no such thing as a calendar value that represents a "month, day, and second",
without also representing "hours" and "minutes" (the units between a day and a second).

A valid calendar value always contains contiguous ranges of units.

> Tip: Most of the issues that programmers have with date and time calculations come from misunderstanding these fundamental concepts.
> 
> This package aims to simplify these problems by encoding these representations and ideas into the fundamental types presented in its API.

## Topics

### Usage Guides

- <doc:Using-Clocks>
- <doc:Using-TimePeriod>
- <doc:Adjustments>
- <doc:Differences>
- <doc:Iteration>
- <doc:Formatting>
- <doc:Observation>
- <doc:Common-Mistakes>

### Core Concepts

- ``SISeconds``
- ``Clock``
- ``Region``
- ``Instant``
- ``TimePeriod``
- ``Epoch``
