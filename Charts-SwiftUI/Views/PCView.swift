//
//  PCView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-19.
//

import SwiftUI
import Charts

struct PCView: View {
    @State private var pieChartEntries: [PieChartDataEntry] = []
    @State private var category: SamplePieChartData.Category = .variety

    var body: some View {
        VStack {
            PieChart(entries: SamplePieChartData.entriesForCategory(category),
                     category: $category,
                     descriptionText: category.rawValue.capitalized)
                .frame(height: 400)
            Picker(selection: $category, label: Text("duh")) {
                Text("Varieties").tag(SamplePieChartData.Category.variety)
                Text("Wineries").tag(SamplePieChartData.Category.winery)
            }.pickerStyle(SegmentedPickerStyle())
        }
        .padding(.horizontal)

    }
}

struct PCView_Previews: PreviewProvider {
    static var previews: some View {
        PCView()
    }
}
