import Foundation

extension CalendarProtocol {
    
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
    internal var isEraRelevant: Bool {
        eraRelevance.get(identifier, create: {
            (maximumRange(of: .era)?.upperBound ?? 0) > 2
        })
    }
    
    internal var lenientUnitsForFixedTimePeriods: Set<Calendar.Component> {
        if isEraRelevant { return [] }
        return [.era]
    }
    
    internal func exactDate(from components: DateComponents, in timeZone: TimeZone, matching: Set<Calendar.Component>) throws(TimeError) -> (Date, DateComponents) {
        var restrictedComponents = try components.requireAndRestrict(to: matching, lenient: self.lenientUnitsForFixedTimePeriods)
        restrictedComponents.timeZone = timeZone
        
        guard let proposedDate = self.date(from: restrictedComponents) else {
            let r = Region(anyCalendar: self, timeZone: timeZone, locale: self.locale ?? .current)
            throw TimeError.invalidDateComponents(restrictedComponents, in: r)
        }
        
        let proposedComponents = self.dateComponents(in: timeZone, from: proposedDate)
        
        if isEraRelevant == false && restrictedComponents.era == nil {
            restrictedComponents.era = proposedComponents.era
        }
        
        for unit in matching {
            // we'll skip validating nanoseconds, because the precision of the Double backing a Foundation.Date
            // is not enough to fully and completely represent all nanoseconds
            
            // however, basic experimentation shows that the drift from "requested" to "actual" nanoseconds
            // appears to be restricted to within about 24,000 nanoseconds
            if unit == .nanosecond { continue }
            
            guard proposedComponents.value(for: unit) == restrictedComponents.value(for: unit) else {
                let r = Region(anyCalendar: self, timeZone: self.timeZone, locale: self.locale ?? .current)
                throw TimeError.invalidDateComponents(restrictedComponents, in: r)
            }
        }
        
        let actualComponents = try! proposedComponents.requireAndRestrict(to: matching, lenient: [])
        
        return (proposedDate, actualComponents)
    }
    
    internal func range(containing date: Date, in units: Set<Calendar.Component>) -> Range<Date> {
        let smallest = Calendar.Component.smallest(from: units)
        return self.range(of: smallest, containing: date)
    }
    
    var isLikelyAutoupdating: Bool {
        (self as? Calendar == .autoupdatingCurrent)
    }
    
    var loggingDescription: String {
        if isEquivalent(to: Calendar.standard(identifier)) {
            return (try? identifier.encodingIdentifier) ?? "\(identifier)"
        }
        return self.debugDescription
    }
    
}

private let eraRelevance = SimpleCache<Calendar.Identifier, Bool>()

extension Calendar.Identifier {
    
    static let encodingNames: Bimap<Self, String> = {
        var map: Bimap<Self, String> = [
            .gregorian: "gregorian",
            .buddhist: "buddhist",
            .chinese: "chinese",
            .coptic: "coptic",
            .ethiopicAmeteMihret: "ethiopic",
            .ethiopicAmeteAlem: "ethiopic-amete-alem",
            .hebrew: "hebrew",
            .iso8601: "iso8601",
            .indian: "indian",
            .islamic: "islamic",
            .islamicCivil: "islamic-civil",
            .japanese: "japanese",
            .persian: "persian",
            .republicOfChina: "roc",
            .islamicTabular: "islamic-tbla",
            .islamicUmmAlQura: "islamic-umalqura",
        ]
        
        #if swift(>=6.2)
        if #available(macOS 26, iOS 26, tvOS 26, watchOS 26, *) {
            map[.bangla] = "bangla"
            map[.gujarati] = "gujarati"
            map[.kannada] = "kannada"
            map[.malayalam] = "malayalam"
            map[.marathi] = "marathi"
            map[.odia] = "odia"
            map[.tamil] = "tamil"
            map[.telugu] = "telugu"
            map[.vikram] = "vikram"
            map[.dangi] = "dangi"
            map[.vietnamese] = "vietnamese"
        }
        #endif
        return map
    }()
    
    var encodingIdentifier: String {
        get throws(TimeError) {
            guard let identifier = Self.encodingNames[self] else {
                let ctx = EncodingError.Context(codingPath: [], debugDescription: "Unknown calendar identifier: '\(self)'")
                throw TimeError.encodingError(EncodingError.invalidValue(self, ctx))
            }
            return identifier
        }
    }
    
    init(encodingIdentifier: String) throws(TimeError) {
        guard let id = Self.encodingNames[encodingIdentifier] else {
            let ctx = DecodingError.Context(codingPath: [], debugDescription: "Unknown calendar identifier: '\(encodingIdentifier)'")
            throw TimeError.decodingError(DecodingError.dataCorrupted(ctx))
        }
        
        self = id
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
