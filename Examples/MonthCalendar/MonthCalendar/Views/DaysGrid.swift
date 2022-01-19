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
    
    let days: [String]
    let numberOfWeekDays: Int
    let availableWidth: Double
    
    // MARK: Body
    
    var body: some View {
        LazyVGrid(columns: gridItem, spacing: Constants.spacing) {
            ForEach(days, id: \.self) { title in
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                    // TODO: Fix the interitem internal borders.
                        .border(.black, width: 1)
                    Text(title)
                }
                .aspectRatio(1, contentMode: .fit)
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
