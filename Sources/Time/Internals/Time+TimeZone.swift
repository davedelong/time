import Foundation

extension TimeZone {
    
    func isEquivalent(to other: TimeZone) -> Bool {
        guard identifier == other.identifier else { return false }
        
        return true
    }
    
    var isLikelyAutoupdating: Bool { self == .autoupdatingCurrent }
    
}
