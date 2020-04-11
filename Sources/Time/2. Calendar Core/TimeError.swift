//
//  TimeError.swift
//  
//
//  Created by Dave DeLong on 4/11/20.
//

import Foundation

public struct TimeError: Error {
    
    private let payload: Payload
    
    private enum Payload {
        case missingUnit(Calendar.Component, Bool)
        case invalidComponents(DateComponents, Region)
        case invalidString(String, Region)
    }
    
    public static func missingCalendarComponent(_ component: Calendar.Component) -> TimeError {
        return TimeError(payload: .missingUnit(component, false))
    }
    
    public static func invalidDateComponents(_ components: DateComponents, in region: Region) -> TimeError {
        return TimeError(payload: .invalidComponents(components, region))
    }
    
    public static func cannotParseString(_ string: String, in region: Region) -> TimeError {
        return TimeError(payload: .invalidString(string, region))
    }
    
    public var region: Region? {
        switch payload {
            case .missingUnit(_, _): return nil
            case .invalidComponents(_, let r): return r
            case .invalidString(_, let r): return r
        }
    }
    
    public var dateComponents: DateComponents? {
        switch payload {
            case .missingUnit(_, _): return nil
            case .invalidComponents(let c, _): return c
            case .invalidString(_, _): return nil
        }
    }
    
    public var inputString: String? {
        switch payload {
            case .missingUnit(_, _): return nil
            case .invalidComponents(_, _): return nil
            case .invalidString(let s, _): return s
        }
    }
    
    public var isParseError: Bool {
        switch payload {
            case .missingUnit(_, let parsing): return parsing
            case .invalidComponents(_, _): return false
            case .invalidString(_, _): return true
        }
    }
    
    public var missingCalendarComponent: Calendar.Component? {
        switch payload {
            case .missingUnit(let c, _): return c
            case .invalidComponents(_, _): return nil
            case .invalidString(_, _): return nil
        }
    }
    
}
