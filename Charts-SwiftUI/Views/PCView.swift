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
    @State private var category: Wine.Category = .variety

    var body: some View {
        VStack {
            PieChart(entries: Wine.winesForCategory(category, wines: Wine.allWines),
                     category: $category,
                     descriptionText: category.rawValue.capitalized)
                .frame(height: 400)
            Picker(selection: $category, label: Text("duh")) {
                Text("Varieties").tag(Wine.Category.variety)
                Text("Wineries").tag(Wine.Category.winery)
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
