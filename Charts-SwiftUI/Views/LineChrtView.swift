//
//  LineChrtView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-20.
//

import SwiftUI
import Charts

struct LineChrtView: View {
    @State private var year = 2019
    var body: some View {
        VStack {
            Text("My Wine Consumption")
                .font(.title)
            VStack {
                Text("Tap on a point to see information")
                Text("Swipe from right to see more months.")
            }
            .font(.caption)
            Picker(selection: $year, label: Text("Year"), content: {
                Text("2019").tag(2019)
                Text("2020").tag(2020)
            })
            .pickerStyle(SegmentedPickerStyle())
            LineChart(
                entriesIn: Transaction.lineChartDataForYear(year, transactions: Transaction.allTransactions, itemType: .itemIn),
                entriesOut: Transaction.lineChartDataForYear(year, transactions: Transaction.allTransactions, itemType: .itemOut))
                .frame(height: 400)
                .padding(.horizontal)
        }

    }
}

struct LineChrtView_Previews: PreviewProvider {
    static var previews: some View {
        LineChrtView()
    }
}
