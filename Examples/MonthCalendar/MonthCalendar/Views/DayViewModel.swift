//
//  DayViewModel.swift
//  MonthCalendar
//
//  Created by Tiago Lopes on 20/01/22.
//

import Foundation
import Time

struct DayViewModel {
    
    // MARK: Properties

    private let id = UUID().uuidString
    let title: String?
    let isToday: Bool
}

extension DayViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
