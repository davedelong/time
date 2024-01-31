import XCTest
@testable import Time
import protocol Time.Unit

class SerializationTests: XCTestCase {

    static var allTests = [
        ("testCodableRegionRoundTrip", testCodableRegionRoundTrip),
        ("testCodableTimePeriodRoundTrip", testCodableTimePeriodRoundTrip),
        ("testMaliciousPayload", testMaliciousPayload),
        ("testNonEraTimePeriod", testMaliciousPayload),
    ]

    func testCodableRegionRoundTrip() throws {
        let thisRegion = Region.current
        let encodedThis = try JSONEncoder().encode(thisRegion)
        let decodedThis = try JSONDecoder().decode(Region.self, from: encodedThis)
        XCTAssertEqual(thisRegion, decodedThis)

        let explicitRegion = Region(calendar: Calendar(identifier: .gregorian),
                                    timeZone: TimeZone(identifier: "Europe/Paris")!,
                                    locale: Locale(identifier: "fr_FR"))

        let encodedExplicit = try JSONEncoder().encode(explicitRegion)
        let decodedExplicit = try JSONDecoder().decode(Region.self, from: encodedExplicit)
        XCTAssertEqual(explicitRegion, decodedExplicit)
    }

    func testCodableTimePeriodRoundTrip() throws {

        let clock = Clocks.system

        try testRoundTrip(of: clock.thisYear)
        try testRoundTrip(of: clock.thisMonth)
        try testRoundTrip(of: clock.thisDay)
        try testRoundTrip(of: clock.thisHour)
        try testRoundTrip(of: clock.thisMinute)
        try testRoundTrip(of: clock.thisSecond)
        try testRoundTrip(of: clock.thisNanosecond)
    }

    private func testRoundTrip<U: Unit>(of timePeriod: Fixed<U>, file: StaticString = #file, line: UInt = #line) throws {
        let encoded = try JSONEncoder().encode(timePeriod)
        print("JSON: \(String(data: encoded, encoding: .utf8)!)")
        let decoded = try JSONDecoder().decode(Fixed<U>.self, from: encoded)
        XCTAssertEqual(timePeriod, decoded, file: file, line: line)
    }

//    func testNonEraTimePeriod() throws {
//        try testRoundTripOfNonEraPeriod(of: TimePeriod<Year, Year>(region: .current, instant: Clocks.system.thisInstant()))
//        try testRoundTripOfNonEraPeriod(of: TimePeriod<Month, Month>(region: .current, instant: Clocks.system.thisInstant()))
//        try testRoundTripOfNonEraPeriod(of: TimePeriod<Day, Day>(region: .current, instant: Clocks.system.thisInstant()))
//        try testRoundTripOfNonEraPeriod(of: TimePeriod<Hour, Hour>(region: .current, instant: Clocks.system.thisInstant()))
//        try testRoundTripOfNonEraPeriod(of: TimePeriod<Minute, Minute>(region: .current, instant: Clocks.system.thisInstant()))
//        try testRoundTripOfNonEraPeriod(of: TimePeriod<Second, Second>(region: .current, instant: Clocks.system.thisInstant()))
//        try testRoundTripOfNonEraPeriod(of: TimePeriod<Nanosecond, Nanosecond>(region: .current, instant: Clocks.system.thisInstant()))
//
//    }
//
//    private func testRoundTripOfNonEraPeriod<U: Unit>(of timePeriod: TimePeriod<U, U>) throws {
//        let encodedValue = try JSONEncoder().encode(timePeriod)
//        let decodedValue = try JSONDecoder().decode(TimePeriod<U, U>.self, from: encodedValue)
//        XCTAssertEqual(timePeriod, decodedValue)
//    }

    // Test resources were added in a Swift version later than 5.0, which this library supports.

