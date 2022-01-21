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
    
    private let clock = Clocks.system
    private lazy var month = clock.thisMonth()
    private lazy var daysSequence = month.days
    
    var monthTitle: String { month.description }
    var weekDayTitles: [String] { Region.current.calendar.veryShortWeekdaySymbols }
    var numberOfWeekDays: Int { weekDayTitles.count }
    
    @Published
    var days = [DayViewModel]()
    
    // MARK: Initializer
    
    init() {
        computeDaysInCurrentMonth()
    }
    
    // MARK: Private Methods
    
    private func computeDaysInCurrentMonth() {
        let todayNumber = clock.today().day
        
        var days = daysSequence
            .map(\.day)
            .map { DayViewModel(title: $0.description, isToday: $0 == todayNumber) }
        
        let leadingPaddingAmount = month.firstDay.dayOfWeek - 1
        days = (0 ..< leadingPaddingAmount).map { _ in DayViewModel(title: nil, isToday: false) } + days
        
        let trailingPaddingAmount = numberOfWeekDays - month.days.map(\.day).count % 7
        days += (0...trailingPaddingAmount).map { _ in DayViewModel(title: nil, isToday: false) }
        
        self.days = days
    }
}
