//
//  GroupedBCView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-18.
//

import SwiftUI
import Charts

struct GroupedBCView: View {
    var entriesIn:[BarChartDataEntry] = SampleBarChartData.dataForYear(2019, itemType: .itemIn)
    var entriesOut:[BarChartDataEntry] = SampleBarChartData.dataForYear(2019, itemType: .itemOut)
    var body: some View {
        GroupedBarChart(entriesIn: entriesIn, entriesOut: entriesOut)
            .frame(height: 500)
    }
}

struct GroupedBCView_Previews: PreviewProvider {
    static var previews: some View {
        GroupedBCView()
    }
}
