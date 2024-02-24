import Foundation

extension Locale {
    
    func isEquivalent(to other: Locale) -> Bool {
        #if os(Linux)
        guard identifier == other.identifier else { return false }
        guard bcp47HourCycle == other.bcp47HourCycle else { return false }
        guard bcp47FirstWeekday == other.bcp47FirstWeekday else { return false }
        
        #else
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
        #endif
        
        return true
    }
    
    var isLikelyAutoupdating: Bool { self == .autoupdatingCurrent }
    
    var loggingDescription: String {
        if self.isEquivalent(to: Locale.standard(self.identifier)) { return self.identifier }
        return self.debugDescription
    }
    
    internal var bcp47FirstWeekday: String? {
        switch calendar.firstWeekday {
            case 1: return "sun"
            case 2: return "mon"
            case 3: return "tue"
            case 4: return "wed"
            case 5: return "thu"
            case 6: return "fri"
            case 7: return "sat"
            default: return nil
        }
    }
    
    internal var bcp47HourCycle: String? {
        let formatString = DateFormatter.dateFormat(fromTemplate: "J", options: 0, locale: self)
        switch formatString {
            case "h": return "h12" // 1-12
            case "H": return "h23" // 0-23
            case "K": return "h11" // 0-11
            case "k": return "h24" // 1-24
            default: return nil
        }
    }
    
    internal var wants24HourTime: Bool {
        if let cycle = bcp47HourCycle {
            return cycle == "h23" || cycle == "h24"
        }
        
        let hour = DateFormatter.dateFormat(fromTemplate: "J", options: 0, locale: self)
        return hour?.contains("H") == true || hour?.contains("k") == true
    }
    
}
