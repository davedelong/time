#  Terminology

**Time** uses specific terminology to convey ideas. Knowing what these terms are and how they're used will help you understand how **Time**'s API works. 

## Definitions

- term Adjustment: A movement or alteration. In **Time**, "adjusting" refers to the process of offsetting a calendar value. For example, starting with "today" and would require and *adjustment* of one day in order to become "tomorrow".
- term Boundary: The point at which a calendar value abuts the next calendar value. For example, `February 14, 2024 00:00:00.000` is the first instant of that day, and is that day's *boundary*. In general, all fixed values define a range, and the ``Fixed/firstInstant`` of that range is the boundary.
- term Component: A numeric portion of a fixed value. For example, the fixed value representing `February 19, 2024` has four components: The "era" (`1` for the AD era), the "year" (`2024`), the "month" (`2` for February), and the "day" (`19`).
- term Epoch: A specific point in time from which calendars start counting their values. While **Time** allows the definition of custom epochs, the two standard ones are the ``Epoch/unix`` and the ``Epoch/reference`` epochs.
- term Era: The unit of time measurement that is (usually) longer than a year. Most calendars in-use today do not use eras, although some (such as the Japanese calendar) do.
- term Fixed: A "fixed" value is a "point" on a calendar. For example, "February 2024" is a `Fixed<Month>`. It is "fixed" because there is one (and only one) "February 2024", and it always refers to the same range of time.

    In **Time**, a fixed value has *granularity*, which is the degree of specificity of the value. A `Fixed<Month>` only contains information about the era, year, and month. A `Fixed<Minute>` contains information about the era, year, month, hour, and minute.
- term Floating: A "floating" value can refer to many potential values on a calendar. While "February 2024" is a `Fixed<Month>`, "February" itself is a *floating* value and can refer to any number of potential February values from different years.
- term Formatting: The process of transforming a value into a human-readable form, typically a `String`.
- term Parsing: The process of transforming a human-readable `String` into a value.
- term Region: A region in the **Time** package is the combination of a specific calendar, locale, and time zone.


