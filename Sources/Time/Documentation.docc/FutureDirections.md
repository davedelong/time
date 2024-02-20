# Future Directions

Planned and proposed features for **Time**.

## Short-term Features

- ISO 8601 Formatting
    - There are interesting questions that arise around what should happen if you try to format a non-Gregorian date as ISO8601
- "Floating" values
    - Ex: "any June". Useful for birthdays and another recurring events
    - Approximate differences
    - Formatting
    - Parsing
    - Extraction from Fixed values
    - Initialize with components
    - Enumeration
    - Rounding
- Formatting `TimeDifference` values
- Formatting `Range<Fixed<U>>` values
- Pseudo-units (weeks and quarters)
    - Probably not done as a new `Unit`, since it would interfere with the GTOE/LTOE protocols
- Parsing fixed values

## Long-term Features

- Recurrence Rules
    - Including serialization
    - SeeAlso: https://forums.swift.org/t/pitch-calendar-recurrencerule/70068
- Custom Calendars
    - ISO 8601 should maybe be its own calendar
    - This would address some of the complexities around ISO 8601 formatting
    - This would enable:
        - extraterrestrial calendars, such as the [Darian calendar](https://en.wikipedia.org/wiki/Darian_calendar)
        - [special-purpose calendars](https://en.wikipedia.org/wiki/International_Fixed_Calendar)
        - [historical calendars](https://en.wikipedia.org/wiki/Maya_calendar)
        - [fictional calendars](https://en.wikipedia.org/wiki/Stardate)

## Other possible features

- Lenient parsing 
    - Ex: provide "January 31st", without any format information, and have it figure it out
- Celestial event calculations?
    - useful in certain kinds of calculations
    - ex: "given this location, find the time of the next full moon"
        - https://en.wikipedia.org/wiki/Full_moon#Formula
    - ex: "given this location, find the time of the next sunrise" (and then accounting for different sunrise definitions)
        - https://en.wikipedia.org/wiki/Sunrise_equation
