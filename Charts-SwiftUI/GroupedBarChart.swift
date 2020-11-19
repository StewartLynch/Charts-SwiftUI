//
//  GroupedBarChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-18.
//

import Charts
import SwiftUI

struct GroupedBarChart: UIViewRepresentable {
    var entriesIn: [BarChartDataEntry]
    var entriesOut: [BarChartDataEntry]
    let groupedBarChart = BarChartView()
    func makeUIView(context: Context) -> BarChartView {
        groupedBarChart.delegate = context.coordinator
        return groupedBarChart
    }

    func updateUIView(_ uiView: BarChartView, context: Context) {
        let dataSetIn = BarChartDataSet(entries: entriesIn)
        let dataSetOut = BarChartDataSet(entries: entriesOut)
        let dataSets:[BarChartDataSet] = [dataSetIn,dataSetOut]
        let chartData = BarChartData(dataSets: dataSets)
        uiView.data = chartData
        uiView.noDataText = "No Data"
        uiView.rightAxis.enabled = false
        uiView.setScaleEnabled(false)
        if uiView.scaleX == 1.0 {
            uiView.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        }
        let barWidth = 0.35
        let barSpace = 0.05
        let groupSpace = 0.2
        // (0.35 + 0.05) * 2 + 0.2 = 1.00 -> interval per "group"
        let groupCount = entriesIn.count
        let startMonth = 0.0
        chartData.barWidth = barWidth
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        uiView.xAxis.axisMinimum = startMonth
        uiView.xAxis.axisMaximum = 0 + gg * Double(groupCount)
        chartData.groupBars(fromX: Double(startMonth), groupSpace: groupSpace, barSpace: barSpace)
        formatXAxis(xAxis: uiView.xAxis)
        uiView.notifyDataSetChanged()
    }


    func formatXAxis(xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = IndexAxisValueFormatter(values:SampleBarChartData.monthArray)
        xAxis.labelTextColor =  .red
        xAxis.centerAxisLabelsEnabled = true
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

struct GroupedBarChart_Previews: PreviewProvider {
    static var previews: some View {
        GroupedBarChart(entriesIn: SampleBarChartData.dataForYear(2019, itemType: .itemIn), entriesOut: SampleBarChartData.dataForYear(2019, itemType: .itemOut))
    }
}
