#  Core Concepts

Fundamental ideas for understanding time.

## Core Concepts

### There is a single unit of physical time

When it comes to the physical world around us, there is one (and only one) measurement of "physical" time, and that is the [SI Second](https://en.wikipedia.org/wiki/SI_base_unit). An SI Second is defined as "the length of time it takes for a particular kind of atom to perform a specific number of state transitions."

All other measurements of time (calendrical seconds, minutes, days, years, etc) are completely arbitrary and made up. They are often based on naturally occurring periods (such as "how long it takes the moon to orbit the earth" or "how long it takes the earth to orbit the sun"), but there is not a strict relationship between those "natural" periods and the calendar units with which we're familiar.

In **Time**, SI Seconds are the basis of all temporal calculations and are represented by the ``SISeconds`` type.

### Calendar values are *location-specific*

When we look at a value like "February 28th, 2020", we interpret it according to our personal and local conventions.

Inherent in every calendar value are three pieces of information:

- the calendaring system used for subdividing time
- the time zone in which the value exists
- the set of area-specific conventions for reading and writing time

Thus, a person in London who looks at "February 28th, 2020" will interpret that value to mean a *different range of contained instants* than someone who looks at that value, but is located in Los Angeles. Meanwhile, a person in certain portions of the Middle East may not understand the date at all, because their calendaring system has no notion of "February".

In **Time**, these values are represented by the ``Fixed`` type, and each fixed value holds a ``Region``, with a ``Fixed/calendar``, ``Fixed/timeZone``, and ``Fixed/locale``.

### Calendar values are *addresses* in time

We are familiar with two main ways to refer to physical locations: via their coordinates (latitude and longitude) or via a street address. The same is true with time. We can refer to time via its "temporal coordinate": its ``Instant``, a value relative to a "zero point" in time (the ``Epoch``, the temporal equivalent of a [meridian](https://en.wikipedia.org/wiki/Meridian_%28geography%29)), or we can refer to time via its "temporal address": its ``Fixed`` value that is based on a calendaring system.

Calendars are "maps" of time that we use to translate human-unfriendly ``Instant`` values into easy-to-use names that are commonly understood. And like physical maps, these temporal maps evolve based on politics, geography, our unstanding of the physical world, or the general whims of humanity.

**Time** supports all the calendaring systems supported by the [Unicode ICU library](https://icu.unicode.org). Additionally, there are plans to one day support [additional calendaring systems](<doc:FutureDirections>) beyond those.

### Calendar values represent *ranges* of time

We are used to thinking about calendar values as single, discrete measurements. "February 28th, 2020" is a single, discrete value on a calendar. There is one (and only one) such day.

However, it is better to think of calendar values as ranges. "February 28th, 2020" represents "the range of all the possible instants between the first instant of this day and the first instant of the next day." We are used to having "discrete value" checks such as "is the value equal to another value" or "is this value less than another value". While this is possible to do (and indeed, **Time** allows this), it is more correct to think of it in terms of overlapping ranges: does this range of instants overlap this other range of instants?

Every ``Fixed`` value in **Time** provides a ``Fixed/range``, to access its range of contained ``Instant``s.

### Calendar values represent ranges of *units*

If you have a value that has a "month" and a "day", then you cannot create a calendrically significant value that "skips" other units.

In other words, there is no such thing as a calendar value that represents a "month, day, and second", without also representing "hours" and "minutes" (the units between a day and a second).

A valid (``Fixed``) calendar value always represents a contiguous range of units, and curious programmers can see this in **Time** via the ``Fixed/representedComponents`` property on all fixed values.

> Important: **Time** is built on the underlying assumption of a relative ordering of unit lengths: ``Era`` > ``Year`` > ``Month`` > ``Day`` > ``Hour`` > ``Minute`` > ``Second`` > ``Nanosecond``. This assumption is an integral part of how **Time** guarantees type safety when performing calculations. 

## Common Pitfalls

### Calendar calculations are not commutative

We are used to a world where `1 + 2` produces the same result as `2 + 1`. This is not the case with calendars. Consider the following example:

```swift
let today: Fixed<Day> = Clocks.system.today

let answer1 = today + .days(1) + .months(1)
let answer2 = today + .months(1) + .days(1)
```

There are many situations where `answer1` will be identical to `answer2`. However, there are also specific scenarios in which it will not.

For example, if `today` is `February 29th, 2020`, then:
- `answer1` will produce `April 1st, 2020` (29 Feb + 1 day = 1 Mar; 1 Mar + 1 month = 1 Apr)
- `answer2` will produce `March 30th, 2020` (29 Feb + 1 month = 29 Mar; 29 Mar + 1 day = 30 Mar)

### Iterative calculations

Iterative mathematics can produce issues in calendrical code. For example:

```swift
let today: Fixed<Day> = Clocks.system.today

let answer1 = today + .months(1) + .months(1)
let answer2 = today + .months(2)
```

If `today` is `January 31st, 2020`, then:
- `answer1` will produce `March 29th, 2020` (31 Jan + 1 month = 29 Feb; 29 Feb + 1 month = 29 Mar)
- `answer2` will produce `March 31st, 2020` (31 Jan + 2 months = 31 Mar)

In **Time**, iterative addition is handled by the ``FixedSequence`` (and its underlying ``FixedIterator``). The implementation of this type uses the second approach, which involves *scaling* the "stride" value for each successive iteration, and always performing the offset calculation relative to the *start* value, and not the most-recently-calculated value.

### Non-existent Values

Many potential calendar values *look* valid, but may not locally exist. The simplest example of this involves Daylight Saving Time. When DST is observed to "spring forward", a particular named hour of a day may not exist. In the United States, these transitions happen at 2 AM, and so 1:59:59 AM is followed one second later by 3:00:00 AM. Thus, a "2:12 AM" value for that day may *look* correct, but will not exist.

Other examples include leap days: "February 29, 2023" is not a valid date, even though "February" is a known month name, "2023" is a valid year, and "29" is within the general range of days in a month. Another example might what happened in the `Pacific/Apia` time zone in 2011, when that time zone transitioned across the international date line, resulting in "December 30, 2011" not existing (December 29, 2011 at 23:59:59 was followed by December 31, 2011 at 00:00:00).

In **Time**, any operation that could involve non-existent values is an operation that `throws`, and will produce a ``TimeError`` if such a situation is encountered. For example, ``Fixed/init(region:strictDateComponents:)`` or ``Fixed/converted(to:behavior:)-6z6df``.
