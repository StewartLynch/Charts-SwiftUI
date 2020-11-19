//
//  ContentView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-15.
//

import SwiftUI
import Charts

struct ContentView: View {

    @State private var selectedItem:SampleBarChartData = SampleBarChartData.initialItem(year: 2020)
    @State private var barEntries: [BarChartDataEntry] = []
    var body: some View {
        VStack {
            Text("\(selectedItem.year)".replacingOccurrences(of: ",", with: ""))
                .font(.title2)
            Button("Change Year") {
                selectedItem.year = (selectedItem.year) == 2020 ? 2019 : 2020
                selectedItem.month = -1
            }
            BarChart(entries: SampleBarChartData.dataForYear(selectedItem.year), selectedItem: $selectedItem)
                .frame(height: 300)
            if selectedItem.month != -1 {
                Text("\(Int(selectedItem.quantity)) for \(SampleBarChartData.monthArray[Int(selectedItem.month)])")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
