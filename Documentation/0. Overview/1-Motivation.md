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

February + 3 seconds

### Formatting is Hard

`y` vs `Y` vs `yyyy`.

## Why do we need this?

These problems (and others) are why `Time` was created. `Time` solves all of these problems. It uses precise naming, to avoid confusion. It enforces correct algorithms through type safety. It simplifies formatting. 
