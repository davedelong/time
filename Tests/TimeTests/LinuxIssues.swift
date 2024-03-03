import Foundation
import XCTest
@testable import Time

class LinuxIssues: XCTestCase {
    
    func testFormatting() throws {
        /*
         While working on the fix for Issue #75, it became apparent that Linux is not formatting dates correctly.
         
         This was manifest in the unit tests when formatting a date using the "c" format. This format should be the
         numeric day of the week, but on Linux it was returning the abbreviated name ("Sun" instead of "1", for example
         */
        let now = try Fixed(region: .posix, year: 2024, month: 3, day: 3, hour: 6, minute: 3, second: 1, nanosecond: 123_000_000)
        
        let allFormats: Array<(Format, String, String, StaticString, UInt)> = [
            // Date Format Template                                                             Raw Format Value        Template Format Value   File    Line
            (Template<Era>.abbreviated,                                                         "AD",                   "AD",                   #file,  #line),
            (Template<Era>.narrow,                                                              "A",                    "A",                    #file,  #line),
            (Template<Era>.wide,                                                                "Anno Domini",          "Anno Domini",          #file,  #line),
            
            (Template<Year>.naturalDigits,                                                      "2024",                 "2024",                 #file,  #line),
            (Template<Year>.twoDigits,                                                          "24",                   "24",                   #file,  #line),
            (Template<Year>.digits(paddedToLength: 3),                                          "2024",                 "2024",                 #file,  #line),
            (Template<Year>.digits(paddedToLength: 4),                                          "2024",                 "2024",                 #file,  #line),
            (Template<Year>.digits(paddedToLength: 5),                                          "02024",                "02024",                #file,  #line),
            
            (Template<Month>.naturalName,                                                       "March",                "March",                #file,  #line),
            (Template<Month>.abbreviatedName,                                                   "Mar",                  "Mar",                  #file,  #line),
            (Template<Month>.narrowName,                                                        "M",                    "M",                    #file,  #line),
            (Template<Month>.naturalDigits,                                                     "3",                    "3",                    #file,  #line),
            (Template<Month>.twoDigits,                                                         "03",                   "03",                   #file,  #line),
            
            (Template<Standalone<Month>>.naturalDigits,                                         "3",                    "3",                    #file,  #line),
            (Template<Standalone<Month>>.twoDigits,                                             "03",                   "03",                   #file,  #line),
            (Template<Standalone<Month>>.naturalName,                                           "March",                "March",                #file,  #line),
            (Template<Standalone<Month>>.abbreviatedName,                                       "Mar",                  "Mar",                  #file,  #line),
            (Template<Standalone<Month>>.narrowName,                                            "M",                    "M",                    #file,  #line),
            
            (Template<Day>.naturalDigits,                                                       "3",                    "3",                    #file,  #line),
            (Template<Day>.twoDigits,                                                           "03",                   "03",                   #file,  #line),
            
            (Template<Weekday>.naturalDigits,                                                   "1",                    "1",                    #file,  #line),
            (Template<Weekday>.twoDigits,                                                       "01",                   "1",                    #file,  #line),
            (Template<Weekday>.naturalName,                                                     "Sunday",               "Sunday",               #file,  #line),
            (Template<Weekday>.abbreviatedName,                                                 "Sun",                  "Sun",                  #file,  #line),
            (Template<Weekday>.shortName,                                                       "Su",                   "Su",                   #file,  #line),
            (Template<Weekday>.narrowName,                                                      "S",                    "S",                    #file,  #line),
            
            (Template<Standalone<Weekday>>.naturalDigits,                                       "1",                    "1",                    #file,  #line),
            (Template<Standalone<Weekday>>.naturalName,                                         "Sunday",               "Sunday",               #file,  #line),
            (Template<Standalone<Weekday>>.abbreviatedName,                                     "Sun",                  "Sun",                  #file,  #line),
            (Template<Standalone<Weekday>>.shortName,                                           "Su",                   "Su",                   #file,  #line),
            (Template<Standalone<Weekday>>.narrowName,                                          "S",                    "S",                    #file,  #line),
            
            (Template<DayPeriod>.natural,                                                       "AM",                   "AM",                   #file,  #line),
            (Template<DayPeriod>.wide,                                                          "AM",                   "AM",                   #file,  #line),
            (Template<DayPeriod>.narrow,                                                        "a",                    "a",                    #file,  #line),
            
            // the Template<Hour> methods can't be used here, because they define templates,
            // and this unit test will use the underlying `.template` as a raw dateFormat
            (Template<Hour>("h"),                                                               "6",                    "6 AM",                 #file,  #line),
            (Template<Hour>("h a"),                                                             "6 AM",                 "6 AM",                 #file,  #line),
            (Template<Hour>("h aaaa"),                                                          "6 AM",                 "6 AM",                 #file,  #line),
            (Template<Hour>("h aaaaa"),                                                         "6 a",                  "6 a",                  #file,  #line),
            
            (Template<Hour>("hh"),                                                              "06",                   "6 AM",                 #file,  #line),
            (Template<Hour>("hh a"),                                                            "06 AM",                "6 AM",                 #file,  #line),
            (Template<Hour>("hh aaaa"),                                                         "06 AM",                "6 AM",                 #file,  #line),
            (Template<Hour>("hh aaaaa"),                                                        "06 a",                 "6 a",                  #file,  #line),
            
            (Template<Hour>("H"),                                                               "6",                    "06",                   #file,  #line),
            (Template<Hour>("H a"),                                                             "6 AM",                 "06",                   #file,  #line),
            (Template<Hour>("H aaaa"),                                                          "6 AM",                 "06",                   #file,  #line),
            (Template<Hour>("H aaaaa"),                                                         "6 a",                  "06",                   #file,  #line),
            
            (Template<Hour>("HH"),                                                              "06",                   "06",                   #file,  #line),
            (Template<Hour>("HH a"),                                                            "06 AM",                "06",                   #file,  #line),
            (Template<Hour>("HH aaaa"),                                                         "06 AM",                "06",                   #file,  #line),
            (Template<Hour>("HH aaaaa"),                                                        "06 a",                 "06",                   #file,  #line),
            
            (Template<Hour>("k"),                                                               "6",                    "06",                   #file,  #line),
            (Template<Hour>("k a"),                                                             "6 AM",                 "06",                   #file,  #line),
            (Template<Hour>("k aaaa"),                                                          "6 AM",                 "06",                   #file,  #line),
            (Template<Hour>("k aaaaa"),                                                         "6 a",                  "06",                   #file,  #line),
            
            (Template<Hour>("kk"),                                                              "06",                   "06",                   #file,  #line),
            (Template<Hour>("kk a"),                                                            "06 AM",                "06",                   #file,  #line),
            (Template<Hour>("kk aaaa"),                                                         "06 AM",                "06",                   #file,  #line),
            (Template<Hour>("kk aaaaa"),                                                        "06 a",                 "06",                   #file,  #line),
            
            (Template<Hour>("K"),                                                               "6",                    "6 AM",                 #file,  #line),
            (Template<Hour>("K a"),                                                             "6 AM",                 "6 AM",                 #file,  #line),
            (Template<Hour>("K aaaa"),                                                          "6 AM",                 "6 AM",                 #file,  #line),
            (Template<Hour>("K aaaaa"),                                                         "6 a",                  "6 a",                  #file,  #line),
            
            (Template<Hour>("KK"),                                                              "06",                   "6 AM",                 #file,  #line),
            (Template<Hour>("KK a"),                                                            "06 AM",                "6 AM",                 #file,  #line),
            (Template<Hour>("KK aaaa"),                                                         "06 AM",                "6 AM",                 #file,  #line),
            (Template<Hour>("KK aaaaa"),                                                        "06 a",                 "6 a",                  #file,  #line),
            
            (Template<Minute>.naturalDigits,                                                    "3",                    "3",                    #file,  #line),
            (Template<Minute>.twoDigits,                                                        "03",                   "3",                    #file,  #line),
            
            (Template<Second>.naturalDigits,                                                    "1",                    "1",                    #file,  #line),
            (Template<Second>.twoDigits,                                                        "01",                   "1",                    #file,  #line),
            
            (Template<Nanosecond>.digits(1),                                                    "1",                    "1",                    #file,  #line),
            (Template<Nanosecond>.digits(2),                                                    "12",                   "12",                   #file,  #line),
            (Template<Nanosecond>.digits(3),                                                    "123",                  "123",                  #file,  #line),
            
            (Template<TimeZone>.shortSpecific,                                                  "GMT",                  "GMT",                  #file,  #line),
            (Template<TimeZone>.longSpecific,                                                   "Greenwich Mean Time",  "Greenwich Mean Time",  #file,  #line),
            (Template<TimeZone>.ISO8601Basic,                                                   "+0000",                "+0000",                #file,  #line),
            (Template<TimeZone>.ISO8601Extended,                                                "Z",                    "Z",                    #file,  #line),
            (Template<TimeZone>.shortLocalizedGMT,                                              "GMT",                  "GMT",                  #file,  #line),
            (Template<TimeZone>.longLocalizedGMT,                                               "GMT",                  "GMT",                  #file,  #line),
            (Template<TimeZone>.shortGeneric,                                                   "GMT",                  "GMT",                  #file,  #line),
            (Template<TimeZone>.longGeneric,                                                    "Greenwich Mean Time",  "Greenwich Mean Time",  #file,  #line),
            (Template<TimeZone>.shortID,                                                        "gmt",                  "gmt",                  #file,  #line),
            (Template<TimeZone>.longID,                                                         "GMT",                  "GMT",                  #file,  #line),
            (Template<TimeZone>.exemplarCity,                                                   "Unknown City",         "Unknown City",         #file,  #line),
            (Template<TimeZone>.genericLocation,                                                "GMT",                  "GMT",                  #file,  #line),
            (Template<TimeZone>.ISO8601BasicWithHours(includingZ: true),                        "Z",                    "Z",                    #file,  #line),
            (Template<TimeZone>.ISO8601BasicWithHours(includingZ: false),                       "+00",                  "+00",                  #file,  #line),
            (Template<TimeZone>.ISO8601WithHoursAndMinutes(extended: false, includingZ: false), "+0000",                "+0000",                #file,  #line),
            (Template<TimeZone>.ISO8601WithHoursAndMinutes(extended: false, includingZ: true),  "Z",                    "Z",                    #file,  #line),
            (Template<TimeZone>.ISO8601WithHoursAndMinutes(extended: true, includingZ: false),  "+00:00",               "+00:00",               #file,  #line),
            (Template<TimeZone>.ISO8601WithHoursAndMinutes(extended: true, includingZ: true),   "Z",                    "Z",                    #file,  #line),
        ]
        
        for (format, expectedRaw, expectedTemplate, file, line) in allFormats {
            let rawStyle = FixedFormat<Nanosecond>(raw: format.template)
            let templateStyle = FixedFormat<Nanosecond>(templates: [format])
            
            // on macOS, some of the formats use unusual whitespace characters in format string
            // this replaces them with plain whitespace to make comparison a bit more consistent.
            // You should not do this in a production environment.
            let rawFormatted = String(now.format(rawStyle).map { $0.isWhitespace ? " " : $0 })
            let templateFormatted = String(now.format(templateStyle).map { $0.isWhitespace ? " " : $0 })
            
            XCTAssertEqual(rawFormatted, expectedRaw, "Raw format '\(format.template)' produced '\(rawFormatted)' instead of '\(expectedRaw)'", file: file, line: line)
            XCTAssertEqual(templateFormatted, expectedTemplate, "Template '\(format.template)' produced '\(templateFormatted)' instead of '\(expectedTemplate)'", file: file, line: line)
        }
        
    }
    
}
