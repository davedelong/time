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
                Text("Time")
                
                Spacer()
                
                Text(viewModel.monthTitle)
                
                VStack(spacing: 0) {
                    weekDays
                    calendarDays(using: proxy)
                }
                
                Spacer()
            }
        }
    }
    
    private func calendarDays(using proxy: GeometryProxy) -> some View {
        LazyVGrid(columns: gridItem(for: proxy), spacing: Constants.gridItemSpacing) {
            ForEach(viewModel.days, id: \.self) { title in
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
    
    private var weekDays: some View {
        let enumeratedTitles = viewModel
            .weekDaysTitles
            .enumerated()
            .map { (index: $0.0, title: $0.1) }
        
        return HStack(alignment: .center, spacing: 0) {
            ForEach(enumeratedTitles, id: \.index) { weekDay in
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                    Text(weekDay.title)
                }
                .aspectRatio(1, contentMode: .fit)
            }
        }
    }
    
    private func gridItem(for proxy: GeometryProxy) -> [GridItem] {
        var gridItem = GridItem(.adaptive(
            minimum: proxy.size.width / Double(viewModel.numberOfWeekDays),
            maximum: proxy.size.width / Double(viewModel.numberOfWeekDays)
        ))
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
