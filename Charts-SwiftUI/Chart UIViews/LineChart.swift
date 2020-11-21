//
//  LineChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-20.
//

import Charts
import SwiftUI

struct LineChart: UIViewRepresentable {
    @Binding var selectedItem: SampleBarChartData
    let lineChart = LineChartView()
    var entriesIn : [ChartDataEntry] // there is no LineChartDataEntry as I would have expected
    var entriesOut: [ChartDataEntry]
    func makeUIView(context: Context) -> LineChartView {
        return lineChart
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        let dataSetIn = LineChartDataSet(entries: entriesIn)
        let dataSetOut = LineChartDataSet(entries: entriesOut)
        let dataSets: [LineChartDataSet] = [dataSetIn, dataSetOut]
        let lineChartData = LineChartData(dataSets: dataSets)
        uiView.data = lineChartData
        configureChart(uiView)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatXAxis(xAxis: uiView.xAxis)
        formatLegend(legend: uiView.legend)
        formatDataSet(dataSet: dataSetIn, label: "Wine In", color: .red)
        formatDataSet(dataSet: dataSetOut, label: "Wine out", color: .blue)
        uiView.notifyDataSetChanged()
    }

    func configureChart(_ lineChart: LineChartView) {
        lineChart.drawGridBackgroundEnabled = true
        lineChart.gridBackgroundColor = UIColor.tertiarySystemFill
        lineChart.drawBordersEnabled = true
        lineChart.rightAxis.enabled = false
        lineChart.setScaleEnabled(false)
        if lineChart.scaleX == 1.0 {
            lineChart.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        }
        if selectedItem.month == -1 {
            lineChart.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .linear)
            lineChart.highlightValue(nil, callDelegate: false)
        }
        let marker:BalloonMarker = BalloonMarker(color: UIColor.red, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
        marker.minimumSize = CGSize(width: 75, height: 35)
        lineChart.marker = marker
    }

    func formatLeftAxis(leftAxis:YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelTextColor =  .red
        leftAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
    }

    func formatXAxis(xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = IndexAxisValueFormatter(values:SampleBarChartData.monthArray)
        xAxis.labelTextColor =  .red
        xAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
    }

    func formatLegend(legend: Legend) {
        legend.textColor = UIColor.red
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 20.0
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
}


struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart(selectedItem: .constant(SampleBarChartData.selectedItem), entriesIn: SampleBarChartData.lineChartDataForYear(2019, itemType: .itemIn), entriesOut: SampleBarChartData.lineChartDataForYear(2019, itemType: .itemOut))
            .frame(height: 400)
            .padding(.horizontal)

    }
}
