//
//  GroupedBCView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-18.
//

import SwiftUI
import Charts

struct GroupedBCView: View {
    var entriesIn:[BarChartDataEntry] = []
    var entriesOut:[BarChartDataEntry] = []
    @State private var selectedItem:SampleBarChartData = SampleBarChartData.initialItem(year: 2019)
    var body: some View {
        VStack {
            Text("\(selectedItem.year)".replacingOccurrences(of: ",", with: ""))
                .font(.title2)
            Button("Change Year") {
                selectedItem.year = (selectedItem.year) == 2020 ? 2019 : 2020
                selectedItem.month = -1
            }
            GroupedBarChart(selectedItem: $selectedItem,
                            entriesIn: SampleBarChartData.dataForYear(selectedItem.year, itemType: .itemIn),
                            entriesOut: SampleBarChartData.dataForYear(selectedItem.year, itemType: .itemOut))
                .frame(height: 500)
            if selectedItem.month != -1 {
                Text("\(abs(Int(selectedItem.quantity))) items \(selectedItem.itemType == .itemIn ? "in" : "out") for \(SampleBarChartData.monthArray[Int(selectedItem.month)])")
            }
        }

    }
}

struct GroupedBCView_Previews: PreviewProvider {
    static var previews: some View {
        GroupedBCView()
    }
}
