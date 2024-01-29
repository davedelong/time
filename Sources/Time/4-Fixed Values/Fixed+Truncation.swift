//
//  Fixed+Truncation.swift
//  
//
//  Created by Dave DeLong on 2/12/20.
//

import Foundation

extension Fixed where Smallest: LTOEYear {
    
    /// Retrieve the fixed era described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the era will be removed.
    public var fixedEra: Fixed<Era> { subComponents() }
}

extension Fixed where Smallest: LTOEMonth {
    
    /// Retrieve the fixed year described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the year will be removed.
    public var fixedYear: Fixed<Year> { subComponents() }
}

extension Fixed where Smallest: LTOEDay {
    
    /// Retrieve the fixed month described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the month will be removed.
    public var fixedMonth: Fixed<Month> { subComponents() }
}

extension Fixed where Smallest: LTOEHour {
    
    /// Retrieve the fixed day described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the day will be removed.
    public var fixedDay: Fixed<Day> { subComponents() }
}

extension Fixed where Smallest: LTOEMinute {
    
    /// Retrieve the fixed hour described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the hour will be removed.
    public var fixedHour: Fixed<Hour> { subComponents() }
}

extension Fixed where Smallest: LTOESecond {
    
    /// Retrieve the fixed minute described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the minute will be removed.
    public var fixedMinute: Fixed<Minute> { subComponents() }
}

extension Fixed where Smallest: LTOENanosecond {
    
    /// Retrieve the fixed second described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the receiver;
    /// all of the calendar units smaller than the second will be removed.
    public var fixedSecond: Fixed<Second> { subComponents() }
}
