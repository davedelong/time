#  Formatting Fixed Values

Formatting is the process of taking a ``TimePeriod`` and turning it into a human-readable form.

**Time** offers a rich set of APIs for formatting values according to the user's localized preferences.

```swift
let today: Absolute<Day> = ...

let string = today.format(date: .full) // Ex: February 28, 2020
```

Additionally, **Time** supports building formatted values by specifying individual field formats:

```swift
let today: Absolute<Day> = ...

let string = today.format(year: .twoDigits, month: .naturalName) // Ex: February '20
```


