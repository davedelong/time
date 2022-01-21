//
//  DaysGrid.swift
//  MonthCalendar
//
//  Created by Tiago Lopes on 19/01/22.
//

import SwiftUI

// MARK: - View

struct DaysGrid: View {
    
    // MARK: Properties
    
    let days: [DayViewModel]
    let numberOfWeekDays: Int
    let availableWidth: Double
    
    // MARK: Body
    
    var body: some View {
        LazyVGrid(columns: gridItem, spacing: Constants.spacing) {
            ForEach(days, id: \.self) { day in
                if let title = day.title {
                    DayGridCell(title: title)
                        .border(.black, width: 1)
                } else {
                    Text("-")
                }
            }
        }
    }
    
    private var gridItem: [GridItem] {
        var gridItem = GridItem(.adaptive(
            minimum: availableWidth / Double(numberOfWeekDays)
        ))
        gridItem.spacing = Constants.spacing
        return [gridItem]
    }
}

// MARK: - Constants

fileprivate enum Constants {
    static let spacing = 0.0
}

// MARK: - Preview

struct DaysGrid_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MonthCalendarViewModel()
        DaysGrid(days: viewModel.days, numberOfWeekDays: viewModel.numberOfWeekDays, availableWidth: 350)
    }
}
