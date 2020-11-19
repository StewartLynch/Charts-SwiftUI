//
//  GroupedBarChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-18.
//

import Charts
import SwiftUI

struct GroupedBarChart: UIViewRepresentable {

    let groupedBarChart = BarChartView()
    func makeUIView(context: Context) -> BarChartView {
        groupedBarChart.delegate = context.coordinator
        return groupedBarChart
    }

    func updateUIView(_ uiView: BarChartView, context: Context) {

    }


    class Coordinator: NSObject, ChartViewDelegate {
        let parent: GroupedBarChart
        init(parent: GroupedBarChart) {
            self.parent = parent
        }

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

}
