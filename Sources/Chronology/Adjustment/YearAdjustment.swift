//
//  YearAdjustment.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public extension FieldAdjustment where F: YearField {
    public static func years(_ value: Int) -> FieldAdjustment { return self.init(value: value) }
}

public func +<C: CalendarValue & Anchored & YearField>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    let a = Adjustment<C, C>.add(years: rhs.value)
    return a.adjust(lhs)
}

public func -<C: CalendarValue & Anchored & YearField>(lhs: C, rhs: FieldAdjustment<C>) -> C {
    let a = Adjustment<C, C>.add(years: -rhs.value)
    return a.adjust(lhs)
}

public extension Adjustment where I: Anchored & YearField, I == O {
    
    public static func add(years: Int) -> Adjustment<I, O> {
        return Adjustment {
            let d = $0.range.lowerBound.date
            let newDate = $0.calendar.date(byAdding: .year, value: years, to: d).unwrap("Unabled to add \(years) years to \($0)")
            return O.init(date: newDate, region: $0.region)
        }
    }
    
}

public extension CalendarValue where Self: Anchored, Self: YearField {
    
    public func nextYear() -> Self {
        return self + .years(1)
    }
    
    public func lastYear() -> Self {
        return self - .years(1)
    }
    
}
