#  Release Notes

A brief history of **Time**.

## 1.0.2

11 April, 2024

- Fixed an issue where differences in whole values could produce values that were off by one unit
- Fixed an issue where Fixed values created without an era would crash when attempting to access their ``Fixed/era``

- [Github release](https://github.com/davedelong/time/releases/tag/1.0.2)

## 1.0.1

10 March, 2024

- The time zone is selectively included in the ``Fixed/description`` of fixed values (#73)
- ``Relation``, ``RoundingDirection``, ``Fixed``, ``TimeDifference``, and ``Template`` now conform to `Sendable` (#78)

- [Github release](https://github.com/davedelong/time/releases/tag/1.0.1)


## 1.0.0

29 February, 2024 - The initial release of **Time**.

In particular, thanks go to [Daniel Kennett][ikenndac], [Nathan Harris][mordil], [Reed Harston][rtharston], [Noah Blake][nononoah], and [Francis Chary][churowa] for their comments and suggestions on the 1.0 API and feature set, and especially for putting up with a constant stream of questions and requests for feedback. Additionally, a huge thanks to [Tim Vermeulen][timvermeulen] for helping formalize **Time**'s type safety via an astoundingly clever application of protocols.

- [Github release](https://github.com/davedelong/time/releases/tag/1.0.0)

[churowa]: https://github.com/churowa
[ikenndac]: https://github.com/ikenndac
[mordil]: https://github.com/mordil
[nononoah]: https://github.com/nononoah
[rtharston]: https://github.com/rtharston
[timvermeulen]: https://github.com/timvermeulen
