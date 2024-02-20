# ``Fixed``

## Topics

### Creating a fixed value

- ``Fixed/init(region:date:)``
- ``Fixed/init(region:instant:)``
- ``Fixed/init(region:strictDateComponents:)``
- ``Fixed/init(stringValue:rawFormat:region:)``

- ``Fixed/init(region:era:)``
- ``Fixed/init(region:era:year:)``
- ``Fixed/init(region:era:year:month:)``
- ``Fixed/init(region:era:year:month:day:)``
- ``Fixed/init(region:era:year:month:day:hour:)``
- ``Fixed/init(region:era:year:month:day:hour:minute:)``
- ``Fixed/init(region:era:year:month:day:hour:minute:second:)``
- ``Fixed/init(region:era:year:month:day:hour:minute:second:nanosecond:)``

### Common Properties

Properties available on all fixed values.

- ``Fixed/region``
- ``Fixed/calendar``
- ``Fixed/locale``
- ``Fixed/timeZone``
- ``Fixed/range``
- ``Fixed/firstInstant``
- ``Fixed/representedComponents``

### Date Properties

Properties related to values representing days, months, years, or eras

- ``Fixed/era``
- ``Fixed/year``
- ``Fixed/month``
- ``Fixed/day``
- ``Fixed/dayOfMonth``
- ``Fixed/dayOfWeek``
- ``Fixed/dayOfWeekOrdinal``
- ``Fixed/dayOfYear``
- ``Fixed/isWeekday``
- ``Fixed/isWeekend``
- ``Fixed/startOfWeek``
- ``Fixed/weekOfYear``
- ``Fixed/weekday``

### Time Properties

Properties related to specific times on a day

- ``Fixed/hour``
- ``Fixed/minute``
- ``Fixed/second``
- ``Fixed/nanosecond``

### Retrieving Sequences of Sub-Values

- ``Fixed/years``
- ``Fixed/months``
- ``Fixed/days``
- ``Fixed/hours``
- ``Fixed/minutes``
- ``Fixed/seconds``

### Locating Sub-Values

- ``Fixed/firstYear``
- ``Fixed/firstMonth``
- ``Fixed/firstDay``
- ``Fixed/firstHour``
- ``Fixed/firstMinute``
- ``Fixed/firstSecond``
- ``Fixed/lastYear``
- ``Fixed/lastMonth``
- ``Fixed/lastDay``
- ``Fixed/lastHour``
- ``Fixed/lastMinute``
- ``Fixed/lastSecond``
- ``Fixed/year(_:)``
- ``Fixed/month(_:)``
- ``Fixed/day(_:)``
- ``Fixed/hour(_:)``
- ``Fixed/minute(_:)``
- ``Fixed/second(_:)``
- ``Fixed/nthYear(_:)``
- ``Fixed/nthMonth(_:)``
- ``Fixed/nthDay(_:)``
- ``Fixed/nthHour(_:)``
- ``Fixed/nthMinute(_:)``
- ``Fixed/nthSecond(_:)``

### Adjusting Values

- ``Fixed/next``
- ``Fixed/nextDay``
- ``Fixed/nextHour``
- ``Fixed/nextMinute``
- ``Fixed/nextMonth``
- ``Fixed/nextNanosecond``
- ``Fixed/nextSecond``
- ``Fixed/nextYear``
- ``Fixed/previous``
- ``Fixed/previousDay``
- ``Fixed/previousHour``
- ``Fixed/previousMinute``
- ``Fixed/previousMonth``
- ``Fixed/previousNanosecond``
- ``Fixed/previousSecond``
- ``Fixed/previousYear``
- ``Fixed/next(dayOfWeek:)``
- ``Fixed/next(weekday:)``
- ``Fixed/offset(by:)``
- ``Fixed/adding(years:)``
- ``Fixed/adding(months:)``
- ``Fixed/adding(days:)``
- ``Fixed/adding(hours:)``
- ``Fixed/adding(minutes:)``
- ``Fixed/adding(seconds:)``
- ``Fixed/adding(nanoseconds:)``
- ``Fixed/applying(difference:)``
- ``Fixed/subtracting(days:)``
- ``Fixed/subtracting(hours:)``
- ``Fixed/subtracting(minutes:)``
- ``Fixed/subtracting(months:)``
- ``Fixed/subtracting(nanoseconds:)``
- ``Fixed/subtracting(seconds:)``
- ``Fixed/subtracting(years:)``

### Truncating Values

