//
//  CombinedChartView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-29.
//

import SwiftUI
import Charts

struct CombinedChrtView: View {
    @State private var quarter: Int = 0
    var body: some View {
        VStack {
            Text("Units Sold and Proceeds")
                .font(.title)
            Text("\(quarter == 0 ? "Swipe from right to see more months." : " ")")
                .font(.caption)
            Picker(selection: $quarter, label: Text("Quarter")) {
                Text("All").tag(0)
                Text("Q1").tag(1)
                Text("Q2").tag(2)
                Text("Q3").tag(3)
                Text("Q4").tag(4)
            }.pickerStyle(SegmentedPickerStyle())
        CombinedChart(barEntries: Sale.UnitsFor(Sale.allSales, quarter: quarter), lineEntries: Sale.TransactionsFor(Sale.allSales, quarter: quarter), quarter: $quarter)
            .frame(height: 400)
        }.padding(.horizontal)
    }
}

struct CombinedChrtView_Previews: PreviewProvider {
    static var previews: some View {
        CombinedChrtView()
    }
}
