import Foundation

extension Fixed where Granularity: LTOEYear {
    
    /// Retrieve the fixed era described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the fixed value;
    /// all of the calendar units smaller than the era will be removed.
    public var fixedEra: Fixed<Era> { truncated() }
}

extension Fixed where Granularity: LTOEMonth {
    
    /// Retrieve the fixed year described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the fixed value;
    /// all of the calendar units smaller than the year will be removed.
    public var fixedYear: Fixed<Year> { truncated() }
}

extension Fixed where Granularity: LTOEDay {
    
    /// Retrieve the fixed month described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the fixed value;
    /// all of the calendar units smaller than the month will be removed.
    public var fixedMonth: Fixed<Month> { truncated() }
}

extension Fixed where Granularity: LTOEHour {
    
    /// Retrieve the fixed day described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the fixed value;
    /// all of the calendar units smaller than the day will be removed.
    public var fixedDay: Fixed<Day> { truncated() }
}

extension Fixed where Granularity: LTOEMinute {
    
    /// Retrieve the fixed hour described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the fixed value;
    /// all of the calendar units smaller than the hour will be removed.
    public var fixedHour: Fixed<Hour> { truncated() }
}

extension Fixed where Granularity: LTOESecond {
    
    /// Retrieve the fixed minute described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the fixed value;
    /// all of the calendar units smaller than the minute will be removed.
    public var fixedMinute: Fixed<Minute> { truncated() }
}

extension Fixed where Granularity: LTOENanosecond {
    
    /// Retrieve the fixed second described by this calendar value.
    ///
    /// In effect, this property returns a truncated version of the fixed value;
    /// all of the calendar units smaller than the second will be removed.
    public var fixedSecond: Fixed<Second> { truncated() }
}
