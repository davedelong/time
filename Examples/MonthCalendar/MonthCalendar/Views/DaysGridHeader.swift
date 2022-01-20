//
//  DaysGridHeader.swift
//  MonthCalendar
//
//  Created by Tiago Lopes on 19/01/22.
//

import SwiftUI
import Time

// MARK: - View

struct DaysGridHeader: View {
    
    // MARK: Properties
    
    let titles: [String]
    
    // MARK: Body
    
    var body: some View {
        let enumeratedTitles = titles
            .enumerated()
            .map { (index: $0.0, title: $0.1) }
        
        HStack(alignment: .center, spacing: 0) {
            ForEach(enumeratedTitles, id: \.index) {
                DayGridCell(title: $0.title)
            }
        }
    }
}

// MARK: - Preview

struct DaysGridHeader_Previews: PreviewProvider {
    static var previews: some View {
        DaysGridHeader(titles: Region.current.calendar.veryShortWeekdaySymbols)
    }
}
