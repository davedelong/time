//
//  File.swift
//  
//
//  Created by Dave DeLong on 1/31/24.
//

import Foundation

extension Locale {
    
    private static let currentSnapshot: Snapshot<Locale> = Snapshot(notification: NSLocale.currentLocaleDidChangeNotification, createSnapshot: {
        let auto = Locale.autoupdatingCurrent
        
        let standard = Locale.standard(auto.identifier)
        if auto.isEquivalent(to: standard) { return standard }
        
        var components = Locale.Components()
        
        components.calendar = auto.calendar.identifier
        components.collation = auto.collation
        components.currency = auto.currency
        components.firstDayOfWeek = auto.firstDayOfWeek
        components.hourCycle = auto.hourCycle
        components.languageComponents = .init(languageCode: auto.language.languageCode,
                                              script: auto.language.script,
                                              region: auto.language.region)
        components.measurementSystem = auto.measurementSystem
        components.numberingSystem = auto.numberingSystem
        components.region = auto.region
        components.subdivision = auto.subdivision
        components.timeZone = auto.timeZone
        components.variant = auto.variant
        
        return Locale(components: components)
    })
    
    func snapshot() -> Self {
        if self != .autoupdatingCurrent { return self }
        return Self.currentSnapshot.snapshot
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
        if auto.isEquivalent(to: standard) { return standard }
        
        var snapshot = Calendar(identifier: auto.identifier)
        
        // don't bother snapshotting the timezone and locale,
        // because the values in the region itself take precedence
        
        snapshot.firstWeekday = auto.firstWeekday
        snapshot.minimumDaysInFirstWeek = auto.minimumDaysInFirstWeek
        
        // TODO: copy over the various symbols?
        
        return snapshot
    })
    
    func snapshot() -> Self {
        if self != .autoupdatingCurrent { return self }
        return Self.currentSnapshot.snapshot
    }
    
}

private class Snapshot<T> {
    
    private let createSnapshot: () -> T
    
    private var _snapshot: T?
    private var observationToken: NSObjectProtocol?
    
    #warning("TODO: better synchronization primitive?")
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
