//
//  File.swift
//

import Foundation


/// Boundary-aligned sequences reset to a boundary while striding.
///
/// For example, a sequence that strides 15 minutes will naturally fall on the hour boundary while striding:
/// :00 → :15 → :30 → :45 → :00 → :15 → :30 → :45 → :00 → …
///
/// However, striding by a distance that is not a factor of the boundary length would present problems.
/// :00 → :13 → :26 → :39 → :52 → :05 → :18 → :31→ …
///
/// Humans typically expect that iterating by 13 minutes would likely reset to the boundary when it is crossed. This sequence does that.
/// :00 → :13 → :26 → :39 → :52 → :00 → :13 → :26 → …
internal struct BoundaryAlignedSequence<Smallest: Unit & LTOEEra>: Sequence {
    
    private let constructor: () -> BoundaryAlignedIterator<Smallest>
    
    init(start: Fixed<Smallest>, stride: TimeDifference<Smallest, Era>, boundaryStride: TimeDifference<Smallest, Era>) {
        
        constructor = {
            return BoundaryAlignedIterator(start: start,
                                         stride: stride,
                                         boundaryStride: boundaryStride)
        }
        
    }
    
    func makeIterator() -> BoundaryAlignedIterator<Smallest> {
        return constructor()
    }
    
}

internal struct BoundaryAlignedIterator<Smallest: Unit & LTOEEra>: IteratorProtocol {
    
    var scale = 0
    
    var currentBoundary: Range<Fixed<Smallest>>
    
    let stride: TimeDifference<Smallest, Era>
    let boundaryStride: TimeDifference<Smallest, Era>
    
    init(start: Fixed<Smallest>, stride: TimeDifference<Smallest, Era>, boundaryStride: TimeDifference<Smallest, Era>) {
        
        self.currentBoundary = start ..< start + boundaryStride
        self.stride = stride
        self.boundaryStride = boundaryStride
        
    }
    
    mutating func next() -> Fixed<Smallest>? {
        let offset = stride.scale(by: scale)
        let next = currentBoundary.lowerBound + offset
        
        if next < currentBoundary.upperBound {
            scale += 1
            return next
        } else {
            scale = 1 // the next time we loop, we want to add 1
            
            let next = currentBoundary.upperBound
            currentBoundary = next ..< next + boundaryStride
            
            return next
        }
    }
    
}
