//
//  Absolute.swift
//  
//
//  Created by Dave DeLong on 10/20/19.
//

import Foundation

extension Value where Largest: GTOEEra {

    public init(region: Region, instant: Instant) {
        self.init(region: region, date: instant.date)
    }

    public init(region: Region, date: Date) {
        let dc = region.components(Self.representedComponents, from: date)
        self.init(region: region, dateComponents: dc)
    }

}