    func testMaliciousPayload() throws {
        let decoder = JSONDecoder()

        let validPayload = generatePayloadFor(year: 2023, month: 01, day: 01, hour: 11, minute: 00, second: 00)
        let _ = try decoder.decode(Fixed<Second>.self, from: validPayload)

        let invalidMonthPayload = generatePayloadFor(year: 2023, month: -4, day: 01, hour: 11, minute: 00, second: 00)
        XCTAssertThrowsError(try decoder.decode(Fixed<Second>.self, from: invalidMonthPayload), "-4 is an invalid calendar month")

        let invalidHourPayload = generatePayloadFor(year: 2023, month: 01, day: 01, hour: 27, minute: 00, second: 00)
        XCTAssertThrowsError(try decoder.decode(Fixed<Second>.self, from: invalidHourPayload), "27 is an invalid hour")

        let invalidDayPayload = generatePayloadFor(year: 2023, month: 01, day: 00, hour: 01, minute: 00, second: 00)
        XCTAssertThrowsError(try decoder.decode(Fixed<Second>.self, from: invalidDayPayload), "0 is an invalid day")

        let payloadMissingPayload = generatePayloadFor(year: 2023, month: 01, day: 01, hour: 01, minute: 00, second: 00)
        XCTAssertThrowsError(try decoder.decode(Fixed<Nanosecond>.self, from: payloadMissingPayload), "Nanoseconds are missing")
    }

