import Foundation

extension Locale {
    private static let cache = SimpleCache<String, Locale>()
    
    static func standard(_ id: String) -> Locale {
        return cache.get(id, create: { Locale(identifier: id) })
    }
}

extension Calendar {
    private static let cache = SimpleCache<Calendar.Identifier, Calendar>()
    
    static func standard(_ id: Calendar.Identifier) -> Calendar {
        return cache.get(id, create: { Calendar(identifier: id) })
    }
}

extension TimeZone {
    private static let cache = SimpleCache<String, TimeZone>()
    
    static func standard(_ id: String) -> TimeZone {
        return cache.get(id, create: { TimeZone(identifier: id)! })
    }
}

private class SimpleCache<Key: Hashable, T> {
    
    private var storage = Dictionary<Key, T>()
    private let lock = NSLock()
    
    init() { }
    
    func get(_ id: Key, create: () -> T) -> T {
        lock.lock()
        
        let returnValue: T
        if let existing = storage[id] {
            returnValue = existing
        } else {
            returnValue = create()
            storage[id] = returnValue
        }
        
        lock.unlock()
        return returnValue
    }
}
