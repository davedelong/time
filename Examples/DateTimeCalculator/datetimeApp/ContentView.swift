//
//  ContentView.swift
//  datetimecalculator
//
//  Created by Robert Dodson on 3/2/24.
//

import SwiftUI

import Time

struct ContentView: View
{
    @State var startSecond = Clocks.system.currentSecond
    @State var endSecond = Clocks.system.currentSecond + .days(1)
    
    var startColor = Color.green
    var endColor = Color.cyan
    
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            Text("From:")
                .font(.largeTitle)
                .foregroundColor(startColor)
            CalenderView(selectedSecond:$startSecond,color:startColor)
            
            Spacer()
            
            Text("To:")
                .font(.largeTitle)
                .foregroundColor(endColor)
            CalenderView(selectedSecond:$endSecond,color:endColor)
           
            Spacer()
            
            Text("Differences:")
                .font(.largeTitle)
            DifferencesView(startSecond:$startSecond,endSecond:$endSecond,startColor:startColor,endColor:endColor)
        }
        .frame(width: 400,height: 800)
        .padding()
    }
}