- ``Fixed/fixedDay``
- ``Fixed/fixedEra``
- ``Fixed/fixedHour``
- ``Fixed/fixedMinute``
- ``Fixed/fixedMonth``
- ``Fixed/fixedSecond``
- ``Fixed/fixedYear``

### Rounding Values

- ``Fixed/nearestDay``
- ``Fixed/nearestEra``
- ``Fixed/nearestHour``
- ``Fixed/nearestMinute``
- ``Fixed/nearestMonth``
- ``Fixed/nearestSecond``
- ``Fixed/nearestYear``
- ``Fixed/roundedToNearestEra()``
- ``Fixed/roundedToNearestYear()``
- ``Fixed/roundedToNearestMonth()``
- ``Fixed/roundedToNearestDay()``
- ``Fixed/roundedToNearestHour()``
- ``Fixed/roundedToNearestMinute()``
- ``Fixed/roundedToNearestSecond()``
- ``Fixed/roundedToNearestMultiple(of:)``
- ``Fixed/roundedToEra(direction:)``
- ``Fixed/roundedToYear(direction:)``
- ``Fixed/roundedToMonth(direction:)``
- ``Fixed/roundedToDay(direction:)``
- ``Fixed/roundedToHour(direction:)``
- ``Fixed/roundedToMinute(direction:)``
- ``Fixed/roundedToSecond(direction:)``
- ``Fixed/roundedToMultiple(of:direction:)``

### Transforming Values

- ``Fixed/setting(day:)-5y0l2``
- ``Fixed/setting(day:)-ws64``
- ``Fixed/setting(day:hour:)-7la2i``
- ``Fixed/setting(day:hour:)-9fzy``
- ``Fixed/setting(day:hour:minute:)-3a6pb``
- ``Fixed/setting(day:hour:minute:)-8itqx``
- ``Fixed/setting(day:hour:minute:second:)-99har``
- ``Fixed/setting(day:hour:minute:second:)-uaeh``
- ``Fixed/setting(day:hour:minute:second:nanosecond:)-4p4s8``
- ``Fixed/setting(day:hour:minute:second:nanosecond:)-7bjyp``
- ``Fixed/setting(hour:)-6xzd3``
- ``Fixed/setting(hour:)-7h102``
- ``Fixed/setting(hour:minute:)-8h1i9``
- ``Fixed/setting(hour:minute:)-8nafu``
- ``Fixed/setting(hour:minute:second:)-1bw8t``
- ``Fixed/setting(hour:minute:second:)-6et1j``
- ``Fixed/setting(hour:minute:second:nanosecond:)-2phd0``
- ``Fixed/setting(hour:minute:second:nanosecond:)-7ijt0``
- ``Fixed/setting(minute:)-5r0j2``
- ``Fixed/setting(minute:)-846b``
- ``Fixed/setting(minute:second:)-1iaav``
- ``Fixed/setting(minute:second:)-96o12``
- ``Fixed/setting(minute:second:nanosecond:)-3odfw``
- ``Fixed/setting(minute:second:nanosecond:)-9msah``
- ``Fixed/setting(month:)-73rzq``
- ``Fixed/setting(month:)-7sckx``
- ``Fixed/setting(month:day:)-2o7fs``
- ``Fixed/setting(month:day:)-6mjo7``
- ``Fixed/setting(month:day:hour:)-3oifl``
- ``Fixed/setting(month:day:hour:)-7pikj``
- ``Fixed/setting(month:day:hour:minute:)-66pyd``
- ``Fixed/setting(month:day:hour:minute:)-9tltj``
- ``Fixed/setting(month:day:hour:minute:second:)-1w35l``
- ``Fixed/setting(month:day:hour:minute:second:)-9gym``
- ``Fixed/setting(month:day:hour:minute:second:nanosecond:)-1j0fh``
- ``Fixed/setting(month:day:hour:minute:second:nanosecond:)-3mwnc``
- ``Fixed/setting(nanosecond:)-7zcnp``
- ``Fixed/setting(nanosecond:)-8id21``
- ``Fixed/setting(second:)-2dp6l``
- ``Fixed/setting(second:)-wp9c``
- ``Fixed/setting(second:nanosecond:)-4j9v9``
- ``Fixed/setting(second:nanosecond:)-8wv8q``
- ``Fixed/setting(year:)``
- ``Fixed/setting(year:month:)``
- ``Fixed/setting(year:month:day:)``
- ``Fixed/setting(year:month:day:hour:)``
- ``Fixed/setting(year:month:day:hour:minute:)``
- ``Fixed/setting(year:month:day:hour:minute:second:)``
- ``Fixed/setting(year:month:day:hour:minute:second:nanosecond:)``

