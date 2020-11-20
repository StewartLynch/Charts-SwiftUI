//
//  BarChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-15.
//

import Charts
import SwiftUI

struct BarChart : UIViewRepresentable {
    @Binding var selectedItem: SampleBarChartData
    var entries : [BarChartDataEntry]
    let chart = BarChartView()
    func makeUIView(context: Context) -> BarChartView {
        chart.delegate = context.coordinator
        return chart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        let dataSet = BarChartDataSet(entries: entries)
        let barChartData = BarChartData(dataSet: dataSet)
        uiView.data = barChartData
        uiView.noDataText = "No Data"
        uiView.rightAxis.enabled = false
        uiView.setScaleEnabled(false)
        if uiView.scaleX == 1.0 {
            uiView.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        }
        if selectedItem.month == -1 {
            uiView.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .linear)
            uiView.highlightValue(nil, callDelegate: false)
        }
        uiView.fitBars = true
        formatData(data: barChartData)
        formatDataSet(dataSet: dataSet)
        formatLegend(legend: uiView.legend)
        formatXAxis(xAxis: uiView.xAxis)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        // Necessary to refresh legend formnat
        uiView.notifyDataSetChanged()
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        let parent: BarChart
        init(parent: BarChart) {
            self.parent = parent
        }
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            parent.selectedItem.month = entry.x
            parent.selectedItem.quantity = entry.y
            
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func updateData(dataSet: BarChartDataSet) -> BarChartData {
        let data = BarChartData(dataSet: dataSet)
        data.barWidth = 0.85 // Default
        return data
    }
    
    func formatDataSet(dataSet: BarChartDataSet) {
        dataSet.label = "My Bars"
        dataSet.highlightAlpha = 0.2
        dataSet.colors = [.red]
        let format = NumberFormatter()
        format.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: format)
    }

    func formatData(data:BarChartData) {
        data.barWidth = 0.85
    }

    func formatLeftAxis(leftAxis:YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.axisMinimum = 0
        leftAxis.labelTextColor =  .red
    }

    func formatXAxis(xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = IndexAxisValueFormatter(values:SampleBarChartData.monthArray)
        xAxis.labelTextColor =  .red
    }
    
    func formatLegend(legend: Legend) {
        legend.textColor = UIColor.red
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 30.0
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(selectedItem: .constant(SampleBarChartData.selectedItem), entries: SampleBarChartData.dataForYear(2020))
    }
}
