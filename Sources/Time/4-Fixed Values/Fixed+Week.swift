import Foundation

extension Fixed where Granularity: StandardUnit & GTOEMonth & LTOEYear {
    
    /// The week that includes the first day of this value
    public var firstOverlappingWeek: Fixed<Week> { first() }
    
    /// The week that includes the last day of this value
    public var lastOverlappingWeek: Fixed<Week> { .init(region: region, instant: lastDay.firstInstant) }
    
    /// The first week that is fully contained by this unit, if it exists.
    public var firstFullWeek: Fixed<Week>? {
        let thisRange = self.range
        let firstWeek = self.firstOverlappingWeek
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
    
    /// The last week that is fully contained by this unit, if it exists.
    public var lastFullWeek: Fixed<Week>? {
        let thisRange = self.range
        let lastWeek = self.lastOverlappingWeek
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
    
    /// Retrieve a specific 1-based full week from this fixed value
    ///
    /// Example:
    /// ```
    /// let firstWeek = try thisFixedMonth.nthFullWeek(1)
    /// let secondWeek = try thisFixedMonth.nthFullWeek(2)
    /// ```
    ///
    /// - Parameter ordinal: The week number
    /// - Returns: a fixed week
    /// - Throws: This method throws a ``TimeError`` if `ordinal` is outside the range of values allowed by the `.calendar`.
    ///
    /// - Note: The allowable values for `ordinal` depend on the fixed value's `.calendar`.
    /// For example, getting the `.nthFullWeek(8)` of a `Fixed<Month>` will throw an error, because no supported calendar has a month
    /// with more than about 5 weeks. However, getting the `.nthFullWeek(8)` of a `Fixed<Year>` is fine, because years typically have at least
    /// 50 weeks in them.
    ///
    /// - Warning: The first day of the first week will likely *not* be the same as the first day of the month, and may not be in the month at all.
    /// Each ``Region`` has its own rules about how weeks are attributed to months.
    public func nthFullWeek(_ ordinal: Int) throws(TimeError) -> Fixed<Week> {
        let unit = Granularity.self == Year.self ? Calendar.Component.weekOfYear : .weekOfMonth
        let dc = DateComponents(value: ordinal, component: unit)
        
        guard ordinal >= 1 else {
            throw TimeError.invalidDateComponents(dc, in: region, description: "Invalid ordinal of \(ordinal) weeks")
        }
        
        guard let first = self.firstFullWeek else {
            throw TimeError.invalidDateComponents(dc, in: region, description: "\(self.description) does not contain a single full week")
        }
        
        let targetWeek = first.adding(weeks: ordinal - 1)
        let lastDayOfTargetWeek = targetWeek.lastDay
        guard lastDayOfTargetWeek.truncated() == self else {
            throw TimeError.invalidDateComponents(dc, in: region, description: "Invalid ordinal of \(ordinal) weeks")
        }
        return targetWeek
    }
    
}

extension Fixed where Granularity: StandardUnit & GTOEMonth & LTOEYear {
    
    /// A sequence of all the weeks that overlap with this value.
    public var overlappingWeeks: FixedSequence<Week> {
        return FixedSequence(start: self.firstOverlappingWeek,
                             stride: .weeks(1),
                             while: { week in
            week.days.contains(where: { $0.truncated() == self })
        })
    }
    
    /// A sequence of all the weeks that are fully contained in this value.
    ///
    /// May result in an empty sequence if this value doesn't contain a single full week.
    public var fullWeeks: FixedSequence<Week> {
        // if this value does not contain a full week, return an empty sequence
        guard let first = self.firstFullWeek else { return .init() }
        
        return FixedSequence(start: first,
                             stride: .weeks(1),
                             while: { self.contains($0) })
    }
    
}
