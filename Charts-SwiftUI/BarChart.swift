//
//  BarChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-15.
//

import Charts
import SwiftUI

struct BarChart : UIViewRepresentable {
    var entries : [BarChartDataEntry]
    
    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        return chart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        formatLegend(legend: uiView.legend)
        formatXAxis(xaxis: uiView.xAxis)
        uiView.rightAxis.enabled = false
        formatYAxis(yaxis: uiView.leftAxis)
        uiView.noDataText = "No Data"
        let dataSet = BarChartDataSet(entries: entries, label: "My Bars")
        uiView.data = updateData(dataSet: dataSet)
        uiView.fitBars = true
        formatDataSet(dataSet: dataSet)
        uiView.notifyDataSetChanged()
        uiView.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .linear)
    }

    func updateData(dataSet: BarChartDataSet) -> BarChartData {
        let data = BarChartData(dataSet: dataSet)
        data.barWidth = 0.85

        return data
        
    }
    
    func formatDataSet(dataSet: BarChartDataSet) {
        let format = NumberFormatter()
        format.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: format)
        dataSet.highlightAlpha = 0.2
        dataSet.colors = [.red]
    }

    func formatYAxis(yaxis:YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        yaxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        yaxis.axisMinimum = 0
        yaxis.axisMaximum = 12
        yaxis.granularity = 1
        yaxis.labelTextColor =  .red
        yaxis.drawGridLinesEnabled = true
        
    }

    func formatXAxis(xaxis: XAxis) {
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
//        xaxis.valueFormatter = IndexAxisValueFormatter(values:["One","Two","Three","Four","Five"])
        xaxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        xaxis.labelTextColor =  .black
        xaxis.granularity = 1
    }
    
    func formatLegend(legend: Legend) {
        legend.textColor = UIColor.red
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 30.0
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(entries: [
            BarChartDataEntry(x: 0, y: 1),
            BarChartDataEntry(x: 1, y: 2),
            BarChartDataEntry(x: 2, y: 10),
            BarChartDataEntry(x: 3, y: 3),
            BarChartDataEntry(x: 4, y: 2)

        ])
    }
}
