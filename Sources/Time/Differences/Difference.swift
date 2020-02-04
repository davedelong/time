//
//  File.swift
//  
//
//  Created by Dave DeLong on 2/4/20.
//

import Foundation

extension Value where Largest: GTOEEra {
    
    func computeInterval<S: Unit, L: Unit>(to other: Value<Smallest, Largest>) -> Delta<S, L> {
        
        let thisMid = self.approximateMidPoint.date
        let otherMid = other.approximateMidPoint.date
        
        let units = componentsFrom(lower: S.self, to: L.self)
        let difference = calendar.dateComponents(units, from: thisMid, to: otherMid)
        return Delta(difference)
    }
    
}
