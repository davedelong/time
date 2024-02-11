//
//  File.swift
//  
//
//  Created by Dave DeLong on 2/11/24.
//

import Foundation

extension Calendar {
    
    func isEquivalent(to other: Calendar) -> Bool {
        guard identifier == other.identifier else { return false }
        guard timeZone.isEquivalent(to: other.timeZone) else { return false }
        guard firstWeekday == other.firstWeekday else { return false }
        guard minimumDaysInFirstWeek == other.minimumDaysInFirstWeek else { return false }
        
        return true
    }
    
}

extension TimeZone {
    
    func isEquivalent(to other: TimeZone) -> Bool {
        guard identifier == other.identifier else { return false }
        
        return true
    }
    
}

extension Locale {
    
    func isEquivalent(to other: Locale) -> Bool {
        guard calendar.identifier == other.calendar.identifier else { return false }
        guard collation == other.collation else { return false }
        guard currency == other.currency else { return false }
        guard firstDayOfWeek == other.firstDayOfWeek else { return false }
        guard hourCycle == other.hourCycle else { return false }
        
        guard measurementSystem == other.measurementSystem else { return false }
        guard numberingSystem == other.numberingSystem else { return false }
        guard region == other.region else { return false }
        guard subdivision == other.subdivision else { return false }
        guard variant == other.variant else { return false }
        
        guard language == other.language else { return false }
        
        return true
    }
    
}
