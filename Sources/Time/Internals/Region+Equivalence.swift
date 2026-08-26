import Foundation

extension Region {
    
    func isEquivalent(to other: Region) -> Bool {
        return anyCalendar.isEquivalent(to: other.anyCalendar) &&
               timeZone.isEquivalent(to: other.timeZone) &&
               locale.isEquivalent(to: other.locale)
    }
    
}
