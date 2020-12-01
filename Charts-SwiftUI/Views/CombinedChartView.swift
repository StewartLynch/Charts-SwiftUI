//
//  CombinedChartView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-29.
//

import SwiftUI
import Charts

struct CombinedChrtView: View {
    @State private var year: Int = 2020
    @State private var barEntries: [BarChartDataEntry] = []
    @State private var lineEntries: [ChartDataEntry] = []
    var body: some View {
        VStack {
            Picker(selection: $year, label: Text("Year")) {
                Text("2019").tag(2019)
                Text("2020").tag(2020)
            }.pickerStyle(SegmentedPickerStyle())
        CombinedChart(barEntries: Sale.UnitsFor(Sale.allSales, year: year), lineEntries: Sale.TransactionsFor(Sale.allSales, year: year), year: $year)
            .frame(height: 500)
        }.padding(.horizontal)
    }
}

struct CombinedChrtView_Previews: PreviewProvider {
    static var previews: some View {
        CombinedChrtView()
    }
}
