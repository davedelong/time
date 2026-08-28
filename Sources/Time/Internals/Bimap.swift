//
//  Bimap.swift
//  Time
//
//  Created by Dave DeLong on 8/28/26.
//

internal struct Bimap<Left: Hashable, Right: Hashable> {
    
    private var leftToRight = Dictionary<Left, Right>()
    private var rightToLeft = Dictionary<Right, Left>()
    
    internal init() { }
    
    internal subscript(key: Left) -> Right? {
        get {
            return leftToRight[key]
        }
        set {
            if let newB = newValue {
                let oldB = leftToRight.removeValue(forKey: key)
                leftToRight[key] = newB
                
                if let oldB { rightToLeft.removeValue(forKey: oldB) }
                rightToLeft[newB] = key
            } else {
                if let oldB = leftToRight.removeValue(forKey: key) {
                    rightToLeft.removeValue(forKey: oldB)
                }
            }
        }
    }
    
    internal subscript(key: Right) -> Left? {
        get {
            return rightToLeft[key]
        }
        set {
            if let newA = newValue {
                let oldA = rightToLeft.removeValue(forKey: key)
                rightToLeft[key] = newA
                
                if let oldA { leftToRight.removeValue(forKey: oldA) }
                leftToRight[newA] = key
            } else {
                if let oldA = rightToLeft.removeValue(forKey: key) {
                    leftToRight.removeValue(forKey: oldA)
                }
            }
        }
    }
}

extension Bimap: Sendable where Left: Sendable, Right: Sendable { }

extension Bimap: ExpressibleByDictionaryLiteral {
    
    internal init(dictionaryLiteral elements: (Left, Right)...) {
        self.init()
        for (l, r) in elements {
            self[l] = r
        }
    }
    
}
