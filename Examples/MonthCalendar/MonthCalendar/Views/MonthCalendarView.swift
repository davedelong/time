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

                LazyVGrid(columns: gridItem(for: proxy), spacing: 0) {
                    ForEach(viewModel.dayTitles, id: \.self) { title in
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .border(.black, width: 1)
                            Text(title)
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    private func gridItem(for proxy: GeometryProxy) -> [GridItem] {
        var gridItem = GridItem(.adaptive(minimum: 44, maximum: proxy.size.width / 7))
        gridItem.spacing = 0
        return [gridItem]
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MonthCalendarView()
    }
}
