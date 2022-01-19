//
//  MonthCalendarView.swift
//  MonthCalendar
//
//  Created by Tiago Lopes on 05/01/22.
//

import SwiftUI

// MARK: - View

struct MonthCalendarView: View {
    
    // MARK: Properties
    
    @StateObject
    var viewModel = MonthCalendarViewModel()
    
    // MARK: Body
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                
                Text(viewModel.monthTitle)

                LazyVGrid(columns: gridItem(for: proxy), spacing: Constants.gridItemSpacing) {
                    ForEach(viewModel.days, id: \.self) { title in
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                            // TODO: Fix the interitem borders.
                                .border(.black, width: 1)
                            Text(title)
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func gridItem(for proxy: GeometryProxy) -> [GridItem] {
        var gridItem = GridItem(.adaptive(
            minimum: Constants.minGridItemWidth,
            maximum: proxy.size.width / Double(viewModel.numberOfWeekDays))
        )
        gridItem.spacing = Constants.gridItemSpacing
        return [gridItem]
    }
}

// MARK: - Constants

fileprivate enum Constants {
    static let minGridItemWidth = 44.0
    static let gridItemSpacing = 0.0
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MonthCalendarView()
    }
}