    private func generatePayloadFor(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Data {
        // This is very crude.
        
        let string = #"""
        {
            "region": {
                "locale": {
                    "current": 2,
                    "identifier": "en_SE"
                },
                "timeZone": {
                    "autoupdating": true,
                    "identifier": "Europe\/Stockholm"
                },
                "calendar": {
                    "locale": {
                        "current": 2,
                        "identifier": "en_SE"
                    },
                    "timeZone": {
                        "autoupdating": true,
                        "identifier": "Europe\/Stockholm"
                    },
                    "current": 0,
                    "identifier": "gregorian",
                    "minimumDaysInFirstWeek": 4,
                    "firstWeekday": 2
                }
            },
            "components": {
                "era": 1,
                "year": \#(year),
                "month": \#(month),
                "day": \#(day),
                "hour": \#(hour),
                "minute": \#(minute),
                "second": \#(second)
            }
        }
        """#
        
        return Data(string.utf8)
    }
    
    func testOldSerializationFormat() throws {
        let jsonString = """
        [
            {
                "value": 728405072,
                "region": {
                    "calendar": {
                        "firstWeekday": 1,
                        "minimumDaysInFirstWeek": 1,
                        "identifier": "gregorian",
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        }
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    },
                    "locale": {
                        "identifier": "en_SE"
                    }
                }
            },
            {
                "value": 728406872,
                "region": {
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    },
                    "locale": {
                        "identifier": "en_SE"
                    },
                    "calendar": {
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "minimumDaysInFirstWeek": 1,
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "firstWeekday": 1,
                        "identifier": "gregorian"
                    }
                }
            },
            {
                "region": {
                    "locale": {
                        "identifier": "en_SE"
                    },
                    "calendar": {
                        "identifier": "gregorian",
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "firstWeekday": 1,
                        "minimumDaysInFirstWeek": 1,
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        }
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    }
                },
                "value": 728405072
            },
            {
                "region": {
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    },
                    "calendar": {
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "minimumDaysInFirstWeek": 1,
                        "firstWeekday": 1,
                        "identifier": "gregorian"
                    },
                    "locale": {
                        "identifier": "en_SE"
                    }
                },
                "value": 728406872
            },
            {
                "value": 728175606.030619,
                "region": {
                    "calendar": {
                        "firstWeekday": 2,
                        "minimumDaysInFirstWeek": 4,
                        "identifier": "gregorian",
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        }
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    },
                    "locale": {
                        "identifier": "en_SE"
                    }
                }
            },
            {
                "region": {
                    "locale": {
                        "identifier": "en_SE"
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    },
                    "calendar": {
                        "firstWeekday": 2,
                        "identifier": "gregorian",
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "minimumDaysInFirstWeek": 4
                    }
                },
                "value": 728262004.728645
            },
            {
                "value": 728406871,
                "region": {
                    "locale": {
                        "identifier": "en_SE"
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    },
                    "calendar": {
                        "firstWeekday": 1,
                        "minimumDaysInFirstWeek": 1,
                        "identifier": "gregorian",
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        }
                    }
                }
            },
            {
                "value": 728319007.785119,
                "region": {
                    "calendar": {
                        "firstWeekday": 2,
                        "identifier": "gregorian",
                        "minimumDaysInFirstWeek": 4,
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "locale": {
                            "identifier": "en_SE"
                        }
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    },
                    "locale": {
                        "identifier": "en_SE"
                    }
                }
            },
            {
                "value": 728491625,
                "region": {
                    "calendar": {
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "minimumDaysInFirstWeek": 1,
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "identifier": "gregorian",
                        "firstWeekday": 1
                    },
                    "locale": {
                        "identifier": "en_SE"
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    }
                }
            },
            {
                "value": 728493425,
                "region": {
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    },
                    "calendar": {
                        "identifier": "gregorian",
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "firstWeekday": 1,
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "minimumDaysInFirstWeek": 1
                    },
                    "locale": {
                        "identifier": "en_SE"
                    }
                }
            },
            {
                "value": 728491625,
                "region": {
                    "calendar": {
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "firstWeekday": 1,
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "identifier": "gregorian",
                        "minimumDaysInFirstWeek": 1
                    },
                    "locale": {
                        "identifier": "en_SE"
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    }
                }
            },
            {
                "value": 728493425,
                "region": {
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    },
                    "calendar": {
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "firstWeekday": 1,
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "identifier": "gregorian",
                        "minimumDaysInFirstWeek": 1
                    },
                    "locale": {
                        "identifier": "en_SE"
                    }
                }
            },
            {
                "value": 728370608.047602,
                "region": {
                    "calendar": {
                        "firstWeekday": 2,
                        "minimumDaysInFirstWeek": 4,
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "identifier": "gregorian"
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    },
                    "locale": {
                        "identifier": "en_SE"
                    }
                }
            },
            {
                "value": 728578177,
                "region": {
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    },
                    "locale": {
                        "identifier": "en_SE"
                    },
                    "calendar": {
                        "firstWeekday": 1,
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "minimumDaysInFirstWeek": 1,
                        "identifier": "gregorian",
                        "locale": {
                            "identifier": "en_SE"
                        }
                    }
                }
            },
            {
                "value": 728579977,
                "region": {
                    "calendar": {
                        "firstWeekday": 1,
                        "minimumDaysInFirstWeek": 1,
                        "identifier": "gregorian",
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "locale": {
                            "identifier": "en_SE"
                        }
                    },
                    "locale": {
                        "identifier": "en_SE"
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    }
                }
            },
            {
                "region": {
                    "locale": {
                        "identifier": "en_SE"
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    },
                    "calendar": {
                        "identifier": "gregorian",
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "minimumDaysInFirstWeek": 1,
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "firstWeekday": 1
                    }
                },
                "value": 728578177
            },
            {
                "region": {
                    "calendar": {
                        "identifier": "gregorian",
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        },
                        "minimumDaysInFirstWeek": 1,
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "firstWeekday": 1
                    },
                    "locale": {
                        "identifier": "en_SE"
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    }
                },
                "value": 728579977
            },
            {
                "region": {
                    "calendar": {
                        "firstWeekday": 2,
                        "minimumDaysInFirstWeek": 4,
                        "identifier": "gregorian",
                        "locale": {
                            "identifier": "en_SE"
                        },
                        "timeZone": {
                            "identifier": "Europe\\/Stockholm"
                        }
                    },
                    "locale": {
                        "identifier": "en_SE"
                    },
                    "timeZone": {
                        "identifier": "Europe\\/Stockholm"
                    }
                },
                "value": 728392809.920091
            }
        ]
"""
        let jsonData = Data(jsonString.utf8)
        
        do {
            let timestamps = try JSONDecoder().decode(Array<Fixed<Nanosecond>>.self, from: jsonData)
            XCTAssertEqual(timestamps.count, 18)
        } catch {
            XCTFail("Cannot decode json: \(error)")
        }
    }

}
