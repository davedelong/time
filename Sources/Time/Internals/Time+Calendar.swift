import Foundation

extension Calendar {
    
    /// Different calendars may have different definitions of what a "second" is.
    /// For example, on Earth, calendars all have the convention that one calendar-second
    /// is the same as one SI Second. However, on Mars, the days are slightly longer,
    /// which means that dividing the slightly-longer day in to 86,400 slices results
    /// in "seconds" that are slightly longer than Earth seconds.
    /// Therefore, to accommodate this, the calendar needs to define how many
    /// SI Seconds are in each calendar-second.
    /// note: This does NOT affect how physics calculations are done (or velocities, etc)
    /// because those are all defined relative to SI Seconds.
    internal var SISecondsPerSecond: Double { return 1.0 }
    
    /// For most calendars, the Era is not very relevant. For example "2019" is unambiguously
    /// understood to be "2019 CE", not "2019 BCE". However, there are some calendars
    /// (most notably the Japanese calendar) for which the era is extremely relevant.
    /// The relevancy of the era is taken into account when doing default formatting
    /// of calendar Values.
    internal var isEraRelevant: Bool { return (maximumRange(of: .era)?.upperBound ?? 0) > 2 }
    
    internal var lenientUnitsForFixedTimePeriods: Set<Calendar.Component> {
        if isEraRelevant { return [] }
        return [.era]
    }
    
    internal func exactDate(from components: DateComponents, in timeZone: TimeZone, matching: Set<Calendar.Component>) throws -> Date {
        var restricted = try components.requireAndRestrict(to: matching, lenient: self.lenientUnitsForFixedTimePeriods)
        restricted.timeZone = timeZone
        
        guard let proposed = self.date(from: restricted) else {
            let r = Region(calendar: self, timeZone: self.timeZone, locale: self.locale ?? .current)
            throw TimeError.invalidDateComponents(restricted, in: r)
        }
        
        let proposedComponents = self.dateComponents(in: timeZone, from: proposed)
        
        if isEraRelevant == false && restricted.era == nil {
            restricted.era = proposedComponents.era
        }
        
        for unit in matching {
            // we'll skip validating nanoseconds, because the precision of the Double backing a Foundation.Date
            // is not enough to fully and completely represent all nanoseconds
            
            // however, basic experimentation shows that the drift from "requested" to "actual" nanoseconds
            // appears to be restricted to within about 24,000 nanoseconds
            if unit == .nanosecond { continue }
            
            guard proposedComponents.value(for: unit) == restricted.value(for: unit) else {
                let r = Region(calendar: self, timeZone: self.timeZone, locale: self.locale ?? .current)
                throw TimeError.invalidDateComponents(restricted, in: r)
            }
        }
        
        return proposed
    }
    
    internal func range(of unit: Calendar.Component, containing date: Date) -> Range<Date> {
        var start = Date()
        var length: TimeInterval = 0
        let succeeded = self.dateInterval(of: unit, start: &start, interval: &length, for: date)
        require(succeeded, "We should always be able to get the range of a calendar component")
        
        return start ..< start.addingTimeInterval(length)
    }
    
    internal func range(containing date: Date, in units: Set<Calendar.Component>) -> Range<Date> {
        let smallest = Calendar.Component.smallest(from: units)
        return self.range(of: smallest, containing: date)
    }
    
    func isEquivalent(to other: Calendar) -> Bool {
        guard identifier == other.identifier else { return false }
        guard timeZone.isEquivalent(to: other.timeZone) else { return false }
        guard firstWeekday == other.firstWeekday else { return false }
        guard minimumDaysInFirstWeek == other.minimumDaysInFirstWeek else { return false }
        
        return true
    }
    
    var isLikelyAutoupdating: Bool { self == .autoupdatingCurrent }
    
    var loggingDescription: String {
        if isEquivalent(to: Calendar.standard(identifier)) {
            return (try? identifier.encodingIdentifier) ?? "\(identifier)"
        }
        return self.debugDescription
    }
    
}

extension Calendar.Identifier {
    
    var encodingIdentifier: String {
        get throws {
            switch self {
                case .gregorian: return "gregorian"
                case .buddhist: return "buddhist"
                case .chinese: return "chinese"
                case .coptic: return "coptic"
                case .ethiopicAmeteMihret: return "ethiopic"
                case .ethiopicAmeteAlem: return "ethiopic-amete-alem"
                case .hebrew: return "hebrew"
                case .iso8601: return "iso8601"
                case .indian: return "indian"
                case .islamic: return "islamic"
                case .islamicCivil: return "islamic-civil"
                case .japanese: return "japanese"
                case .persian: return "persian"
                case .republicOfChina: return "roc"
                case .islamicTabular: return "islamic-tbla"
                case .islamicUmmAlQura: return "islamic-umalqura"
                default:
                    let ctx = EncodingError.Context(codingPath: [], debugDescription: "Unknown calendar identifier: '\(self)'")
                    throw TimeError.encodingError(EncodingError.invalidValue(self, ctx))
            }
        }
    }
    
    init(encodingIdentifier: String) throws {
        switch encodingIdentifier {
            case "gregorian": self = .gregorian
            case "buddhist": self = .buddhist
            case "chinese": self = .chinese
            case "coptic": self = .coptic
            case "ethiopic": self = .ethiopicAmeteMihret
            case "ethiopic-amete-alem": self = .ethiopicAmeteAlem
            case "hebrew": self = .hebrew
            case "iso8601": self = .iso8601
            case "indian": self = .indian
            case "islamic": self = .islamic
            case "islamic-civil": self = .islamicCivil
            case "japanese": self = .japanese
            case "persian": self = .persian
            case "roc": self = .republicOfChina
            case "islamic-tbla": self = .islamicTabular
            case "islamic-umalqura": self = .islamicUmmAlQura
            default:
                let ctx = DecodingError.Context(codingPath: [], debugDescription: "Unknown calendar identifier: '\(encodingIdentifier)'")
                throw TimeError.decodingError(DecodingError.dataCorrupted(ctx))
        }
    }
    
}

#if !os(Linux)
extension Locale.Weekday {
    
    internal init(dayOfWeek: Int) {
        switch dayOfWeek {
            case 1: self = .sunday
            case 2: self = .monday
            case 3: self = .tuesday
            case 4: self = .wednesday
            case 5: self = .thursday
            case 6: self = .friday
            case 7: self = .saturday
            default: fatalError("Invalid dayOfWeek: \(dayOfWeek)")
        }
    }
    
    internal var dayOfWeek: Int {
        switch self {
            case .sunday: return 1
            case .monday: return 2
            case .tuesday: return 3
            case .wednesday: return 4
            case .thursday: return 5
            case .friday: return 6
            case .saturday: return 7
            @unknown default:
                print("Unknown weekday \(self); assuming Sunday")
                return 1
        }
    }
    
}
#endif
