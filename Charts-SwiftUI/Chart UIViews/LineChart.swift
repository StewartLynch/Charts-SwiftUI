//
//  LineChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-20.
//

import Charts
import SwiftUI

struct LineChart: UIViewRepresentable {
    // NOTE: No Coordinator or delegate functions in this example
    let lineChart = LineChartView()
    var entriesIn : [ChartDataEntry] // there is no LineChartDataEntry as I would have expected
    var entriesOut: [ChartDataEntry]
    func makeUIView(context: Context) -> LineChartView {
        return lineChart
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        setChartData(uiView)
        configureChart(uiView)
        formatXAxis(xAxis: uiView.xAxis)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatLegend(legend: uiView.legend)
        uiView.notifyDataSetChanged()
    }
    
    func setChartData(_ lineChart: LineChartView) {
        let dataSetIn = LineChartDataSet(entries: entriesIn)
        let dataSetOut = LineChartDataSet(entries: entriesOut)
        let dataSets: [LineChartDataSet] = [dataSetIn, dataSetOut]
        let lineChartData = LineChartData(dataSets: dataSets)
        lineChart.data = lineChartData
        formatDataSet(dataSet: dataSetIn, label: "Wine In", color: .red)
        formatDataSet(dataSet: dataSetOut, label: "Wine out", color: .blue)
    }
    
    func formatDataSet(dataSet: LineChartDataSet, label: String, color: UIColor) {
        dataSet.label = label
        dataSet.colors = [color]
        dataSet.valueColors = [color]
        dataSet.circleColors = [color]
        dataSet.circleRadius = 4
        dataSet.circleHoleRadius = 0
        dataSet.mode = .horizontalBezier
        dataSet.lineWidth = 4
        dataSet.lineDashLengths = [4]
        let format = NumberFormatter()
        format.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: format)
        dataSet.valueFont = UIFont.systemFont(ofSize: 12)
    }

    func configureChart(_ lineChart: LineChartView) {
        lineChart.noDataText = "No Data"
        lineChart.drawGridBackgroundEnabled = true
        lineChart.gridBackgroundColor = UIColor.tertiarySystemFill
        lineChart.drawBordersEnabled = true
        lineChart.rightAxis.enabled = false
        lineChart.setScaleEnabled(false)
        if lineChart.scaleX == 1.0 {
            lineChart.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        }
            lineChart.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .linear)
        let marker:BalloonMarker = BalloonMarker(color: UIColor.red, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
        marker.minimumSize = CGSize(width: 75, height: 35)
        lineChart.marker = marker
    }

    func formatXAxis(xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = IndexAxisValueFormatter(values:Transaction.monthArray)
        xAxis.labelTextColor =  .red
        xAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
        // Setting the max and min make sure that the markers are visible at the edges
        xAxis.axisMaximum = 12
        xAxis.axisMinimum = -1
    }
    
    func formatLeftAxis(leftAxis:YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelTextColor =  .red
        leftAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
    }

    func formatLegend(legend: Legend) {
        legend.textColor = UIColor.red
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 20.0
    }
}


struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart(
            entriesIn: Transaction.lineChartDataForYear(2019, transactions: Transaction.allTransactions, itemType: .itemIn),
            entriesOut: Transaction.lineChartDataForYear(2019, transactions: Transaction.allTransactions, itemType: .itemOut))
            .frame(height: 400)
            .padding(.horizontal)
    }
}