### Converting values

- ``Fixed/converted(to:)-1n2im``
- ``Fixed/converted(to:)-38h1f``
- ``Fixed/converted(to:)-3hhei``
- ``Fixed/converted(to:)-7n184``
- ``Fixed/converted(to:behavior:)-3fufq``
- ``Fixed/converted(to:behavior:)-3meoh``
- ``Fixed/converted(to:behavior:)-6z6df``

### Comparing values

- ``Fixed/contains(_:)``
- ``Fixed/isAfter(_:)``
- ``Fixed/isBefore(_:)``
- ``Fixed/isDuring(_:)``
- ``Fixed/overlaps(_:)``
- ``Fixed/relation(to:)``
- ``Fixed/difference(to:)``
- ``Fixed/differenceInWholeDays(to:)``
- ``Fixed/differenceInWholeHours(to:)``
- ``Fixed/differenceInWholeMinutes(to:)``
- ``Fixed/differenceInWholeMonths(to:)``
- ``Fixed/differenceInWholeSeconds(to:)``
- ``Fixed/differenceInWholeYears(to:)``

### Simple Formatting

- ``Fixed/format(date:)``
- ``Fixed/format(date:time:)``
- ``Fixed/format(time:)``

### Formatting values

- ``Fixed/format(era:)``
- ``Fixed/format(era:year:timeZone:)``
- ``Fixed/format(era:year:month:timeZone:)``
- ``Fixed/format(era:year:month:day:weekday:timeZone:)``
- ``Fixed/format(era:year:month:day:weekday:hour:timeZone:)``
- ``Fixed/format(era:year:month:day:weekday:hour:minute:timeZone:)``
- ``Fixed/format(era:year:month:day:weekday:hour:minute:second:timeZone:)``
- ``Fixed/format(era:year:month:day:weekday:hour:minute:second:nanosecond:timeZone:)``
- ``Fixed/format(year:timeZone:)``
- ``Fixed/format(year:month:timeZone:)``
- ``Fixed/format(year:month:day:weekday:timeZone:)``
- ``Fixed/format(year:month:day:weekday:hour:timeZone:)``
- ``Fixed/format(year:month:day:weekday:hour:minute:timeZone:)``
- ``Fixed/format(year:month:day:weekday:hour:minute:second:timeZone:)``
- ``Fixed/format(year:month:day:weekday:hour:minute:second:nanosecond:timeZone:)``
- ``Fixed/format(month:timeZone:)``
- ``Fixed/format(month:day:weekday:timeZone:)``
- ``Fixed/format(month:day:weekday:hour:timeZone:)``
- ``Fixed/format(month:day:weekday:hour:minute:timeZone:)``
- ``Fixed/format(month:day:weekday:hour:minute:second:timeZone:)``
- ``Fixed/format(month:day:weekday:hour:minute:second:nanosecond:timeZone:)``
- ``Fixed/format(day:weekday:timeZone:)``
- ``Fixed/format(weekday:timeZone:)``
- ``Fixed/format(day:weekday:hour:timeZone:)``
- ``Fixed/format(day:weekday:hour:minute:timeZone:)``
- ``Fixed/format(day:weekday:hour:minute:second:timeZone:)``
- ``Fixed/format(day:weekday:hour:minute:second:nanosecond:timeZone:)``
- ``Fixed/format(hour:timeZone:)``
- ``Fixed/format(hour:minute:timeZone:)``
- ``Fixed/format(hour:minute:second:timeZone:)``
- ``Fixed/format(hour:minute:second:nanosecond:timeZone:)``
- ``Fixed/format(minute:timeZone:)``
- ``Fixed/format(minute:second:timeZone:)``
- ``Fixed/format(minute:second:nanosecond:timeZone:)``
- ``Fixed/format(second:timeZone:)``
- ``Fixed/format(second:nanosecond:timeZone:)``
- ``Fixed/format(nanosecond:timeZone:)``
- ``Fixed/format(timeZone:)``
- ``Fixed/format(raw:strict:)``

### Typealiases

- ``Fixed/Smallest``

### Default Implementations

- Comparable, CustomDebugStringConvertible, CustomStringConvertible, Decodable, Encodable, Equatable, Hashable
