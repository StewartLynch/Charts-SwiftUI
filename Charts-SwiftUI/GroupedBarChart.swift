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
    let barWidth = 0.35
    let barSpace = 0.05
    let groupSpace = 0.2
    let startX:Double = 0
    func makeUIView(context: Context) -> BarChartView {
        groupedBarChart.delegate = context.coordinator
        return groupedBarChart
    }

    func updateUIView(_ uiView: BarChartView, context: Context) {
        uiView.noDataText = "No Data"
        let dataSetIn = BarChartDataSet(entries: entriesIn)
        let dataSetOut = BarChartDataSet(entries: entriesOut)
        let dataSets:[BarChartDataSet] = [dataSetIn,dataSetOut]
        let chartData = BarChartData(dataSets: dataSets)
        uiView.data = chartData
        uiView.rightAxis.enabled = false
        uiView.setScaleEnabled(false)
        if uiView.scaleX == 1.0 {
            uiView.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        }
        formatLegend(legend: uiView.legend)
        formatDataSet(dataSet: dataSetIn, label: "Purchased", color: .red)
        formatDataSet(dataSet: dataSetOut, label: "Consumed", color: .blue)
        let gw = formatChartDataReturnGroupWidth(chartData: chartData)
        formatXAxis(xAxis: uiView.xAxis, groupWidth: gw)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        uiView.notifyDataSetChanged()
    }

    func formatChartDataReturnGroupWidth(chartData: BarChartData) -> Double {
        // (barWidth + barSpace) * 2 + 0.2 = 1.00 -> interval per "group"
        chartData.barWidth = barWidth
        // fromX is your lowest x value
        chartData.groupBars(fromX: startX, groupSpace: groupSpace, barSpace: barSpace)
        // return the groupWidth as it is necessary for the xAxis
        return chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)

    }

    func formatLeftAxis(leftAxis:YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelTextColor =  .red
    }

    func formatDataSet(dataSet: BarChartDataSet, label: String, color: UIColor) {
        dataSet.label = label
        dataSet.highlightAlpha = 0.2
        dataSet.colors = [color]
        let format = NumberFormatter()
        dataSet.valueColors = [color]
        format.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: format)
    }

    func formatXAxis(xAxis: XAxis, groupWidth: Double) {
        xAxis.axisMaximum = startX + groupWidth * Double(entriesIn.count)
        xAxis.axisMinimum = startX
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = IndexAxisValueFormatter(values:SampleBarChartData.monthArray)
        xAxis.labelTextColor =  .red
        xAxis.centerAxisLabelsEnabled = true
    }

    func formatLegend(legend: Legend) {
        legend.textColor = UIColor.red
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 30.0
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
