//
//  MonthCalendarViewModel.swift
//  MonthCalendar
//
//  Created by Tiago Lopes on 05/01/22.
//

import Combine
import Foundation
import Time

final class MonthCalendarViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published
    private var month: Absolute<Month>
    
    @Published
    private var days: AbsoluteTimePeriodSequence<Day>
    
    var monthTitle: String { month.description }
    var dayTitles: [String]
    
    // MARK: Initializer
    
    init() {
        let month = Clocks.system.thisMonth()
        let days = month.days
        self.month = month
        self.days = days
        self.dayTitles = days
            .map(\.day)
            .map(\.description)
    }
}
