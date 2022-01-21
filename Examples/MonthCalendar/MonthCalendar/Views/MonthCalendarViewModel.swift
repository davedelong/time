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
        let month = clock.thisMonth().nextMonth.nextMonth.nextMonth
        let todayNumber = clock.today().day
        let daysSequence = month.days
        let numberOfWeekDays = Region.current.calendar.veryShortWeekdaySymbols.count
        
        self.month = month
        self.daysSequence = daysSequence
        
        var days = daysSequence
            .map(\.day)
            .map { DayViewModel(title: $0.description, isToday: $0 == todayNumber) }
        
        let leadingPaddingAmount = month.firstDay.dayOfWeek - 1
        days = (0 ..< leadingPaddingAmount).map { _ in DayViewModel(title: nil, isToday: false) } + days
        
        let trailingPaddingAmount = numberOfWeekDays - month.days.map(\.day).count % 7 - 1
        if trailingPaddingAmount > 0 {
            days += (0...trailingPaddingAmount).map { _ in DayViewModel(title: nil, isToday: false) }
        }
        
        self.days = days
    }
}
