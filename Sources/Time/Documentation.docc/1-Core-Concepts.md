#  Core Concepts

### All temporal values are measured from a "known" point in time.

An ``Epoch`` is the "zero" time. Just as all latitude and longitude coordinates are measured from the Equator and Prime Meridian, all temporal values are measure from an [Epoch](https://en.wikipedia.org/wiki/Epoch_%28computing%29).  



### There is only a single unit of time

When it comes to the physical world around us, there is one (and only one) measurement of "physical" time,
and that is the [SI Second](https://en.wikipedia.org/wiki/SI_base_unit),
which is represented in this package via the ``SISeconds`` type.

An SI Second is defined a "the length of time it takes for a particular kind of atom to perform a specific number of state transitions."

All other measurements of time (calendrical seconds, minutes, days, years, etc) are completely arbitrary and made up.
They are often based on naturally occurring periods (such as "how long it takes the moon to orbit the earth"
or "how long it takes the earth to orbit the sun"),
but there is not a strict relationship between those "natural" periods and the calendar units with which we're familiar.
