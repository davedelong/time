//
//  TimeError.swift
//  
//
//  Created by Dave DeLong on 4/11/20.
//

import Foundation

public struct TimeError: Error, CustomStringConvertible {
    
    private let payload: Payload
    private let _description: String?
    
    private enum Payload {
        case missingUnits(Set<Calendar.Component>, Bool)
        case invalidComponents(DateComponents, Region)
        case cannotParseString(String, Region)
        case cannotDecodeTimePeriodStorage(absolute: Error, relative: Error)
    }
    
    public static func missingCalendarComponents(_ components: Set<Calendar.Component>, description: String? = nil) -> TimeError {
        return TimeError(payload: .missingUnits(components, false), _description: description)
    }
    
    public static func missingCalendarComponents(_ components: Set<Calendar.Component>, whileParsing: Bool, description: String? = nil) -> TimeError {
        return TimeError(payload: .missingUnits(components, whileParsing), _description: description)
    }
    
    public static func invalidDateComponents(_ components: DateComponents, in region: Region, description: String? = nil) -> TimeError {
        return TimeError(payload: .invalidComponents(components, region), _description: description)
    }
    
    public static func cannotParseString(_ string: String, in region: Region, description: String? = nil) -> TimeError {
        return TimeError(payload: .cannotParseString(string, region), _description: description)
    }
    
    internal static func cannotDecodeTimePeriod(_ absoluteError: Error, _ relativeError: Error) -> TimeError {
        return TimeError(payload: .cannotDecodeTimePeriodStorage(absolute: absoluteError, relative: relativeError), _description: nil)
    }
    
    public var description: String {
        if let d = _description { return d }
        
        switch payload {
            case .missingUnits(let units, let whileParsing):
                if whileParsing {
                    return "Some required components (\(units)) were missing while parsing"
                } else {
                    return "Some required components (\(units)) were missing"
                }
            case .invalidComponents(let dc, let region):
                return "The provided date components (\(dc)) cannot be correctly interpreted in the \(region) region"
            case .cannotParseString(let string, let region):
                return "Cannot parse string '\(string)' in the \(region) region"
            case .cannotDecodeTimePeriodStorage(absolute: let abs, relative: let rel):
                return "Cannot decode TimePeriod value from provided data. Attempts errored with: \(abs) and \(rel)"
        }
    }
    
    public var region: Region? {
        switch payload {
            case .missingUnits(_, _): return nil
            case .invalidComponents(_, let r): return r
            case .cannotParseString(_, let r): return r
            case .cannotDecodeTimePeriodStorage(absolute: _, relative: _): return nil
        }
    }
    
    public var dateComponents: DateComponents? {
        switch payload {
            case .missingUnits(_, _): return nil
            case .invalidComponents(let c, _): return c
            case .cannotParseString(_, _): return nil
            case .cannotDecodeTimePeriodStorage(absolute: _, relative: _): return nil
        }
    }
    
    public var inputString: String? {
        switch payload {
            case .missingUnits(_, _): return nil
            case .invalidComponents(_, _): return nil
            case .cannotParseString(let s, _): return s
            case .cannotDecodeTimePeriodStorage(absolute: _, relative: _): return nil
        }
    }
    
    public var isParseError: Bool {
        switch payload {
            case .missingUnits(_, let parsing): return parsing
            case .invalidComponents(_, _): return false
            case .cannotParseString(_, _): return true
            case .cannotDecodeTimePeriodStorage(absolute: _, relative: _): return true
        }
    }
    
    public var missingCalendarComponents: Set<Calendar.Component> {
        switch payload {
            case .missingUnits(let c, _): return c
            case .invalidComponents(_, _): return []
            case .cannotParseString(_, _): return []
            case .cannotDecodeTimePeriodStorage(absolute: _, relative: _): return []
        }
    }
    
}
