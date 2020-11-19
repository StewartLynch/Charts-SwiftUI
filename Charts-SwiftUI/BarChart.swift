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
    let chart = BarChartView()
    @Binding var selectedItem: SampleData
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
        xAxis.valueFormatter = IndexAxisValueFormatter(values:SampleData.monthArray)
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
        BarChart(entries: SampleData.dataForYear(2020), selectedItem: .constant(SampleData.selectedItem))
    }
}


struct SampleData {
    var year: Int
    var month: Double
    var quantity: Double
    
    static var selectedItem = SampleData(year: 2020, month: -1, quantity: -1)
    static func initialItem(year: Int) -> SampleData {
        SampleData(year: year, month: -1, quantity: -1)
    }
    static var monthArray = ["Jan","Feb","Mar","Apr","May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    static func dataForYear(_ year: Int) -> [BarChartDataEntry] {
        let yearData = SampleData.mySamples.filter{$0.year == year}
        return yearData.map{BarChartDataEntry(x: $0.month, y: $0.quantity)}
    }

    static var mySamples:[SampleData] {
        [
            SampleData(year: 2019, month: 0, quantity: 86),
            SampleData(year: 2019, month: 1, quantity: 15),
            SampleData(year: 2019, month: 2, quantity: 50),
            SampleData(year: 2019, month: 3, quantity: 62),
            SampleData(year: 2019, month: 4, quantity: 20),
            SampleData(year: 2019, month: 5, quantity: 19),
            SampleData(year: 2019, month: 6, quantity: 71),
            SampleData(year: 2019, month: 7, quantity: 52),
            SampleData(year: 2019, month: 8, quantity: 33),
            SampleData(year: 2019, month: 9, quantity: 75),
            SampleData(year: 2019, month: 10, quantity: 20),
            SampleData(year: 2019, month: 11, quantity: 90),
            SampleData(year: 2020, month: 0, quantity: 43),
            SampleData(year: 2020, month: 1, quantity: 0),
            SampleData(year: 2020, month: 2, quantity: 22),
            SampleData(year: 2020, month: 3, quantity: 15),
            SampleData(year: 2020, month: 4, quantity: 88),
            SampleData(year: 2020, month: 5, quantity: 7),
            SampleData(year: 2020, month: 6, quantity: 0),
            SampleData(year: 2020, month: 7, quantity: 0),
            SampleData(year: 2020, month: 8, quantity: 0),
            SampleData(year: 2020, month: 9, quantity: 0),
            SampleData(year: 2020, month: 10, quantity: 0),
            SampleData(year: 2020, month: 11, quantity: 0)
        ]
    }

}
