//
//  Fixed+Truncation.swift
//  
//
//  Created by Dave DeLong on 2/12/20.
//

import Foundation

extension Fixed where Smallest: LTOEYear {
    
    /// Retrieve the absolute era described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the era will be removed.
    public var absoluteEra: Fixed<Era> { subComponents() }
}

extension Fixed where Smallest: LTOEMonth {
    
    /// Retrieve the absolute year described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the year will be removed.
    public var absoluteYear: Fixed<Year> { subComponents() }
}

extension Fixed where Smallest: LTOEDay {
    
    /// Retrieve the absolute month described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the month will be removed.
    public var absoluteMonth: Fixed<Month> { subComponents() }
}

extension Fixed where Smallest: LTOEHour {
    
    /// Retrieve the absolute day described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the day will be removed.
    public var absoluteDay: Fixed<Day> { subComponents() }
}

extension Fixed where Smallest: LTOEMinute {
    
    /// Retrieve the absolute hour described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the hour will be removed.
    public var absoluteHour: Fixed<Hour> { subComponents() }
}

extension Fixed where Smallest: LTOESecond {
    
    /// Retrieve the absolute minute described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the minute will be removed.
    public var absoluteMinute: Fixed<Minute> { subComponents() }
}

extension Fixed where Smallest: LTOENanosecond {
    
    /// Retrieve the absolute second described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the second will be removed.
    public var absoluteSecond: Fixed<Second> { subComponents() }
}
