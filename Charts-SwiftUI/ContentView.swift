//
//  ContentView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-15.
//

import SwiftUI
import Charts

struct ContentView: View {
    var dataSets:[[BarChartDataEntry]] = [
        [
            BarChartDataEntry(x: 0, y: 1),
            BarChartDataEntry(x: 1, y: 1),
            BarChartDataEntry(x: 2, y: 6),
            BarChartDataEntry(x: 3, y: 3),
            BarChartDataEntry(x: 4, y: 5)
        ], [
            
            BarChartDataEntry(x: 0, y: 10.2),
            BarChartDataEntry(x: 1, y: 3),
            BarChartDataEntry(x: 2, y: 4),
            BarChartDataEntry(x: 3, y: 1),
            BarChartDataEntry(x: 4, y: 3)
        ]
    ]
    
    @State private var barEntries: [BarChartDataEntry] = []
    @State private var firstDataSet = true
    var body: some View {
        VStack {
            Button("Update Chart") {
                firstDataSet.toggle()
            }
            BarChart(entries: firstDataSet ? dataSets[0] : dataSets[1])
                .frame(height: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
