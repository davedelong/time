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
    private var daysSequence: AbsoluteTimePeriodSequence<Day>
    
    var monthTitle: String { month.description }
    var weekDaysTitles: [String] { Region.current.calendar.veryShortWeekdaySymbols }
    var numberOfWeekDays: Int { weekDaysTitles.count }
    var days: [String]
    
    // MARK: Initializer
    
    init() {
        let month = Clocks.system.thisMonth()
        let daysSequence = month.days
        self.month = month
        self.daysSequence = daysSequence
        self.days = daysSequence
            .map(\.day)
            .map(\.description)
    }
}
