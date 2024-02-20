import Foundation

extension Locale {
    
    private static let currentSnapshot: Snapshot<Locale> = Snapshot(notification: NSLocale.currentLocaleDidChangeNotification, createSnapshot: {
        let auto = Locale.autoupdatingCurrent
        
        let standard = Locale.standard(auto.identifier)
        
        #if os(Linux)
        return standard
        #else
        if auto.isEquivalent(to: standard) { return standard }
        var components = Locale.Components()
        
        components.calendar = auto.calendar.identifier
        components.firstDayOfWeek = auto.firstDayOfWeek
        components.hourCycle = auto.hourCycle
        components.languageComponents = .init(languageCode: auto.language.languageCode,
                                              script: auto.language.script,
                                              region: auto.language.region)
        components.measurementSystem = auto.measurementSystem
        components.numberingSystem = auto.numberingSystem
        components.timeZone = auto.timeZone
        components.variant = auto.variant
        
        return Locale(components: components)
        #endif
    })
    
    func snapshot() -> Self {
        if self != .autoupdatingCurrent { return self }
        return Self.currentSnapshot.snapshot
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

extension TimeZone {
    
    private static let currentSnapshot: Snapshot<TimeZone> = Snapshot(notification: .NSSystemTimeZoneDidChange, createSnapshot: {
        return TimeZone.standard(TimeZone.autoupdatingCurrent.identifier)
    })
    
    func snapshot() -> Self {
        if self != .autoupdatingCurrent { return self }
        return Self.currentSnapshot.snapshot
    }
    
}

extension Calendar {
    
    private static let currentSnapshot: Snapshot<Calendar> = Snapshot(notification: NSLocale.currentLocaleDidChangeNotification, createSnapshot: {
        let auto = Calendar.autoupdatingCurrent
        
        let standard = Calendar.standard(auto.identifier)
        if auto.isEquivalent(to: standard) {
            return standard
        }
        
        var snapshot = Calendar(identifier: auto.identifier)
        
        // don't bother snapshotting the time zone and locale,
        // because the values in the region itself take precedence
        
        snapshot.firstWeekday = auto.firstWeekday
        snapshot.minimumDaysInFirstWeek = auto.minimumDaysInFirstWeek
        
        return snapshot
    })
    
    func snapshot() -> Self {
        if self != .autoupdatingCurrent { return self }
        return Self.currentSnapshot.snapshot
    }
    
}

private class Snapshot<T>: @unchecked Sendable {
    
    private let createSnapshot: () -> T
    
    private var _snapshot: T?
    private var observationToken: NSObjectProtocol?
    private let lock = NSLock()
    
    var snapshot: T {
        lock.lock()
        let returnValue: T
        if let _snapshot {
            returnValue = _snapshot
        } else {
            returnValue = createSnapshot()
            _snapshot = returnValue
        }
        lock.unlock()
        return returnValue
    }
    
    init(notification: Notification.Name, createSnapshot: @escaping () -> T) {
        self.createSnapshot = createSnapshot
        self.observationToken = NotificationCenter.default
            .addObserver(forName: notification, object: nil, queue: .main, using: { [unowned self] _ in
                self.resetSnapshot()
            })
    }
    
    deinit {
        if let observationToken {
            NotificationCenter.default.removeObserver(observationToken)
        }
    }
    
    private func resetSnapshot() {
        lock.lock()
        _snapshot = nil
        lock.unlock()
    }
    
}
