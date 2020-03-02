# Motivation

It's no secret that date and time calculations are difficult to get correct. The difficulty stems from a couple of major problems such as:

- the complexity of the problem space
- unfamiliarity with the tools available to solve the problem
- the confidence that the written code is the "correct" code to answer a particular question. 

## What's wrong with Foundation?

For many years, Apple developers have been using the APIs provided by the Foundation framework – `NSDate`, `NSCalendar`, and so on. In the broader scheme of programming languages, we've actually been quite fortunate to have them. These APIs are built on the solid foundation provided by the International Components for Unicode (ICU) libraries, which have become the *de facto* way to perform calendrical calculations. By comparison, the libraries available to other languages typically confine themselves to handling only Gregorian dates and provide error-prone implementations and algorithms for manipulating them.

Where the Foundation APIs fall short is not in terms of their power. Everything in this library is built on top of those APIs. Instead, they fall short in making the API easily accessible to developers.

### Imprecise Naming

One of the fundamental stumbling blocks for developers using the Foundation API has to do with the base type itself: `NSDate`. On the surface, it looks like it would correspond to a "[Date](https://en.wikipedia.org/wiki/Calendar_date)" as humans understand it to be, such as "April 1, 1970". This is not the case.

An `NSDate` refers to an instantaneous point in time. It exists independent of any calendaring system and is simply defined as a "time interval since a well-known epoch".

However, because it's called a "Date" (and is even renamed to `Date` when used in Swift), developers *frequently* misinterpret what this value is for and how it should be used. It is exceptionally common to see developers attempt to extend `Date` with calendar-specific information such as:

```swift
extension Date {
    var year: Int { ... }
    var month: Int { ... }
    var day: Int { ... }
}
```

This is as incorrect as attempting to extend `CLLocationCoordinate2D` to have a `var city: String` property.

### Ambiguous Types

Another problematic area of the Foundation API is that the `NSDateComponents` type is used in multiple contexts to mean different things. In one context, `NSDateComponents` describes the calendar-relative values of a point in time: `year: 2020, month: 2, day: 13` means "the 13th day of the 2nd month of the 2020th year", or "13 Feb 2020".

In another context, `NSDateComponents` is used to describe the _calendrical interval_ between two dates: `year: 2020, month: 2, day: 13` means "an interval of 2020 years, 2 months, and 13 days".

This dual usage of `NSDateComponents` makes it difficult to convey proper usage to developers. When an API asks for an `NSDateComponents`, is it wanting the representation of the calendar values? Or is it wanting an interval? The only way to know for sure is by *inferring* intent based on surrounding context and (hopefully) well-named methods. This is error-prone, and makes it difficult for developers to understand how an API should properly be used.

### A Lack of Precision

Because Foundation's primary API is `NSDate`, it is very difficult to have an API to describe calendrical values that are less precise than instantaneous points in time. For example, if you wanted to construct a value that represents "February 2020", you'd be almost entirely out of luck. There is a less-well-known API called `NSDateInterval` but like `NSDate`, that is yet another value that exists independently of any calendaring system.

So for any developer who's wanting to see if "does this calendar value fall within a particular month", they're left with a decent amount of manual calculations they need to perform. Foundation lacks the ability to describe these values in a way that makes sense to users.

### Ambiguous Algorithms

The Foundation API also technically allows for some non-sensical and ambiguous calculations.

For example, if you have an `NSDateComponents` of `{month: 2, day: 28, minute: 13}` (note: missing `year` and `hour`) and attempt to turn it into an `NSDate`, *you can*. However, the answer will be ambiguous. It will *probably* use the current year, but which hour will it pick? In my opinion, this level of ambiguity is undesireable and introduces too much confusion.

`Time` solves this by using type safety to guarantee that all the information necessary to construct a date is provided up-front, and `throwing` an error for the cases where that can't be guaranteed, and the provided information is insufficient.

### Formatting is Hard

Correctly formatting dates can be quite difficult, as we get `M` and `m` mixed up (or `s` vs `S`). But by far the biggest culprit is `y` and `Y`. `y` is used to format "the year according to the specified calendar". On the other hand, `Y` means "the year according to the ISO8601 calendar", which has slightly different semantics around New Years.

The other big issue that most developers think they are safe to use `yyyy` (a four-digit year). For many calendars, they likely would be. But there are other calendars (such as the Japanese calendar or the Republic of China calendar) where this would result in zero-padded year values. 

The complexities around properly building a format string are many. `Time` makes this easier by removing formatting strings entirely, and instead [building the proper string for you](../2-Usage/7-Formatting.md).

### Creating Dates

The Foundation API has you create dates directly using the empty initializer: `Date()` or `[NSDate new]`. This is certainly *convenient* but it relies on hidden global state and fails the [idempotence](https://en.wikipedia.org/wiki/Pure_function) test of well-built initializers.

Additionally, using this initializer means that it is incredibly difficult to override time construction in an app, which can be vital for unit testing or advanced masquerading features.

`Time` solves this problem by eliminating the direct initializer and requiring you to construct calendar values [via a `Clock`](../2-Usage/2-Clock.md).

### Awkward Pluralization

When using an `NSDateComponents` to represent the parts of a calendar date, the name for retrieving its month value would be `month`. However, when using an `NSDateComponents` to represent the *difference* between two dates, the name for retrieving the number of months from the components should be `months`.

However, since `NSDateComponents` is used for two different purposes, it's awkward to have *both* `var month: Int` and `var months: Int` properties on the same object.

In other words, the Foundation API surrounding `NSDateComponents` decreases expressivity and fluency.

`Time` solves this by having properly pluralized properties on `Difference` values, and unpluralized properties on `Values`.

## What should we do about this?

These problems (and others) are why `Time` was created. `Time` solves all of these problems. It uses precise naming, to avoid confusion. It enforces correct and unambiguous algorithms through type safety. It simplifies formatting. 
