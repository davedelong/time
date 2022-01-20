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
    var weekDayTitles: [String] { Region.current.calendar.veryShortWeekdaySymbols }
    var numberOfWeekDays: Int { weekDayTitles.count }
    var days: [DayViewModel]
    
    // MARK: Initializer
    
    init() {
        let clock = Clocks.system
        let month = clock.thisMonth()
        let todayNumber = clock.today().day
        let daysSequence = month.days
        
        self.month = month
        self.daysSequence = daysSequence
        self.days = daysSequence
            .map(\.day)
            .map { DayViewModel(title: $0.description, isToday: $0 == todayNumber) }
    }
}
