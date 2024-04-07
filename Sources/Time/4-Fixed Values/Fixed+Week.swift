import Foundation

extension Fixed where Granularity: LTMonth {
    
    public var weekOfMonth: Int {
        #warning("TODO: verify")
        return calendar.component(.weekOfMonth, from: self.approximateMidPoint.date)
    }
    
    public var weekOfYear: Int {
        #warning("TODO: verify")
        return calendar.component(.weekOfYear, from: self.approximateMidPoint.date)
    }
    
}

extension Fixed where Granularity: StandardUnit & GTOEMonth & LTOEYear {
    
    public var firstWeek: Fixed<Week> { first() }
    
    public var lastWeek: Fixed<Week> { .init(region: region, instant: lastDay.firstInstant) }
    
    public var firstFullWeek: Fixed<Week>? {
        let thisRange = self.range
        let firstWeek = self.firstWeek
        let firstWeekRelation = firstWeek.range.determineRelationship(to: thisRange)
        
        if firstWeekRelation == .starts || firstWeekRelation == .during || firstWeekRelation == .finishes {
            return firstWeek
        }
        
        // the first week isn't sufficient; try the next week
        let secondWeek = firstWeek.next
        let secondWeekRelation = secondWeek.range.determineRelationship(to: thisRange)
        
        if secondWeekRelation == .starts || secondWeekRelation == .during || secondWeekRelation == .finishes {
            return secondWeek
        }
        
        // this unit does not last an entire week
        return nil
    }
    
    public var lastFullWeek: Fixed<Week>? {
        let thisRange = self.range
        let lastWeek = self.lastWeek
        let lastWeekRelation = lastWeek.range.determineRelationship(to: thisRange)
        
        if lastWeekRelation == .starts || lastWeekRelation == .during || lastWeekRelation == .finishes {
            return lastWeek
        }
        
        // the last week isn't sufficient; try the send-to-last week
        let secondWeek = lastWeek.previous
        let secondWeekRelation = secondWeek.range.determineRelationship(to: thisRange)
        
        if secondWeekRelation == .starts || secondWeekRelation == .during || secondWeekRelation == .finishes {
            return secondWeek
        }
        
        // this unit does not last an entire week
        return nil
    }
    
    /// Retrieve a specific 1-based week from this month
    ///
    /// Example:
    /// ```
    /// let firstWeek = try thisFixedMonth.nthWeek(1)
    /// let secondWeek = try thisFixedMonth.nthWeek(2)
    /// ```
    ///
    /// - Parameter ordinal: The week number
    /// - Returns: a fixed week
    /// - Throws: This method throws a ``TimeError`` if `ordinal` is outside the range of values allowed by the `.calendar`.
    ///
    /// - Note: The allowable values for `ordinal` depend on the fixed value's `.calendar`.
    /// For example, getting the `.nthWeek(8)` of a `Fixed<Month>` will throw an error, because no supported calendar has a month
    /// with more than about 5 weeks. However, getting the `.nthWeek(8)` of a `Fixed<Year>` is fine, because years typically have at least
    /// 50 weeks in them.
    ///
    /// - Warning: The first day of the first week will likely *not* be the same as the first day of the month, and may not be in the month at all.
    /// Each ``Region`` has its own rules about how weeks are attributed to months.
    public func nthWeek(_ ordinal: Int) throws -> Fixed<Week> {
        let unit = Granularity.self == Year.self ? Calendar.Component.weekOfYear : .weekOfMonth
        let dc = DateComponents(value: ordinal, component: unit)
        
        guard ordinal >= 1 else {
            throw TimeError.invalidDateComponents(dc, in: region, description: "Invalid ordinal of \(ordinal) weeks")
        }
        
        let first = self.firstWeek
        let target = first.adding(weeks: ordinal - 1)
        let middleOfWeek = try target.nthDay(4)
        guard middleOfWeek.truncated() == self else {
            throw TimeError.invalidDateComponents(dc, in: region, description: "Invalid ordinal of \(ordinal) weeks")
        }
        return target
    }
    
}

extension Fixed where Granularity: StandardUnit & GTOEMonth & LTOEYear {
    
    public var weeks: FixedSequence<Week> {
        return FixedSequence(start: self.firstWeek,
                             stride: .weeks(1),
                             while: { $0.lastDay.truncated() == self })
    }
    
}
