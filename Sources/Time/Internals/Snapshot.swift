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
    
    func snapshot(forcedCopy: Bool) -> Self {
        if forcedCopy == false && self != .autoupdatingCurrent { return self }
        return Self.currentSnapshot.snapshot(forcedCopy: forcedCopy)
    }
}

extension TimeZone {
    
    private static let currentSnapshot: Snapshot<TimeZone> = Snapshot(notification: .NSSystemTimeZoneDidChange, createSnapshot: {
        return TimeZone.standard(TimeZone.autoupdatingCurrent.identifier)
    })
    
    func snapshot(forcedCopy: Bool) -> Self {
        if forcedCopy == false && self != .autoupdatingCurrent { return self }
        return Self.currentSnapshot.snapshot(forcedCopy: forcedCopy)
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
    
    func snapshot(forcedCopy: Bool) -> Self {
        if forcedCopy == false && self != .autoupdatingCurrent { return self }
        return Self.currentSnapshot.snapshot(forcedCopy: forcedCopy)
    }
    
}

private class Snapshot<T>: @unchecked Sendable {
    
    private let createSnapshot: () -> T
    
    private var _snapshot: T?
    private var observationToken: NSObjectProtocol?
    private let lock = NSLock()
    
    func snapshot(forcedCopy: Bool) -> T {
        if forcedCopy { return createSnapshot() }
        
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
