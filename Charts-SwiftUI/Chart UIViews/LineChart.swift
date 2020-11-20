//
//  LineChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-20.
//

import Charts
import SwiftUI

struct LineChart: UIViewRepresentable {

    let lineChart = LineChartView()
    var entries : [ChartDataEntry] // there is no LineChartDataEntry as I would have expected
    func makeUIView(context: Context) -> LineChartView {
        lineChart.delegate = context.coordinator
        return lineChart
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        let dataSet = LineChartDataSet(entries: entries)
        let lineChartData = LineChartData(dataSet: dataSet)
        uiView.data = lineChartData
    }

    class Coordinator: NSObject, ChartViewDelegate {
        var parent: LineChart
            init(parent: LineChart) {
                self.parent = parent
            }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

}


struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart(entries: SampleBarChartData.lineChartDataForYear(2019, itemType: .itemIn))
            .frame(height: 400)
            .padding(.horizontal)

    }
}
