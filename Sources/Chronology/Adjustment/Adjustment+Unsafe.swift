//
//  File.swift
//  
//
//  Created by Dave DeLong on 11/9/19.
//

import Foundation

extension Value where Smallest: LTOEYear, Largest: GTOEEra {
    
    func setting(year: Int) throws -> Self {
        throw AdjustmentError()
    }
    
}

extension Value where Smallest: LTOEMonth, Largest: GTOEEra {
    
    func setting(year: Int, month: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(month: Int) throws -> Self {
        throw AdjustmentError()
    }
    
}

extension Value where Smallest: LTOEDay, Largest: GTOEEra {
    
    func setting(year: Int, month: Int, day: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(month: Int, day: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(day: Int) throws -> Self {
        throw AdjustmentError()
    }
    
}

extension Value where Smallest: LTOEHour, Largest: GTOEEra {
    
    func setting(year: Int, month: Int, day: Int, hour: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(month: Int, day: Int, hour: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(day: Int, hour: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(hour: Int) throws -> Self {
        throw AdjustmentError()
    }
    
}

extension Value where Smallest: LTOEMinute, Largest: GTOEEra {
    
    func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(day: Int, hour: Int, minute: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(hour: Int, minute: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(minute: Int) throws -> Self {
        throw AdjustmentError()
    }
    
}

extension Value where Smallest: LTOESecond, Largest: GTOEEra {
    
    func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(day: Int, hour: Int, minute: Int, second: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(hour: Int, minute: Int, second: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(minute: Int, second: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(second: Int) throws -> Self {
        throw AdjustmentError()
    }
    
}

extension Value where Smallest: LTOENanosecond, Largest: GTOEEra {
    
    func setting(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(hour: Int, minute: Int, second: Int, nanosecond: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(minute: Int, second: Int, nanosecond: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(second: Int, nanosecond: Int) throws -> Self {
        throw AdjustmentError()
    }
    
    func setting(nanosecond: Int) throws -> Self {
        throw AdjustmentError()
    }
    
}
