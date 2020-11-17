//
//  ContentView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-15.
//

import SwiftUI
import Charts

struct ContentView: View {

    @State private var selectedItem:SampleData = SampleData.initialItem(year: 2020)
    @State private var barEntries: [BarChartDataEntry] = []
    var body: some View {
        VStack {
            Text("\(selectedItem.year)".replacingOccurrences(of: ",", with: ""))
                .font(.title2)
            if selectedItem.month != -1 {
                Text("\(Int(selectedItem.quantity)) for \(SampleData.monthArray[Int(selectedItem.month)])")
            }
            Button("Change Year") {
                selectedItem.year = (selectedItem.year) == 2020 ? 2019 : 2020
                selectedItem.month = -1
            }
            BarChart(entries: SampleData.dataForYear(selectedItem.year), selectedItem: $selectedItem)
                .frame(height: 500)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
