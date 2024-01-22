//
//  Absolute+Truncation.swift
//  
//
//  Created by Dave DeLong on 2/12/20.
//

import Foundation

extension Absolute where Smallest: LTOEYear {
    
    /// Retrieve the absolute era described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the era will be removed.
    public var absoluteEra: Absolute<Era> { subComponents() }
}

extension Absolute where Smallest: LTOEMonth {
    
    /// Retrieve the absolute year described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the year will be removed.
    public var absoluteYear: Absolute<Year> { subComponents() }
}

extension Absolute where Smallest: LTOEDay {
    
    /// Retrieve the absolute month described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the month will be removed.
    public var absoluteMonth: Absolute<Month> { subComponents() }
}

extension Absolute where Smallest: LTOEHour {
    
    /// Retrieve the absolute day described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the day will be removed.
    public var absoluteDay: Absolute<Day> { subComponents() }
}

extension Absolute where Smallest: LTOEMinute {
    
    /// Retrieve the absolute hour described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the hour will be removed.
    public var absoluteHour: Absolute<Hour> { subComponents() }
}

extension Absolute where Smallest: LTOESecond {
    
    /// Retrieve the absolute minute described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the minute will be removed.
    public var absoluteMinute: Absolute<Minute> { subComponents() }
}

extension Absolute where Smallest: LTOENanosecond {
    
    /// Retrieve the absolute second described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the second will be removed.
    public var absoluteSecond: Absolute<Second> { subComponents() }
}
