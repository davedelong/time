//
//  Absolute.swift
//  
//
//  Created by Dave DeLong on 2/12/20.
//

import Foundation

extension Absolute where Largest == Era {
    
    /// Retrieve the `Range` of `Instants` described by this absolute `Value`.
    ///
    /// All absolute values contain many possible `Instants`. This property allows you
    /// to retrieve that range to use in calculations, such as knowing things like:
    /// - do these two calendar values overlap?
    /// - is this calendar value contained within this other calendar value?
    /// - etc
    public var range: Range<Instant> {
        let range = calendar.range(containing: self.anchorDate, in: self.representedComponents)
        
        return Instant(date: range.lowerBound) ..< Instant(date: range.upperBound)
    }
    
    /// Retrieve the first `Instant` known to occur within this `Value`.
    public var firstInstant: Instant { return range.lowerBound }
    
    @available(*, unavailable, message: "It's impossible to know the last instant of a calendar value, just like it's impossible to know the last number before 1.0")
    public var lastInstant: Instant { fatalError() }
    
}
