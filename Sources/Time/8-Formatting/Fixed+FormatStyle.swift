//
//  File.swift
//  
//
//  Created by Dave DeLong on 1/20/24.
//

import Foundation

public struct FixedFormatStyle: Hashable {
    
    /// An extremely verbose format style.
    ///
    /// When applied to date values, a full format style includes the weekday name and fully-spelled-out month name.
    ///
    /// Example: `Monday, January 1, 2024`
    ///
    /// When applied to time values, it includes the time down to the second a fully-spelled-out time zone names.
    ///
    /// Example: `3:12:43 AM Central Standard Time`
    public static let full = FixedFormatStyle(style: .full)
    
    /// A verbose format style.
    ///
    /// When applied to date values, it includes the fully-spelled-out month name.
    ///
    /// Example: `January 1, 2024`
    ///
    /// When applied to time values, it includes the time down to the second and abbreviated time zone information.
    ///
    /// Example: `3:12:43 AM CST`
    public static let long = FixedFormatStyle(style: .long)
    
    /// A simple format style.
    ///
    /// When applied to dates, it includes an abbreviated month name.
    ///
    /// Example: `Jan 1, 2024`
    ///
    /// When applied to time values, it includes the time down to the second.
    ///
    /// Example: `3:12:43 AM`
    public static let medium = FixedFormatStyle(style: .medium)
    
    /// A terse format style.
    ///
    /// When applied to date values, it uses abbreviated numeric values.
    ///
    /// Example: `1/1/24`
    ///
    /// When applied to time values, it omits seconds.
    ///
    /// Example: `3:12 AM`
    public static let short = FixedFormatStyle(style: .short)
    
    internal let style: DateFormatter.Style
    
}

extension Fixed where Granularity: LTOEDay {
    
    /// Format the fixed value's date information
    /// - Parameter dateStyle: The `FixedFormatStyle` to use
    /// - Returns: A localized string containing the formatted date information
    public func format(date dateStyle: FixedFormatStyle) -> String {
        let style = FixedFormat<Granularity>(dateStyle: dateStyle.style, timeStyle: .none)
        return self.format(style)
    }
    
}

extension Fixed where Granularity: LTOEMinute {
    
    /// Format the fixed value's date and time information
    ///
    /// - Parameters:
    ///   - dateStyle: The `FixedFormatStyle` to use for the date information
    ///   - timeStyle: The `FixedFormatStyle` to use for the time information
    /// - Returns: A string containing the localized formatted date and time information
    /// - Note: Formatting the time using the `.full`, `.long`, or `.medium` format styles will produce a string that displays a seconds value.
    /// If these are used on a `Fixed<Minute>` value, then it will assume the seconds component is `:00`.
    public func format(date dateStyle: FixedFormatStyle, time timeStyle: FixedFormatStyle) -> String {
        let style = FixedFormat<Granularity>(dateStyle: dateStyle.style, timeStyle: timeStyle.style)
        return self.format(style)
    }
    
    /// Format the fixed value's time information
    ///
    /// - Parameter timeStyle: The `FixedFormatStyle` to use
    /// - Returns: A string containing the localized formatted time information
    /// - Note: Formatting the time using the `.full`, `.long`, or `.medium` format styles will produce a string that displays a seconds value.
    /// If these are used on a `Fixed<Minute>` value, then it will assume the seconds component is `:00`.
    public func format(time timeStyle: FixedFormatStyle) -> String {
        let style = FixedFormat<Granularity>(dateStyle: .none, timeStyle: timeStyle.style)
        return self.format(style)
    }
    
}
