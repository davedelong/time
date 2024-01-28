//
//  File.swift
//  
//
//  Created by Dave DeLong on 1/20/24.
//

import Foundation

extension Fixed where Smallest: LTOEDay {
    
    public func format(date dateStyle: DateFormatter.Style) -> String {
        let style = AbsoluteFormatStyle<Smallest>(dateStyle: dateStyle, timeStyle: .none)
        return self.format(using: style)
    }
    
}

/*
 Technically using a time style requires second-level precision. However, it seems
 reasonable to assume that formatting a minute with a time should use `:00` as the seconds.
 
 Formatting happens using the `dateForFormatting()`, which picks the first instant of the represented range.
 */
extension Fixed where Smallest: LTOEMinute {
    
    public func format(date dateStyle: DateFormatter.Style, time timeStyle: DateFormatter.Style) -> String {
        let style = AbsoluteFormatStyle<Smallest>(dateStyle: dateStyle, timeStyle: timeStyle)
        return self.format(using: style)
    }
    
    public func format(time timeStyle: DateFormatter.Style) -> String {
        let style = AbsoluteFormatStyle<Smallest>(dateStyle: .none, timeStyle: timeStyle)
        return self.format(using: style)
    }
    
}
