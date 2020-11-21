//
//  LineChrtView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-20.
//

import SwiftUI
import Charts

struct LineChrtView: View {
    var entriesIn:[ChartDataEntry] = []
    var entriesOut:[ChartDataEntry] = []
    @State private var year = 2019
    var body: some View {
        VStack {
            Text("\(year)".replacingOccurrences(of: ",", with: ""))
                .font(.title2)
            Button("Change Year") {
                year = (year == 2020) ? 2019 : 2020
            }
            LineChart(
                entriesIn: SampleBarChartData.lineChartDataForYear(year, itemType: .itemIn),
                entriesOut: SampleBarChartData.lineChartDataForYear(year, itemType: .itemOut))
                .frame(height: 500)
                .padding(.horizontal)
        }

    }
}

struct LineChrtView_Previews: PreviewProvider {
    static var previews: some View {
        LineChrtView()
    }
}
