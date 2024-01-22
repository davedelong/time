//
//  Relations.swift
//  
//
//  Created by Dave DeLong on 3/7/20.
//

import Foundation

// https://en.wikipedia.org/wiki/Allen%27s_interval_algebra

/// The relationship between two calendar values
///
/// There are 13 possible ways in which two values may be related to each other.
/// This set of possibilities is entirely encapsulated by the `Relation` enum.
///
/// - See Also: [Allen's Interval Algebra](https://en.wikipedia.org/wiki/Allen%27s_interval_algebra)
public enum Relation: Hashable, CaseIterable {
    
    internal static let meetings: Set<Relation> = [.meets, .isMetBy, .starts, .isStartedBy, .finishes, .isFinishedBy]
    internal static let overlappings: Set<Relation> = [.overlaps, .isOverlappedBy, .during, .contains]
    
    /// The first range occurs entirely before the second range
    ///
    /// - Example: Range `A` is before range `B`:
    /// ````
    /// ●--A--○
    ///          ●--B--○
    /// ````
    case before
    
    /// The first range occurs entirely after the second rage
    ///
    /// - Example: Range `A` is after range `B`:
    /// ````
    /// ●--B--○
    ///          ●--A--○
    /// ````
    case after
    
    /// The first range ends where the second range starts
    ///
    /// - Example: Range `A` meets range `B`:
    /// ````
    /// ●--A--○
    ///       ●--B--○
    /// ````
    case meets
    
    /// The first range starts where the second range ends
    ///
    /// - Example: Range `A` is met by range `B`:
    /// ````
    /// ●--B--○
    ///       ●--A--○
    /// ````
    case isMetBy
    
    /// The first range starts before the second range starts, and ends before the second range ends
    ///
    /// - Example: Range `A` overlaps range `B`:
    /// ````
    /// ●--A--○
    ///     ●--B--○
    /// ````
    case overlaps
    
    /// The first range starts after the second range starts, and ends after the second range ends
    ///
    /// - Example: Range `A` is overlapped by range `B`:
    /// ````
    /// ●--B--○
    ///     ●--A--○
    /// ````
    case isOverlappedBy
    
    /// The first range starts where the second range starts, and ends before the second range ends
    ///
    /// - Example: Range `A` starts range `B`:
    /// ````
    /// ●--A--○
    /// ●----B----○
    /// ````
    case starts
    
    /// The first range starts where the second range starts, and ends after the second range ends
    ///
    /// - Example: Range `A` is started by range `B`:
    /// ````
    /// ●--B--○
    /// ●----A----○
    /// ````
    case isStartedBy
    
    /// The first range starts after the second range starts, and ends before the second range ends
    ///
    /// - Example: Range `A` is during range `B`:
    /// ````
    ///   ●--A--○
    /// ●----B----○
    /// ````
    case during
    
    /// The first range starts before the second range starts, and ends after the second range ends
    ///
    /// - Example: Range `A` contains range `B`:
    /// ````
    ///   ●--B--○
    /// ●----A----○
    /// ````
    case contains
    
    /// The first range starts after the second range starts, and ends with the second range
    ///
    /// - Example: Range `A` finishes range `B`:
    /// ````
    ///     ●--A--○
    /// ●----B----○
    /// ````
    case finishes
    
    /// The first range starts before the second range starts, and ends with the second range
    ///
    /// - Example: Range `A` is finished by range `B`:
    /// ````
    ///     ●--B--○
    /// ●----A----○
    /// ````
    case isFinishedBy
    
    /// The first and second ranges start and end together
    ///
    /// - Example: Range `A` equals range `B`:
    /// ````
    /// ●----A----○
    /// ●----B----○
    /// ````
    case equal
    
    /// Returns `true` if the relation describes two ranges that meet at any extreme
    public var isMeeting: Bool { Relation.meetings.contains(self) }
    
    /// Returns `true` if the relation describes any kind of overlapping
    public var isOverlapping: Bool { Relation.overlappings.contains(self) }
    
    /// Returns `true` if the relation describes disjointedness
    public var isDisjoint: Bool { self == .before || self == .after }
    
    /// Returns `true` if the relation describes equality
    public var isEqual: Bool { self == .equal }
    
}
