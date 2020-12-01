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
            Text("\(year)".replacingOccurrences(of: ",", with: ""))
                .font(.title2)
            Button("Change Year") {
                year = (year == 2020) ? 2019 : 2020
            }
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
