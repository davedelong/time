//
//  DayGridCell.swift
//  MonthCalendar
//
//  Created by Tiago Lopes on 20/01/22.
//

import SwiftUI

// MARK: - View

struct DayGridCell: View {
    
    // MARK: Properties
    
    let title: String?
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
            if let title = title {
                Text(title)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

// MARK: - Preview

struct DayGridCell_Previews: PreviewProvider {
    static var previews: some View {
        DayGridCell(title: "12")
    }
}
