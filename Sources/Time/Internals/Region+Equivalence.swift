import Foundation

extension Region {
    
    func isEquivalent(to other: Region) -> Bool {
        return calendar.isEquivalent(to: other.calendar) &&
               timeZone.isEquivalent(to: other.timeZone) &&
               locale.isEquivalent(to: other.locale)
    }
    
}
