//
//  IconButton.swift
//  MonthCalendar
//
//  Created by Tiago Lopes on 21/01/22.
//

import SwiftUI

// MARK: - View

struct IconButton: View {
    
    // MARK: Properties
    
    let iconName: String
    let action: () -> Void
    
    // MARK: Body
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: iconName)
        })
    }
}

// MARK: - Preview

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(iconName: "") {
            
        }
    }
}
